Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUHAULa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUHAULa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 16:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUHAULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 16:11:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266163AbUHAUL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 16:11:26 -0400
Date: Sun, 1 Aug 2004 16:10:42 -0400
From: Alan Cox <alan@redhat.com>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@redhat.com>
Subject: Re: PATCH: Add support for IT8212 IDE controllers
Message-ID: <20040801201042.GC20007@devserv.devel.redhat.com>
References: <20040731232227.GA28455@devserv.devel.redhat.com> <200408012022.42516.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408012022.42516.ianh@iahastie.local.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 08:22:28PM +0100, Ian Hastie wrote:
>         ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
>     it8212: controller in RAID mode.
> 
> That doesn't.  I have no RAID sets defined in the IT8212 card BIOS.  BTW, the 

The controller runs in RAID mode on the "smart" cards even without raid 
definitions being used - its still doing the hardware assist.

>         ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
>     hde: Maxtor 6Y120P0, ATA DISK drive
>     it8212: selected 50MHz clock.
> 
> Nor does this as it really should be using the 66MHz clock setting.

Currently it always picks 50MHz, thats a feature I'm still working on 
adding intelligence to

>     ide2 at 0xb000-0xb007,0xa802 on irq 17
>     hde: max request size: 128KiB
>     hde: recal_intr: status=0x51 { DriveReady SeekComplete Error }
>     hde: recal_intr: error=0x04 { DriveStatusError }
> 
> Any idea what could be causing this?  My hacked driver doesn't get this in 
> 2.6.7, but then it could be a 2.6.8 problem.

It was sent a command it didnt know.

The UDMA33 speed behaviour looks to me like cable detect got the wrong
answer. The reference driver doesn't actually do host side cable detect
so it may be that its in the docs but doesn't actually work or isnt wired
on the boards. Can you see what the ata66 function is doing ?

