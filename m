Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWGVD2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWGVD2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 23:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWGVD2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 23:28:33 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:51113 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751262AbWGVD2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 23:28:32 -0400
Date: Fri, 21 Jul 2006 23:23:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 5/6] Begin abstraction of sensitive instructions:
  asm files
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607212326_MC3-1-C5B8-F9ED@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To:<1153527274.13699.36.camel@localhost.localdomain>

On Sat, 22 Jul 2006 10:14:34 +1000, Rusty Russell wrote:
>
> Abstract sensitive instructions in assembler code, replacing them with
> macros (which currently are #defined to the native versions).  We use
> long names: assembler is case-insensitive, so if something goes wrong
> and macros do not expand, it would assemble anyway.
...
> --- working-2.6.18-rc2-hg-paravirt.orig/arch/i386/kernel/entry.S      2006-07-21 21:09:22.000000000 +1000
> +++ working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/entry.S   2006-07-22 04:32:25.000000000 +1000
> @@ -76,8 +76,15 @@
>  NT_MASK              = 0x00004000
>  VM_MASK              = 0x00020000
>  
> +/* These are replaces for paravirtualization */
> +#define DISABLE_INTERRUPTS           cli
> +#define ENABLE_INTERRUPTS            sti
> +#define ENABLE_INTERRUPTS_SYSEXIT    sti; sysexit
> +#define INTERRUPT_RETURN             iret
> +#define GET_CR0                      movl %cr0, %eax
> +
 
Could you change GET_CR0 to MOV_CR0_EAX?  GET_CR0 seems like it's
taking a reference or something.

-- 
Chuck
And did we tell you the name of the game, boy, we call it Riding the Gravy Train.
