Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbTAQOgc>; Fri, 17 Jan 2003 09:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbTAQOgc>; Fri, 17 Jan 2003 09:36:32 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:38563 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267539AbTAQOgb>; Fri, 17 Jan 2003 09:36:31 -0500
Date: Fri, 17 Jan 2003 08:44:22 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
In-Reply-To: <15911.64825.624251.707026@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0301170840200.14924-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Mikael Pettersson wrote:

> What happens is that __find_symbol() oopses because the kernel's
> symbol table is in la-la land. (Note the bogus kernel adress
> 2220c021 it tried to dereference above.)
> 
> Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
> problem and modules now load correctly for me.

That's interesting. It doesn't happen for me, but I'm using older 
binutils. The patch really only changes two things (except for ARM):
o whitespace
o It adds AT(ADDR(section) - 0)

Both of these should be NOPs, but apparently not. Could you try removing
the AT(...) from include/asm-generic/vmlinux.lds.h?

Also, what does
	objdump -h vmlinux
and
	grep __start_ System.map
say?

--Kai


