Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTJRP0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJRP0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:26:49 -0400
Received: from holomorphy.com ([66.224.33.161]:58251 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261678AbTJRP0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:26:46 -0400
Date: Sat, 18 Oct 2003 08:26:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Giese <Thomas.Giese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-microcode
Message-ID: <20031018152642.GJ25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Giese <Thomas.Giese@gmx.de>, linux-kernel@vger.kernel.org
References: <008c01c39588$9b6f7650$fb457dc0@tgasterix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008c01c39588$9b6f7650$fb457dc0@tgasterix>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 05:00:44PM +0200, Thomas Giese wrote:
> IA32 microcode fails in compile, in test7 it does not :
> linux:/mnt/hdb1/linux-2.6.0-test8 # make
>   SPLIT   include/linux/autoconf.h -> include/config/*
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC [M]  arch/i386/kernel/microcode.o
> arch/i386/kernel/microcode.c: In function `find_matching_ucodes':
> arch/i386/kernel/microcode.c:328: parse error before `int'
> arch/i386/kernel/microcode.c:329: `ext_tablep' undeclared (first use in this
> fun
> ction)
> arch/i386/kernel/microcode.c:329: (Each undeclared identifier is reported
> only o
> nce
> arch/i386/kernel/microcode.c:329: for each function it appears in.)
> make[1]: *** [arch/i386/kernel/microcode.o] Error 1
> make: *** [arch/i386/kernel] Error 2

Hmm, you're supposed to declare variables before any code appears in C.
Maybe all this C99 stuff is turning it into C++.


-- wli


diff -prauN linux-2.6.0-test8/arch/i386/kernel/microcode.c microcode-2.6.0-test8-1/arch/i386/kernel/microcode.c
--- linux-2.6.0-test8/arch/i386/kernel/microcode.c	2003-10-17 14:42:56.000000000 -0700
+++ microcode-2.6.0-test8-1/arch/i386/kernel/microcode.c	2003-10-18 08:21:06.000000000 -0700
@@ -323,9 +323,10 @@ static int find_matching_ucodes (void) 
 					memcpy(newmc, &mc_header, MC_HEADER_SIZE);
 					/* check extended table checksum */
 					if (ext_table_size) {
+						int *ext_tablep;
 						int ext_table_sum = 0;
 						i = ext_table_size / DWSIZE;
-						int * ext_tablep = (((void *) newmc) + MC_HEADER_SIZE + data_size);
+						ext_tablep = (((void *) newmc) + MC_HEADER_SIZE + data_size);
 						while (i--) ext_table_sum += ext_tablep[i];
 						if (ext_table_sum) {
 							printk(KERN_WARNING "microcode: aborting, bad extended signature table checksum\n");
