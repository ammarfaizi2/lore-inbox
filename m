Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271942AbRIDLFN>; Tue, 4 Sep 2001 07:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271943AbRIDLEy>; Tue, 4 Sep 2001 07:04:54 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:28681 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S271942AbRIDLEv>; Tue, 4 Sep 2001 07:04:51 -0400
Message-ID: <3B94B571.772A05F4@netvision.net.il>
Date: Tue, 04 Sep 2001 14:05:21 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tim Waugh <twaugh@redhat.com>
Subject: Re: lpr to HP laserjet stalls
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Mon, Sep 03, 2001 at 11:05:29PM +0300, Michael Ben-Gershon wrote:
> 
> > It is intermittent, but very frequent. It is difficult to print more
> > than about 10 sheets without it happening sometime.
> 
> Take a look at Documentation/parport.txt: see the 'Troubleshooting'
> section.

OK. Here it is:

Sep  3 00:33:28 linux kernel: 0x378: FIFO is 16 bytes
Sep  3 00:33:29 linux kernel: 0x378: writeIntrThreshold is 8
Sep  3 00:33:29 linux kernel: 0x378: readIntrThreshold is 8
Sep  3 00:33:29 linux kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,COMPAT,EPP,ECP]
Sep  3 00:33:29 linux kernel: parport0: irq 7 detected
Sep  3 00:33:29 linux kernel: parport0: Printer, Hewlett-Packard HP LaserJet 6P
Sep  3 00:33:29 linux kernel: lp0: using parport0 (polling).

Here are the contents of the parport directory in /proc:

::::::::::::::
/proc/sys/dev/parport/parport0/autoprobe
::::::::::::::
CLASS:PRINTER;
MODEL:HP LaserJet 6P;
MANUFACTURER:Hewlett-Packard;
DESCRIPTION:Hewlett-Packard LaserJet 6P Printer;
COMMAND SET:PJL,MLC,PCLXL,PCL;
::::::::::::::
/proc/sys/dev/parport/parport0/autoprobe0
::::::::::::::
::::::::::::::
/proc/sys/dev/parport/parport0/autoprobe1
::::::::::::::
::::::::::::::
/proc/sys/dev/parport/parport0/autoprobe2
::::::::::::::
::::::::::::::
/proc/sys/dev/parport/parport0/autoprobe3
::::::::::::::
::::::::::::::
/proc/sys/dev/parport/parport0/base-addr
::::::::::::::
888     1912
::::::::::::::
/proc/sys/dev/parport/parport0/devices/lp/timeslice
200
::::::::::::::
/proc/sys/dev/parport/parport0/dma
::::::::::::::
-1
::::::::::::::
/proc/sys/dev/parport/parport0/irq
::::::::::::::
-1
::::::::::::::
/proc/sys/dev/parport/parport0/modes
::::::::::::::
PCSPP,TRISTATE,COMPAT,EPP,ECP
::::::::::::::
/proc/sys/dev/parport/parport0/spintime
::::::::::::::
500

As far as I can see, although IRQ 7 is detected, it is not used, so
I don't see how starting parport with irq=none would help. Could
CONFIG_PARPORT_PC_FIFO actually improve matters in such a situation?

Michael Ben-Gershon
mybg@netvision.net.il
