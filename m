Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263750AbTCUTTS>; Fri, 21 Mar 2003 14:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263739AbTCUTSA>; Fri, 21 Mar 2003 14:18:00 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63245
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263735AbTCUTRI>; Fri, 21 Mar 2003 14:17:08 -0500
Subject: Re: [PATCH] arch-independent syscalls to return long
From: Robert Love <rml@tech9.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@digeo.com, Linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
In-Reply-To: <1048274593.4908.26.camel@phantasy.awol.org>
References: <3E7AAD0C.B8CB2926@verizon.net>
	 <20030320222358.454a1f4f.akpm@digeo.com>
	 <1048229509.2026.19.camel@phantasy.awol.org>
	 <20030321104649.5d8f5c62.rddunlap@osdl.org>
	 <1048274593.4908.26.camel@phantasy.awol.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048274891.4908.28.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 21 Mar 2003 14:28:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 14:23, Robert Love wrote:

> I always that it did not matter, but Arjan just pointed out
> otherwise (as you saw).  So I guess these need to be reverted.

And here is a patch to do so.

This patch, against 2.5.65 + the previous two, replaces the missing
asmlinkage on prototypes.

	Robert Love


 drivers/message/fusion/mptctl.c |    3 ++-
 net/compat.c                    |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)


diff -urN linux-2.5.65/drivers/message/fusion/mptctl.c linux/drivers/message/fusion/mptctl.c
--- linux-2.5.65/drivers/message/fusion/mptctl.c	2003-03-21 14:23:30.878772704 -0500
+++ linux/drivers/message/fusion/mptctl.c	2003-03-21 14:24:24.599605896 -0500
@@ -2743,7 +2743,8 @@
 						      unsigned long,
 						      struct file *));
 int unregister_ioctl32_conversion(unsigned int cmd);
-extern long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+extern asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
+				 unsigned long arg);
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /* sparc32_XXX functions are used to provide a conversion between
diff -urN linux-2.5.65/net/compat.c linux/net/compat.c
--- linux-2.5.65/net/compat.c	2003-03-21 14:23:31.000000000 -0500
+++ linux/net/compat.c	2003-03-21 14:25:03.000000000 -0500
@@ -365,8 +365,8 @@
 	kmsg->msg_control = (void *) orig_cmsg_uptr;
 }
 
-extern long sys_setsockopt(int fd, int level, int optname,
-			   char *optval, int optlen);
+extern asmlinkage long sys_setsockopt(int fd, int level, int optname,
+				      char *optval, int optlen);
 
 static int do_netfilter_replace(int fd, int level, int optname,
 				char *optval, int optlen)



