Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSESQ0P>; Sun, 19 May 2002 12:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314670AbSESQ0O>; Sun, 19 May 2002 12:26:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4110 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314625AbSESQZD>; Sun, 19 May 2002 12:25:03 -0400
Subject: Re: MTRR problem in 2.4.7+ on Athlon+VIA? XFree86 can't write-combine
To: david.houlder@anu.edu.au (David Houlder)
Date: Sun, 19 May 2002 17:04:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CE7B118.5010601@anu.edu.au> from "David Houlder" at May 20, 2002 12:05:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179TAN-0003y7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (WW) NV(0): Failed to set up write-combining range (0xd4000000,0x800000)
> to XFree86.0.log. XFree86 works, but things like MPEG playback seem a 
> bit slow.

Thats more likely because the Nv driver doesn't support Xv or Xvmc 
extensions, which most other drivers have and give you nice accelerated
overlay/colourspace/scaling for video playback.

> I assume this is because cat /proc/mtrr looks like this before X starts:
> 
> reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
> reg01: base=0xd0000000 (3328MB), size= 128MB: uncachable, count=1
> 
>  From reading the mtrr doco I gather that because 0xd0000000 + 128mb is 
> already set up as an uncachable range, "nv" can't set up 0xd4000000 + 
> 8mb as write-combining.

You can tweak the ranges yourself, deleting the uncachable one and putting
it back as two ranges

> I've searched all through the 2.4.7-10 source code and can't see 
> anything that I'm using that explicitly asks for MTRR_TYPE_UNCACHABLE, 
> so I'm a bit perplexed. I've had a good look around the web and 

The BIOS sets them up for you

