Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWAYLeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWAYLeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWAYLeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:34:44 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:2203 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751144AbWAYLem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:34:42 -0500
Date: Wed, 25 Jan 2006 20:34:46 +0900
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: [PATCH 5/6] fix warning on test_ti_thread_flag()
Message-ID: <20060125113446.GF18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125112625.GA18584@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the arechitecture is
- BITS_PER_LONG == 64
- struct thread_info.flag 32 is bits
- second argument of test_bit() was void *

Then compiler print error message on test_ti_thread_flags()
in include/linux/thread_info.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
---
 thread_info.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/include/linux/thread_info.h
===================================================================
--- 2.6-git.orig/include/linux/thread_info.h	2006-01-25 19:07:12.000000000 +0900
+++ 2.6-git/include/linux/thread_info.h	2006-01-25 19:14:26.000000000 +0900
@@ -49,7 +49,7 @@
 
 static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 {
-	return test_bit(flag,&ti->flags);
+	return test_bit(flag, (void *)&ti->flags);
 }
 
 #define set_thread_flag(flag) \
