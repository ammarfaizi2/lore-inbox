Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131177AbRBNUlq>; Wed, 14 Feb 2001 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRBNUlh>; Wed, 14 Feb 2001 15:41:37 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:7897 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S130848AbRBNUl3>; Wed, 14 Feb 2001 15:41:29 -0500
Message-Id: <5.0.2.1.2.20010214123238.023ea9c0@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 14 Feb 2001 12:40:01 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jsidhu@arraycomm.com (Jasmeet Sidhu)
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Re: IDE DMA Problems...system hangs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14T8XO-0005wN-00@the-village.bc.nu>
In-Reply-To: <5.0.2.1.2.20010214115941.02471bb8@pop.arraycomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:28 PM 2/14/2001 +0000, Alan Cox wrote:
> > Anybody else having these problems with a ide raid 5?
> > The Raid 5 performance should also be questioned..here are some number
> > returned by hdparam
>
>You will get horribly bad performance off raid5 if you have stripes on both
>hda/hdb  or hdc/hdd etc.

If I am reading this correctly, then by striping on both hda/hdb and 
/hdc/hdd you mean that I have two drives per ide channel.  In other words, 
you think I have a Master and a Slave type of a setup?  This is 
incorrect.  Each drive on the system is a master.  I have 5 promise cards 
in the system (4 PCI and 1 onboard AUS a7v mobo).  This gives me the 
ability to have 10 master drives. Since I am only striping on one drive per 
ide chanel, the penalty should not be much in terms of performance.  Maybe 
its just that the hdparam utility is not a good tool for benchamarking a 
raid set?


> > Feb 13 05:23:27 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady
> > SeekComplete Error }
> > Feb 13 05:23:27 bertha kernel: hdo: dma_intr: error=0x84 { 
> DriveStatusError
> > BadCRC }
>
>You have inadequate cabling. CRC errors are indications of that. Make sure you
>are using sufficiently short cables for ATA33 and proper 80pin ATA66 cables.

All the cables are ATA/100 capable.  But I cannot think of another reason 
as to why I might be getting CRC errors.  I will invest in better cables 
and see if it changes anything.

> > Feb 13 12:12:42 bertha kernel: hdg: irq timeout: status=0x50 { DriveReady
> > SeekComplete }
> > Feb 13 12:13:02 bertha kernel: hdg: timeout waiting for DMA
>
>This could be cabling too, cant be sure
>
> > Feb 13 12:13:12 bertha kernel: hdg: DMA disabled
>
>It gave up using DMA

agreed.


> > Feb 13 12:13:12 bertha kernel: ide3: reset: success   <------- * SYSTEM 
> HUNG
> > AT THIS POINT *
>
>Ok thats a reasonable behaviour, except it shouldnt have then hung.

This is also my main point of frustration.  The system should be able to 
disable DMA if its giving it a lot of problems, but it should not hang.  I 
have been experiencing this for quite a while with the newer 
kernels.  Should I try the latest ac13 patch?  I glanced of the changes and 
didnt seem like anything had changed regarding the ide subsystem.

Is there anyway I can force the kernel to output more messages...maybe that 
could help narrow down the problem?

J.Sidhu






