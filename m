Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTJHUE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJHUE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 16:04:57 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50993 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261764AbTJHUEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 16:04:55 -0400
Date: Wed, 8 Oct 2003 21:04:20 +0100
From: Dave Jones <davej@redhat.com>
To: Nuno Monteiro <nmonteiro@uk2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linking problem with 2.6.0-test6-bk10
Message-ID: <20031008200420.GA23545@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nuno Monteiro <nmonteiro@uk2.net>, linux-kernel@vger.kernel.org
References: <42450.212.113.164.100.1065637962.squirrel@maxproxy1.uk2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42450.212.113.164.100.1065637962.squirrel@maxproxy1.uk2net.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 07:32:42PM +0100, Nuno Monteiro wrote:

 >         ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s
 > arch/i386/kernel/head.o arch/i386/kernel/init_task.o  
 > init/built-in.o --start-group  usr/built-in.o 
 > arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
 > arch/i386/mach-default/built-in.o  kernel/built-in.o 
 > mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o 
 > crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  lib/built-in.o 
 > arch/i386/lib/built-in.o  drivers/built-in.o  sound/built-in.o 
 > arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
 > arch/i386/kernel/built-in.o(.init.text+0x2ebd): In function
 > `centaur_mcr_insert':
 > : undefined reference to `mtrr_centaur_report_mcr'
 > make: *** [vmlinux] Error 1

Try this.

		Dave

diff -Nru a/arch/i386/kernel/cpu/centaur.c b/arch/i386/kernel/cpu/centaur.c
--- a/arch/i386/kernel/cpu/centaur.c	Wed Oct  8 21:04:03 2003
+++ b/arch/i386/kernel/cpu/centaur.c	Wed Oct  8 21:04:03 2003
@@ -8,6 +8,8 @@
 
 #ifdef CONFIG_X86_OOSTORE
 
+extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
+
 static u32 __init power2(u32 x)
 {
 	u32 s=1;

-- 
 Dave Jones     http://www.codemonkey.org.uk
