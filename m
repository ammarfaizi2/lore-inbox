Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTAVDS0>; Tue, 21 Jan 2003 22:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTAVDS0>; Tue, 21 Jan 2003 22:18:26 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:20498 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267288AbTAVDSZ>; Tue, 21 Jan 2003 22:18:25 -0500
Message-ID: <3E2E0F38.7090506@snapgear.com>
Date: Wed, 22 Jan 2003 13:25:44 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301212045000.1577-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0301212045000.1577-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

Kai Germaschewski wrote:
> First of all, asm-generic/vmlinux.lds.h is there to share common code 
> where possible, so if it's not possible, you still have the option of 
> having your own special code in arch/$(ARCH)/vmlinux.lds.S

And that is exactly what I have done as an immediate fix.

It would be nice if all architectures could use this
common code. Saves me having to specifically fix m68knommu
linker script when ever things inside RODATA change.


> Having said that, you could add
> 
> 	#define TEXT_MEM > flash
> 
> at the beginning of arch/m68knommu/vmlinux.lds.S
> 
> and
> 
> 	#ifndef TEXT_MEM
> 	#define TEXT_MEM
> 	#endif
> 
> at the beginning of include/asm-generic/vmlinux.lds.h and then change
> 
> 	.text : {
> 		*(.text)
> -	}
> +	} TEXT_MEM
> 
> Would that work for you?

Yep, I would be happy with that.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

