Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWBCB1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWBCB1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWBCB1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:27:51 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:28487 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932329AbWBCB1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:27:48 -0500
Date: Fri, 3 Feb 2006 10:27:35 +0900
To: Rune Torgersen <runet@innovsys.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
       David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
       Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
       Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Linus Torvalds <torvalds@osdl.org>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Hirokazu Takata <takata@linux-m32r.org>,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-m68k@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
       dev-etrax@axis.com, ultralinux@vger.kernel.org, Andi Kleen <ak@suse.de>,
       linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
       Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org,
       akpm@osdl.org, Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] fix generic_fls64()
Message-ID: <20060203012735.GA21567@miraclelinux.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859547@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859547@ismail.innsys.innovsys.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed by Rune Torgersen.

fix generic_fls64().
tcp_cubic is using fls64().

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/bitops.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/include/linux/bitops.h
===================================================================
--- 2.6-git.orig/include/linux/bitops.h
+++ 2.6-git/include/linux/bitops.h
@@ -81,7 +81,7 @@ static inline int generic_fls64(__u64 x)
 {
 	__u32 h = x >> 32;
 	if (h)
-		return fls(x) + 32;
+		return fls(h) + 32;
 	return fls(x);
 }
 
