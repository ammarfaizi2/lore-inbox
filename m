Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSKSOsJ>; Tue, 19 Nov 2002 09:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKSOsJ>; Tue, 19 Nov 2002 09:48:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57093 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265446AbSKSOsI>; Tue, 19 Nov 2002 09:48:08 -0500
Date: Tue, 19 Nov 2002 14:55:02 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: module-init-tools-0.6/modprobe.c - support subdirectories
Message-ID: <20021119145502.B5535@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20021118073247.A10109@adam.yggdrasil.com> <20021119064333.C5C1C2C2C4@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021119064333.C5C1C2C2C4@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Nov 19, 2002 at 05:42:38PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 05:42:38PM +1100, Rusty Russell wrote:
> A: The total linking code is about 200 generic lines, 100
>    x86-specific lines.

Should we be bounds-checking the relocations?  Maybe we are (I'm not
familiar enough with this new module code yet.)  I'm specifically
thinking about the following:

		/* This is where to make the change */
		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
			+ rel[i].r_offset;
		/* This is the symbol it is referring to */
		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
			+ ELF32_R_SYM(rel[i].r_info);
		if (!sym->st_value) {

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

