Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135203AbRDRPqz>; Wed, 18 Apr 2001 11:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133119AbRDRPqp>; Wed, 18 Apr 2001 11:46:45 -0400
Received: from [206.46.170.142] ([206.46.170.142]:4326 "EHLO
	smtp10ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S135182AbRDRPqc>; Wed, 18 Apr 2001 11:46:32 -0400
Message-ID: <3ADDB684.392B8AC1@neuronet.pitt.edu>
Date: Wed, 18 Apr 2001 11:45:08 -0400
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Markus Schaber <markus.schaber@student.uni-ulm.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AHA-154X/1535 not recognized any more
In-Reply-To: <Pine.SOL.4.33.0104181600230.14689-100000@lyra.rz.uni-ulm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Schaber wrote:
> 
> Hello,
> 
> On Wed, 18 Apr 2001, Alan Cox wrote:
> 
> > Ok if you use the old style usermode isapnp tools to configure it and then
> > force aha1542 to use the right io, irq to find it does it then work ?
> 
> Well, as this device is already configured by the bios, I just tried
> to load it giving the right IO port, and got the following message:
> 
> lunix:/home/schabi# modprobe aha1542 io=0x330
> /lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: invalid parameter parm_io
> /lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: insmod
> /lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o failed
> /lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: insmod aha1542 failed

The parameter format from the source code is:

/*
 * LILO/Module params: 
aha1542=<PORTBASE>[,<BUSON>,<BUSOFF>[,<DMASPEED>]]
 *
 * Where:  <PORTBASE> is any of the valid AHA addresses:
 *                      0x130, 0x134, 0x230, 0x234, 0x330, 0x334
 *         <BUSON>  is the time (in microsecs) that AHA spends on the
AT-bus
 *                  when transferring data.  1542A power-on default is
11us,
 *                  valid values are in range: 2..15 (decimal)
 *         <BUSOFF> is the time that AHA spends OFF THE BUS after while
 *                  it is transferring data (not to monopolize the bus).
 *                  Power-on default is 4us, valid range: 1..64
microseconds.
 *         <DMASPEED> Default is jumper selected (1542A: on the J1),
 *                  but experimenter can alter it with this.
 *                  Valid values: 5, 6, 7, 8, 10 (MB/s)
 *                  Factory default is 5 MB/s.
 */

> lunix:~# isapnp pnpconfig.txt
> Board 1 has Identity 08 0f 6d b9 45 42 15 90 04:  ADP1542 Serial No 258849093 [checksum 08]
> pnptext:60 -- Fatal - IO range check attempted while device activated
> pnptext:60 -- Fatal - Error occurred executing request '<IORESCHECK> ' --- further action aborted

I've a pnp sound card that fails to configure with a similar error
message when a (CHECK) entry was found in an (IO ...) block. Removing
those entries solved the problem. Try this in your pnpconfig.txt:

(IO 0 (SIZE 4) (BASE 0x0330))

-- 
     Rafael
