Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRAFFFZ>; Sat, 6 Jan 2001 00:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRAFFFQ>; Sat, 6 Jan 2001 00:05:16 -0500
Received: from cr949225-b.rchrd1.on.wave.home.com ([24.112.58.97]:61444 "HELO
	enfusion-group.com") by vger.kernel.org with SMTP
	id <S129538AbRAFFFJ>; Sat, 6 Jan 2001 00:05:09 -0500
Date: Sat, 6 Jan 2001 00:05:07 -0500
From: Adrian Chung <adrian@enfusion-group.com>
To: linux-kernel@vger.kernel.org
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Promise Ultra66 DMA problems.
Message-ID: <20010106000507.A2278@rogue.enfusion-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010105170838.A1674@rogue.enfusion-group.com>; from adrian@enfusion-group.com on Fri, Jan 05, 2001 at 05:08:38PM -0500
Organization: enfusion-group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 05:08:38PM -0500, Adrian Chung wrote:
> hde: Maxtor 91024U3, ATA DISK drive
> hdf: Maxtor 94098U8, ATA DISK drive
> hdg: QUANTUM FIREBALLP LM15, ATA DISK drive
> hdh: QUANTUM FIREBALLP LM30, ATA DISK drive

I initially added only the two quantum drives to the pdc_quirk_list,
and that had no effect, the machine still hung on boot up at the same
place.  After this, I added the other two Maxtor's as well, and with
all four drives in the pdc_quirk_list, the system booted up fine.

Should I narrow this down further?  Will it be detrimental in any way
to have all four drives listed in the quirks table if they needn't be?

cat /proc/ide/pdc:
                            PDC20262 Chipset.
---------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 4 mA
Status Polling Period                : 0
Interrupt Check Status Polling Delay : 0
------------ Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled 
66 Clocking     enabled                          enabled 
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
------------ drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           UDMA 4          UDMA 4            UDMA 4
PIO Mode:       PIO 4            PIO 4           PIO 4            PIO 4

and hdparm yields about 25Mbit/s.

I'm trying to get the runtime system to hang like it did before as
well...  I'm running "dd if=/dev/hdX of=/dev/null &" on all four
drives simultaneously, and about 3 times per drive to hit the
controller and disk I/O system really hard.  So far, it's all been
fine.  Hopefully that means that the problems gone away. :)

Thanks for the help!

--
Adrian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
