Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbREPS4t>; Wed, 16 May 2001 14:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262060AbREPS4j>; Wed, 16 May 2001 14:56:39 -0400
Received: from fandango.cs.unitn.it ([193.205.199.228]:26899 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S262054AbREPS4U>; Wed, 16 May 2001 14:56:20 -0400
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200105161856.UAA18123@fandango.cs.unitn.it>
Subject: Re: wrong /dev/sd... order with multiple adapters in kernel 2.4.4
In-Reply-To: <Pine.LNX.3.95.1010516141437.2686A-100000@chaos.analogic.com> from
 "Richard B. Johnson" at "May 16, 2001 02:25:45 pm"
To: root@chaos.analogic.com
Date: Wed, 16 May 2001 20:55:43 +0200 (MEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 16 May 2001, Massimo Dal Zotto wrote:
> 
> > Hi,
> > 
> > I have recently upgraded the kernel from 2.2.19 to 2.4.4 and discovered
> > that it assigns the /dev/sd... devices in the wrong order with respect both
> > to the behavior of kernel 2.2.19 and to the `scsihosts' boot option which I
> > specified at the boot prompt.
> [SNIPPED]
> 
> As a work-around, you can use modules and boot through 'initrd' where
> you load the modules in the order you want.

I wanted to use a simpler method, a plain kernel with two static drivers
which can simply be copied to /boot or to a floppy. Of course any more
sophisticated method would work but I wanted a simple thing.

> When you have two SCSI disk controllers, the order at which the drives
> are seen will "always be wrong" --Murphys Law. You can control the
> order in which the controllers are detected and installed by using
> modules.

Yes, I understand that any particular order will be wrong for some users.

I'm not complaining about the current scan order. What I'm complaining about
is that we do *have* a specific method of forcing the desired order (the
scsihosts boot option) but this is ignored by some parts of the scsi code.

I suggest that the scsihosts order is taken into account also when detecting
the /dev/sd devices and not only when creating the /dev/scsi/ devices.

> Basically you cannot ever expect that multiple controllers will
> be detected in any particular order. They usually end up being detected
> in the device-order for which they exist on the PCI bus. This changes!

This is not the case with kernel 2.4.4. They are detected in `ld' order.
Changing the makefiles will change the scan order.

> If both of your controllers are "pluggable", you can swap them
> on the physical bus to change the order in which they are detected.

This is impossible given the density of cables and cards in the cabinet, and
useless anyway given the fact that devices are detected in `ld' order.

> If only one is pluggable, you might try another PCI slot. It may
> have a number above/below the one embedded on the board.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> 

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: dz@cs.unitn.it               |
|  Via Marconi, 141                phone: ++39-0461534251              |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                             pgp: see my www home page         |
+----------------------------------------------------------------------+
