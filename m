Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135206AbRDRPZW>; Wed, 18 Apr 2001 11:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbRDRPZN>; Wed, 18 Apr 2001 11:25:13 -0400
Received: from sirius-giga.rz.uni-ulm.de ([134.60.246.36]:4095 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135206AbRDRPZK>; Wed, 18 Apr 2001 11:25:10 -0400
Date: Wed, 18 Apr 2001 17:25:07 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Markus Schaber <markus.schaber@student.uni-ulm.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AHA-154X/1535 not recognized any more
In-Reply-To: <E14pr7J-0004cw-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.33.0104181600230.14689-100000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 18 Apr 2001, Alan Cox wrote:

> Ok if you use the old style usermode isapnp tools to configure it and then
> force aha1542 to use the right io, irq to find it does it then work ?

Well, as this device is already configured by the bios, I just tried
to load it giving the right IO port, and got the following message:

lunix:/home/schabi# modprobe aha1542 io=0x330
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: invalid parameter parm_io
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: insmod
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o failed
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: insmod aha1542 failed

It seems as the driver doesn't accept a given IO port as parameter.

Using isapnptools (which I never had to use before), I got the following
error message:

lunix:~# isapnp pnpconfig.txt
Board 1 has Identity 08 0f 6d b9 45 42 15 90 04:  ADP1542 Serial No 258849093 [checksum 08]
pnptext:60 -- Fatal - IO range check attempted while device activated
pnptext:60 -- Fatal - Error occurred executing request '<IORESCHECK> ' --- further action aborted

/proc/isapnp also states that the device is active, but no ports, irq, dma
and memory is mapped.

I put the pnpconfig.txt and the contents of /proc/isapnp also onto
http://schabi.de/scsi/.

In some other tests, I compiled the kernel without Plug and Play support.

The module loaded without any parameters (and didn't accept an parm_io
value) when typing modprobe aha1542. As expected by me, it didn't make
any difference whether I told my bios that there's an pnp-OS installed or
not, as the Host adapter is a bootable device and so initialized both
ways.  Pnpdump had the same output, as far as I saw.

I also retried a statically compiled driver (no module) without isapnp
(the combination my 2.2.19 kernel used), and it also worked as expected.

So this is clearly a isapnp triggered problem.

Another point: I compile my kernel with the debian command "make-kpkg
kernel-image", and then install the created kernel .deb - I hope this
doesn't make any difference with my problem.

markus


