Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272534AbRH3Wjl>; Thu, 30 Aug 2001 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272536AbRH3Wjb>; Thu, 30 Aug 2001 18:39:31 -0400
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:11717
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S272534AbRH3WjY>; Thu, 30 Aug 2001 18:39:24 -0400
Date: Fri, 31 Aug 2001 10:39:33 +1200
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Still flaky (Re: Crashing with Abit KT7, 2.2.19+ide patches)
Message-ID: <20010831103932.A30535@cone.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20010828155108.G14714@cone.kiwa.co.nz> <Pine.LNX.4.10.10108280029480.19311-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10108280029480.19311-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Tue, Aug 28, 2001 at 12:31:35AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess I spoke to soon:

Aug 31 09:53:20 hoppa -- MARK --
Aug 31 10:03:15 hoppa kernel: hda: irq timeout: status=0xd0 { Busy }
Aug 31 10:03:28 hoppa kernel: ide0: reset: success
Aug 31 10:03:28 hoppa cups-lpd[1938]: Connection from unknown (192.168.xxx.xxx).



Also some logs on the console that didn't make it to /var/log/messages,
but dmesg got them:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: timeout waiting for DMA
hda: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x20
hda: set_drive_speed_status: status=0xd0 { Busy }
ide0: Drive 0 didn't accept speed setting. Oh, well.
hda: irq timeout: status=0x80 { Busy }
hda: DMA disabled
hda: ide_set_handler: handler not null; old=c018f5cc, new=c018f5cc
bug: kernel timer added twice at c018f476.
ide0: reset: success
hda: irq timeout: status=0xd0 { Busy }
ide0: reset: success

The last two lines being:
Aug 31 10:03:15 hoppa kernel: hda: irq timeout: status=0xd0 { Busy }
Aug 31 10:03:28 hoppa kernel: ide0: reset: success



All very similar to:

Aug 29 04:37:15 hoppa kernel: hda: timeout waiting for DMA
Aug 29 04:37:15 hoppa kernel: hda: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x20
Aug 29 04:37:15 hoppa kernel: hda: irq timeout: status=0x80 { Busy }
Aug 29 04:37:15 hoppa kernel: hda: DMA disabled
Aug 29 04:37:15 hoppa kernel: hda: ide_set_handler: handler not null; old=c018f5cc, new=c018f5cc
Aug 29 04:37:15 hoppa kernel: bug: kernel timer added twice at c018f476.
Aug 29 04:37:18 hoppa kernel: ide0: reset: success


Which occur just before the cable was checked and replaced with a new one on:

Aug 29 08:13:21 hoppa syslogd 1.3-3#33.1: restart.
Aug 29 08:13:21 hoppa kernel: klogd 1.3-3#33.1, log source = /proc/kmsg started.




Note this occured when;
Aug 31 10:03:28 hoppa cups-lpd[1938]: Connection from unknown (192.168.xxx.xxx).

A incomming print job started, plus a samba job opening a file:

(smbstatus line)
Locked files:
Pid    DenyMode   R/W        Oplock           Name
--------------------------------------------------
....
1894   DENY_WRITE RDWR       EXCLUSIVE+BATCH ....filename... Fri Aug 31 10:02:22 2001


Plus the ongoing IPSec + IP forwarding.  Although 50% of the disk IO 
on it before was moved on the 29th to another machine.


This is with a new cable, plugged end to end, well seated. 2.2.19 kernel+ide patches.

That event did turn off pretty much everything on the drive:

[nic@hoppa:~] sudo hdparm -v /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2480/255/63, sectors = 39851760, start = 0




Should I be justified in thinking that the either the VIA or Seagate stuff is
causing this pain.   Or is it someone doing voodoo magic?  Of course the
new cable I received might be crap as well.


It seems to be that the system isn't handling disk and network IO DMA
very well.  Could it be related to the tulip driver as well?

tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth1: Digital DS21143 Tulip rev 65 at 0xd000, 00:80:C8:CF:B6:D1, IRQ 5.
....



Nicholas


