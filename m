Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318784AbSHBLko>; Fri, 2 Aug 2002 07:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSHBLko>; Fri, 2 Aug 2002 07:40:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23798 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318784AbSHBLkm>; Fri, 2 Aug 2002 07:40:42 -0400
Subject: Re: Dual Xeon Freezes with 2.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Johannes Zuegg <jzuegg@alchemia.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98E24C4993E01F41B3005C0C206CBE4D047F75@almail.alchemia.com.au>
References: <98E24C4993E01F41B3005C0C206CBE4D047F75@almail.alchemia.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 14:01:32 +0100
Message-Id: <1028293292.18317.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 01:28, Johannes Zuegg wrote:
> [Q] Did somebody manage to run a stable 2.4 system on a similar Xeon Box, and if yes what compile or boot option did you use?

I'm using 2.4.19-rc5-ac1 on a dual PIV Xeon with no problems. For the
PIV and certain situations you may get very rare random segfaults with
older trees. 2.2 does not fully support the newer PIV processors

> On running kernel 2.2.19 (from Debian distribution) , I have problems
> with the Raid-disks. Even though the I2O drivers recognize the
> Raid-Card it complains about not finding disks on block 50, and the
> boot stops by not finding the root. 
> 
> VFS: Cannot open root device 50:01
> 
> Interestingly I2O under 2.4 maps the drives onto block 80 !!

80 decimal = 50 hex.

> 
> [Q] Is there a difference in the I2O drivers between 2.2 and 2.4 ?

Current 2.4 and 2.2 there is a huge difference. The i2o code has been
through a major rewriting to clean up the codebase and to handle bugs in
the cards a lot better.

> Promise has a source code for the SuperTrak 6000 card but I get a lot
> of compiling errors, that's why I use the I2O drivers.

You need 2.4.19-rc for the Supertrak 6000 with 2027x based IDE chips,
the 2026x based one should work fine in 2.4.18. I have no idea about 2.2

> On compiling 2.5.29 I get errors in several  i2o*.c source-files. like 

2.5 I2O is a work in progress. I've done the core and pci layers but I
have no plans to finish off the block/net/scsi code until the rest of
the kernel is a bit more stable and it is possible to run serious QA
tests

> [Q] Did somebody run the 2.5 kernel on a Xeon box and is it (more) stable ?

Its extremely unstable, the IDE code occasionally eats data, the box
hangs a lot. Thats to be expected 2.5 is a development kernel tree.
Don't run 2.5 on a box where you value your data. Do run 2.5 if you want
to be involved in debugging and the like.

2.5 IDE is beginning to stabilize as is the core, so I'm hoping I'll be
able to finish up the I2O code in a couple of months. ...

> i2o_block: Checking for Boot device...
> i2o_block: Checking for I2O Block devices...
> i2ob: Installing tid 16 device at unit 0
> i2o/hda: Max segments 12, queue depth 32, byte limit 6144.
> i2o/hda: Type 104: 38146MB, 512 byte sectors.
> i2o/hda: Maximum sectors/read set to 256.
> Partition check:
>  i2o/hda: i2o/hda1 i2o/hda2
> i2ob: Installing tid 17 device at unit 16
> i2o/hdb: Max segments 12, queue depth 32, byte limit 6144.
> i2o/hdb: Type 104: 228881MB, 512 byte sectors.
> i2o/hdb: Maximum sectors/read set to 256.
>  i2o/hdb: i2o/hdb1

So it found both I2O volumes quite happily. However the kernel you built
apparently couldnt find a way to mount /dev/i2o/hda1 - that might just
be because you didnt include the right file system in the kernel


