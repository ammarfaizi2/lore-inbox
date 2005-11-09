Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbVKISjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbVKISjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbVKISiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:38:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:34461 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751499AbVKISiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:38:07 -0500
Date: Wed, 9 Nov 2005 10:37:18 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ink@jurassic.park.msu.ru,
       viro@ftp.linux.org.uk
Subject: [patch 11/11] fix alpha breakage
Message-ID: <20051109183718.GL3670@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-alpha-breakage.patch"
In-Reply-To: <20051109183614.GA3670@kroah.com>
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
