Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbTHZTzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTHZTzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:55:47 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:10307 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261636AbTHZTzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:55:45 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Steven Cole <elenstev@mesatop.com>
To: Oleg Drokin <green@namesys.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Alex Zarochentsev <zam@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826194321.GA25730@namesys.com>
References: <20030826102233.GA14647@namesys.com>
	 <1061922037.1670.3.camel@spc9.esa.lanl.gov>
	 <20030826182609.GO5448@backtop.namesys.com>
	 <1061926566.1076.2.camel@teapot.felipe-alfaro.com>
	 <20030826194321.GA25730@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061927482.1666.36.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 26 Aug 2003 13:51:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 13:43, Oleg Drokin wrote:
> Hello!
> 
> On Tue, Aug 26, 2003 at 09:36:07PM +0200, Felipe Alfaro Solana wrote:
> > > Disable "reiser4 system call" (CONFIG_REISER4_FS_SYSCALL) support, it is 
> > > not ready.
> > [...]
> > arch/i386/kernel/built-in.o(.data+0x7c4): In function `sys_call_table':
> > : undefined reference to `sys_reiser4'
> > make[2]: *** [.tmp_vmlinux1] Error 1
> > make[1]: *** [vmlinux] Error 2
> > [...]
> > CONFIG_REISER4_FS=m
> 
> Building as module is also not yet supported.
> 
Fine, then here's a patch:

--- linux-2.6.0-test4-r4/fs/Kconfig.orig	2003-08-26 13:44:38.165059616 -0600
+++ linux-2.6.0-test4-r4/fs/Kconfig	2003-08-26 13:46:43.672979512 -0600
@@ -203,6 +203,9 @@
 	tristate "Reiser4 (EXPERIMENTAL very fast general purpose filesystem)"
 	depends on EXPERIMENTAL
 	---help---
+	  Building as a module is not yet supported, so don't say 'M'
+          unless you're a developer.
+
 	  Reiser4 is more than twice as fast for both reads and writes as
 	  ReiserFS.  That means it is four times as fast as NTFS by Microsoft.
 	  (Proper benchmarks will appear in a few months at

Meanwhile, reiser4 seems to be working fine and is nice and fast.

I did a "time bk -r co" for the current 2.6 tree, and here
are the results for reiser4 and ext3 on 2.6.0-test4:

Reiser4:
real    1m55.077s
user    0m30.740s
sys     0m36.558s

Ext3:
real    3m48.438s
user    0m26.400s
sys     0m13.205s

Steven


