Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131709AbRCONfP>; Thu, 15 Mar 2001 08:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131711AbRCONfG>; Thu, 15 Mar 2001 08:35:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6529 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131709AbRCONeu>; Thu, 15 Mar 2001 08:34:50 -0500
Date: Thu, 15 Mar 2001 08:33:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pozsar Balazs <pozsy@sch.bme.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE poweroff -> hangup
In-Reply-To: <Pine.GSO.4.30.0103150041540.14732-100000@balu>
Message-ID: <Pine.LNX.3.95.1010315081759.11605A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Pozsar Balazs wrote:

> 
> Hi all,
> 
> I was courious, and I tried what happens if I power down my harddisk (ie
> manually pull the power plug out), and then power it on again after a few
> secs (put the plug back).
> 
> I do not know if the system should survive happily such an 'accident', but
> it hadn't:
> A few secs after the next access to the disc, I got the following on the
> console:
> hdg: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> and the machine froze the hard way (no respond to sysrq).
> 
> Tell me if this shouldn't be honoured by the kernel, but if there's a bug
> around, here's some info:

With IDE, the entire state of the drive is in the drive. There is
no 'controller' on the board like SCSI, just an interface port.
So, when you kill the power to the drive, you kill any information,
including pending operations, that the drive has stored. The only
way to recover is to go through an entire initialization sequence
just like the BIOS did upon power up. If the IDE code didn't do
this the drive will not be accessible. 

The IDE code doesn't have any way of knowing that you destroyed its
current state. Error recovery code could be more robust and perform
the entire startup sequence if it had a way of "knowing" when to
do this.

This is entirely different than what occurs when the IDE drive
is powered off by the IDE/APM software (for laptops). In this case,
the IDE code "knows" that the motor is being turned off. It also
knows how to wait for any pending writes to complete. It also knows
how to restart the motor and to not attempt reads/writes until the
state of the drive has stabilized and the heads have been recalibrated.

Turning off the power to a device that can do any kind of DMA operation
is just like changing RAM with the power on. It's an interesting
experiment in chaos theory.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


