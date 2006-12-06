Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758687AbWLFAZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687AbWLFAZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbWLFAZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:25:45 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2325 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758687AbWLFAZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:25:44 -0500
Date: Wed, 6 Dec 2006 00:25:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: More ARM binutils fuckage
Message-ID: <20061206002536.GL24038@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20061205193357.GF24038@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205193357.GF24038@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 07:33:57PM +0000, Russell King wrote:
> There's not much to say about this, other than scream and go hide in the
> corner.  ARM toolchains are just basically fscked.
> 
>   arm-linux-ld -EL  -p --no-undefined -X -o .tmp_vmlinux1 -T
>  arch/arm/kernel/vmlinux.lds arch/arm/kernel/head.o
>  arch/arm/kernel/init_task.o  init/built-in.o --start-group
>   usr/built-in.o  arch/arm/kernel/built-in.o  arch/arm/mm/built-in.o
>   arch/arm/common/built-in.o  arch/arm/mach-versatile/built-in.o
>   arch/arm/nwfpe/built-in.o  arch/arm/vfp/built-in.o  kernel/built-in.o
>   mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o
>   crypto/built-in.o  block/built-in.o  arch/arm/lib/lib.a  lib/lib.a
>   arch/arm/lib/built-in.o  lib/built-in.o  drivers/built-in.o
>   sound/built-in.o  net/built-in.o --end-group
> 
> Produces no error, but:
> 
> $ arm-linux-nm ../build/versatile/.tmp_vmlinux1 |grep ' U '
>          U __divdi3
>          U __udivdi3
>          U __umoddi3
> 
> Duh.

I'm lead to believe that these are due to gcc issuing .globl directives
for these symbols, but not actually referencing them.  Hence the symbol
is marked undefined in the symbol table, but no reloations actually
exist.

Hence why the linker (correctly) doesn't fail.

Ergo, no problem.  Please ignore the previous mail.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
