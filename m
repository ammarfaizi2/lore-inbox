Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTAVCkM>; Tue, 21 Jan 2003 21:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAVCkM>; Tue, 21 Jan 2003 21:40:12 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:51674 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266081AbTAVCkL>; Tue, 21 Jan 2003 21:40:11 -0500
Date: Tue, 21 Jan 2003 20:49:17 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg Ungerer <gerg@snapgear.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
In-Reply-To: <3E2DFC78.1040402@snapgear.com>
Message-ID: <Pine.LNX.4.44.0301212045000.1577-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Greg Ungerer wrote:

> The new common definition of RODATA for linker scripts
> (in include/asm-generic/vmlinux.lds.h) is causing me some
> amount of pain, at least on the m68knommu architecture.
> 
> The problem is that on the m68knommu arch linker script
> it fundamentaly groups everything into 2 memory regions,
> one for flash and one for ram. Each section is then
> directed to the appropriate memory region, eg:
> 
>          .text : {
>              *(.text)
>          } > flash
> 
> With the way the RODATA define is setup I cannot do this.
> It contains definitions for a number of complete sections.
> 
> Anyone got any ideas on the best way to fix this?

First of all, asm-generic/vmlinux.lds.h is there to share common code 
where possible, so if it's not possible, you still have the option of 
having your own special code in arch/$(ARCH)/vmlinux.lds.S

Having said that, you could add

	#define TEXT_MEM > flash

at the beginning of arch/m68knommu/vmlinux.lds.S

and

	#ifndef TEXT_MEM
	#define TEXT_MEM
	#endif

at the beginning of include/asm-generic/vmlinux.lds.h and then change

	.text : {
		*(.text)
-	}
+	} TEXT_MEM

Would that work for you?

--Kai


