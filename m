Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVKRBsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVKRBsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVKRBs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:48:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60550 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750709AbVKRBs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:48:29 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [2.6 patch] i386 KEXEC must depend on X86_CMPXCHG64
References: <20051117235700.GJ11494@stusta.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 17 Nov 2005 18:47:27 -0700
In-Reply-To: <20051117235700.GJ11494@stusta.de> (Adrian Bunk's message of
 "Fri, 18 Nov 2005 00:57:00 +0100")
Message-ID: <m14q6aohg0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch fixes the following compile error with 
> CONFIG_X86_CMPXCHG64=n:
>
> <--  snip  -->
>
> ...
>   CC      arch/i386/kernel/machine_kexec.o
> arch/i386/kernel/machine_kexec.c: In function 'identity_map_page':
> arch/i386/kernel/machine_kexec.c:78: error: implicit declaration of function
> 'set_64bit'
> make[1]: *** [arch/i386/kernel/machine_kexec.o] Error 1
>
> <--  snip  -->

Good catch but wrong fix.  This code works fine on a 386.  Or
it did last time I tried it.

This dependency only exists if 3 level page tables are configured.
CONFIG_X86_PAE

The call to set_64bit is a specialized version of set_pmd.
Which also uses set_64_bit.  So I don't see how your kernel can
even build without this.

The only way I can see this even being selected is building
a kernel for a 386 or 486 and wanting pae support.  Which won't
work on a 386 or a 486.  Making it a pointless exercise.

So I think either the pgtable-3level.h needs to fixed,
or we just make CONFIG_HIGHME64G depend on CONFIG_X86_CMPXCHG64.

Eric
