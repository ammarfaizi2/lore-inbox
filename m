Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262471AbTCIHyi>; Sun, 9 Mar 2003 02:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbTCIHyi>; Sun, 9 Mar 2003 02:54:38 -0500
Received: from gold.muskoka.com ([216.123.107.5]:26125 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S262471AbTCIHyh>;
	Sun, 9 Mar 2003 02:54:37 -0500
Message-ID: <3E6AEA01.1077F367@yahoo.com>
Date: Sun, 09 Mar 2003 02:15:13 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Accept-Language: en
MIME-Version: 1.0
To: Osamu Tomita <tomita@cinet.co.jp>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (11/20) NIC
References: <20030309035245.GA1231@yuzuki.cinet.co.jp> <20030309042519.GL1231@yuzuki.cinet.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Osamu Tomita wrote:
> 
> This is the patch to support NEC PC-9800 subarchitecture
> against 2.5.64-ac3. (11/20)
> 
> C-bus(PC98's legacy bus like ISA) network cards support.
> Change IO port and IRQ assign.
> Add auto detect function for some cards.
>   PCI netwwork card works fine without patch. 

I had a quick look at the ne.c part of this patch, and I can't
say I'm really thrilled to see some 30 or more ifdefs added to
just one driver.  Okay, I know it is an old crusty ISA driver, but 
when somebody has to go in there to repair the inevitable bitrot,
the readability factor is significantly reduced.

If the hardware differences can't be abstracted out any cleaner
than this, then it probably makes sense to just make a ne2k-pc98.c
and you can scrap all the bits you don't want.  Code sharing is
fine, but no point bending over backwards in trying to do so.
(e.g. we already have MCA and PCMCIA versions of ne.c now...)

Thanks,
Paul.

