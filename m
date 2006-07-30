Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWG3Kwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWG3Kwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWG3Kwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:52:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49820 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932259AbWG3Kwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:52:40 -0400
Date: Sun, 30 Jul 2006 12:52:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] Begin abstraction of sensitive instructions: asm files
Message-ID: <20060730105228.GA5810@elf.ucw.cz>
References: <1153527274.13699.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153527274.13699.36.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-07-22 10:14:34, Rusty Russell wrote:
> (forgot to send this to lkml before)
> 
> Abstract sensitive instructions in assembler code, replacing them with
> macros (which currently are #defined to the native versions).  We use
> long names: assembler is case-insensitive, so if something goes wrong
> and macros do not expand, it would assemble anyway.
> 
> Resulting object files are exactly the same as before.
> 
> Signed-off-by Rusty Russell <rusty@rustcorp.com.au>
> 
> Index: working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/entry.S
> ===================================================================
> --- working-2.6.18-rc2-hg-paravirt.orig/arch/i386/kernel/entry.S	2006-07-21 21:09:22.000000000 +1000
> +++ working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/entry.S	2006-07-22 04:32:25.000000000 +1000
> @@ -76,8 +76,15 @@
>  NT_MASK		= 0x00004000
>  VM_MASK		= 0x00020000
>  
> +/* These are replaces for paravirtualization */
> +#define DISABLE_INTERRUPTS		cli
> +#define ENABLE_INTERRUPTS		sti
> +#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
> +#define INTERRUPT_RETURN		iret

Could we use some less verbose names, like possibly CLI, STI,
STI_SYSEXIT, IRET ?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
