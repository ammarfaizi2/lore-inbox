Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264992AbUFAL36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbUFAL36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUFAL36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:29:58 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:58852 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265002AbUFAL3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:29:34 -0400
Date: Tue, 01 Jun 2004 20:28:39 +0900
From: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Subject: Re: 2.6.7-rc2-mm1
In-reply-to: <200406011159.23532@zodiac.zodiac.dnsalias.org>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <20040601202839.01c8a220.akiyama.nobuyuk@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040601021539.413a7ad7.akpm@osdl.org>
 <200406011159.23532@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2004 11:59:23 +0200
Alexander Gran <alex@zodiac.dnsalias.org> wrote:

> Am Dienstag, 1. Juni 2004 11:15 schrieben Sie:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6
> >.7-rc2-mm1/
> 
> > +nmi-trigger-switch-support-for-debugging.patch
> >
> >  Support NMI-generating front-panel switches on x86
> 
> Perhaps that broke compiling here:
> 
> ...
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.data+0xc0c): undefined reference to `unknown_nmi_panic'
> kernel/built-in.o(.data+0xc1c): undefined reference to 
> `proc_unknown_nmi_panic'
> make: *** [.tmp_vmlinux1] Error 1
> 
> config attached, plain 2.6.7-rc2-mm1, only with dsdt patch for my laptop.

Please try the patch below.

diff -Nur linux-2.6.7-rc2-mm1.org/kernel/sysctl.c linux-2.6.7-rc2-mm1/kernel/sysctl.c
--- linux-2.6.7-rc2-mm1.org/kernel/sysctl.c	2004-06-01 19:47:22.000000000 +0900
+++ linux-2.6.7-rc2-mm1/kernel/sysctl.c	2004-06-01 20:21:13.000000000 +0900
@@ -63,7 +63,7 @@
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 
-#if defined(__i386__)
+#ifdef CONFIG_X86
 extern int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
 				  void __user *, size_t *);
@@ -624,7 +624,7 @@
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
-#if defined(__i386__)
+#ifdef CONFIG_X86
 	{
 		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
 		.procname       = "unknown_nmi_panic",


