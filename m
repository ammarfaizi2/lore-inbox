Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311619AbSCNOEY>; Thu, 14 Mar 2002 09:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311621AbSCNOEO>; Thu, 14 Mar 2002 09:04:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13838 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311619AbSCNODz>; Thu, 14 Mar 2002 09:03:55 -0500
Subject: Re: [patch] PIIX rewrite patch, pre-final
To: dani@ngrt.de
Date: Thu, 14 Mar 2002 14:19:35 +0000 (GMT)
Cc: vojtech@suse.cz (Vojtech Pavlik), linux-kernel@vger.kernel.org (LKML),
        martin@dalecki.de (Martin Dalecki), spstarr@sh0n.net (Shawn Starr)
In-Reply-To: <20020314063843.E0E3210921@mail.medav.de> from "Daniela Engert" at Mar 14, 2002 08:44:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lW4t-0000rc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me try and contribute a bit more back to this wonderful document..


>  0x1078 Cyrix
>    0x0102 CX5530		      x    x	x    x	   x   -   -   -    x
> 
>  known bugs:
>    - all: busmaster transfers need to be 16 byte aligned instead of wor=
> d
> 	  aligned.

Add: A DMA block of 65536 bytes comes out as 0 bytes in the chipset.

>  0x1166 ServerWorks
>    0x0211 OSB4			      x    x	?    ?	   x   -   -   -    x
>    0x0212 CSB5
>      < 0x92			      x    x	?    ?	   x   x   -   -    -
>     >=3D 0x92			      x    x	?    ?	   x   x   x   -    -
> 
>  known bugs:
>    - OSB4: at least some chip revisions can't do Ultra DMA mode 1 and a=
> bove

Interesting - any idea which you've found a problem. One errata we see in
the Linux case with specific drive/board combinations is a
transfer completing but the DMA busy bit never being cleared. The next
DMA transaction is shifted by 4 bytes starting with the last dword of
the previous I/O (as if the DMA engine got something stuck in a FIFO)

>    - CSB5: no host side cable type detection.
(Except with extra glue - eg on Dell boxes)

Alan
