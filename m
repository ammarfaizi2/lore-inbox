Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWHTKYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWHTKYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWHTKYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:24:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16056 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750700AbWHTKYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:24:49 -0400
Date: Sun, 20 Aug 2006 12:24:04 +0200 (MEST)
Message-Id: <200608201024.k7KAO4i5023339@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: w@1wt.eu
Subject: Re: [PATCH 2.4.34-pre1] fix x86_64 etc build failure due to memchr change
Cc: ak@suse.de, davem@davemloft.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 03:31:09 +0200, Willy Tarreau wrote:
>On Sun, Aug 20, 2006 at 12:19:06AM +0200, Mikael Pettersson wrote:
>> 2.4.34-pre1 doesn't build on x86_64:
>> 
>> kernel/kernel.o(__ksymtab+0x1c10): multiple definition of `__ksymtab_memchr'
>> arch/x86_64/kernel/kernel.o(__ksymtab+0x3f0): first defined here
>> kernel/kernel.o(.kstrtab+0x3960): multiple definition of `__kstrtab_memchr'
>> arch/x86_64/kernel/kernel.o(.kstrtab+0x5fd): first defined here
>> ld: Warning: size of symbol `__kstrtab_memchr' changed from 7 in arch/x86_64/kernel/kernel.o to 17 in kernel/kernel.o
>> make: *** [vmlinux] Error 1
>> 
>> This is because the 'export memchr() which is used by smbfs and lp driver'
>> change in 2.4.34-pre1 added an EXPORT_SYMBOL of memchr to kernel/ksyms.c
>> without also removing the existing one in arch/x86_64/kernel/x8664_ksyms.c.
>> Alpha, ARM, ppc32, and SH also have EXPORTs of memchr so they probably
>> also broke.
>> 
>> This patch removes the EXPORTs of memchr under arch/, which fixes x86_64
>> and should fix the other architectures as well.
>
>OK Mikael,
>
>I have fixed sparc and sparc64 instead, and it's OK now without having to
>export memchr() in kernel/ksyms.c. So the fix is shorter and more logical.
>It brings non-sparc architectures to their state before my wrong fix. However,
>sparc needs to export memchr() for smbfs and lp.

Works for me. Tested on i386, x86_64, and ppc32. I'll try to test on sparc64
later today.

/Mikael
