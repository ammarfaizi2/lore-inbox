Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbVLWW3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbVLWW3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVLWW3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:29:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:52936 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161077AbVLWW2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:28:47 -0500
Date: Fri, 23 Dec 2005 14:28:12 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ink@jurassic.park.msu.ru,
       viro@ftp.linux.org.uk
Subject: [patch 11/11] fix alpha breakage
Message-ID: <20051223222812.GL18252@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-alpha-breakage.patch"
In-Reply-To: <20051223222652.GA18252@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

barrier.h uses barrier() in non-SMP case.  And doesn't include compiler.h.

Cc: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/asm-alpha/barrier.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.14.1.orig/include/asm-alpha/barrier.h
+++ linux-2.6.14.1/include/asm-alpha/barrier.h
@@ -1,6 +1,8 @@
 #ifndef __BARRIER_H
 #define __BARRIER_H
 
+#include <asm/compiler.h>
+
 #define mb() \
 __asm__ __volatile__("mb": : :"memory")
 

--
