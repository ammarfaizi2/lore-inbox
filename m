Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbREBIaX>; Wed, 2 May 2001 04:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132359AbREBIaO>; Wed, 2 May 2001 04:30:14 -0400
Received: from www.teaparty.net ([216.235.253.180]:22034 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S132352AbREBIaG>;
	Wed, 2 May 2001 04:30:06 -0400
Date: Wed, 2 May 2001 09:30:03 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Russ Dill <Russ.Dill@asu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Breakage of opl3sax cards since 2.4.3 (at least)
In-Reply-To: <3AEFB2C6.24F7B40D@asu.edu>
Message-ID: <Pine.LNX.4.10.10105020918260.18909-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Russ Dill wrote:

> Actually, this occured at 2.4.2
> 
> I searched though the archives, and the only people who were able to get
> this resolved were those with a non-isapnp card (by added isapnp=0).
> However, I have an isapnp card and the driver doesn't think my card
> exists. If I lod it, withot options, I get:

I have an isapnp opl3sax system [2.4.3-ac5] - the sound card initialises
fine, I just have to kick the second logical device with by cat'ing the
following into /proc/isapnp:

card 0 YMH0802
dev 0 YMH0022
port 0 0x201
activate

Which then activates the gameport: What are the contents of your
/proc/isapnp? Mine says: 

##########################################################################
Card 1 'YMH0802:YAMAHA OPL3-SAx Audio System' PnP version 1.0
  Logical device 0 'YMH0021:Unknown'
    Device is active
    Active port 0x240,0xe80,0x388,0x300,0x100
    Active IRQ 5 [0x2]
    Active DMA 1,3
    Resources 0
      Priority preferred
      Port 0x220-0x220, align 0xf, size 0x10, 16-bit address decoding
      Port 0x530-0x530, align 0x7, size 0x8, 16-bit address decoding
      Port 0x388-0x388, align 0x3, size 0x4, 16-bit address decoding
      Port 0x330-0x330, align 0x1, size 0x2, 16-bit address decoding
      Port 0x370-0x370, align 0x1, size 0x2, 16-bit address decoding
      IRQ 5 High-Edge
      DMA 0 8-bit byte-count type-A
      DMA 1 8-bit byte-count type-A
      Alternate resources 0:1
        Priority acceptable
        Port 0x240-0x240, align 0xf, size 0x10, 16-bit address decoding
        Port 0xe80-0xe80, align 0x7, size 0x8, 16-bit address decoding
        Port 0x388-0x388, align 0x3, size 0x4, 16-bit address decoding
        Port 0x300-0x300, align 0x1, size 0x2, 16-bit address decoding
        Port 0x100-0xffe, align 0x1, size 0x2, 16-bit address decoding
        IRQ 5,7,2/9,10,11 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
      Alternate resources 0:2
        Priority functional
        Port 0x220-0x280, align 0xf, size 0x10, 16-bit address decoding
        Port 0x530-0xf48, align 0x7, size 0x8, 16-bit address decoding
        Port 0x388-0x3f8, align 0x7, size 0x4, 16-bit address decoding
        Port 0x300-0x334, align 0x1, size 0x2, 16-bit address decoding
        Port 0x100-0xffe, align 0x1, size 0x2, 16-bit address decoding
        IRQ 3,5,7,2/9,10,11 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
  Logical device 1 'YMH0022:Unknown'
    Compatible device PNPb02f
    Device is active
    Active port 0x201
    Active DMA 0,0
    Resources 0
      Priority preferred
      Port 0x201-0x201, align 0x0, size 0x1, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x202-0x202, align 0x0, size 0x1, 16-bit address decoding
      Alternate resources 0:2
        Priority acceptable
        Port 0x203-0x203, align 0x0, size 0x1, 16-bit address decoding
      Alternate resources 0:3
        Priority acceptable
        Port 0x204-0x20f, align 0x0, size 0x1, 16-bit address decoding
##########################################################################


I start the sound system with the following script:

    modprobe soundcore
    modprobe sound
    modprobe mpu401 # not sure I need this
    modprobe ad1848
    modprobe opl3sa2 mss_io=0x530 io=0x388 mpu_io=0x330 irq=5 dma=0 dma2=1
    modprobe opl3   # or this.

[Note that this part works fine without prodding /proc/isapnp]

Of course, you have a YMH0020, and I have a YMH0021, that could be making
all the difference.

-- 
Death before decaf.



