Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTAVQ0i>; Wed, 22 Jan 2003 11:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTAVQ0i>; Wed, 22 Jan 2003 11:26:38 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:29312 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262258AbTAVQ0f>; Wed, 22 Jan 2003 11:26:35 -0500
Date: Wed, 22 Jan 2003 10:35:42 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg Ungerer <gerg@snapgear.com>
cc: Miles Bader <miles@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
In-Reply-To: <3E2E3BA2.30401@snapgear.com>
Message-ID: <Pine.LNX.4.44.0301221032470.9969-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Greg Ungerer wrote:

> Kai Germaschewski wrote:
> > Yes, I saw it, but on the other hand I'd like to avoid introducing 
> > complexity which isn't really needed. So the important question is: Is 
> > there a reason that v850 does things differently, or could it just as well 
> > live with separate .text and .rodata sections (Note that sections 
> > like .rodata1 will be discarded when empty).
> 
> The reason we tend to group all these things together is that logically
> that is the way they are layed out between flash and ram (and running
> the kernel code in flash is really the case that is interresting here).
> Where you have the text and rodata parts resident in flash (and this is
> where they stay), and the data and bss in ram (but they start in flash
> and are copied on start up to ram). So 2 very different memory regions
> involved, not just one contiguous blob like on most VM architectures.
> 
> So to build a flash image most people just objcopy out the
> text and the data (and init really too) sections and cat them
> together and that is the binary image that you program into
> your flash. If you have lots of sections this makes this
> extraction and concatentation process just plain ugly. And when
> you add new sections your flash building needs to know about
> them and handle them.

Let me just point to the other reply I just wrote. I think you're using
the wrong tool and should use ELF segments instead, that's what they're
there for in the first place. If you base your flash building on segments,
there should be no need for it to know about sections at all.

--Kai


