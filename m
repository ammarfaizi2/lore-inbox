Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281258AbRKERde>; Mon, 5 Nov 2001 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281251AbRKERdZ>; Mon, 5 Nov 2001 12:33:25 -0500
Received: from oracle.clara.net ([195.8.69.94]:31751 "EHLO oracle.clara.net")
	by vger.kernel.org with ESMTP id <S281258AbRKERdL>;
	Mon, 5 Nov 2001 12:33:11 -0500
To: linux-kernel@vger.kernel.org
Path: softins.clara.co.uk!not-for-mail
From: tony@softins.clara.co.uk (Tony Mountifield)
Newsgroups: linux.kernel
Subject: Re: aic7xxx problems with AHA2930CU
Date: 5 Nov 2001 17:33:08 -0000
Organization: Software Insight Ltd., Winchester, UK
Message-ID: <9s6igk$3rf$1@softins.clara.co.uk>
In-Reply-To: <9s6hcs$3nc$1@softins.clara.co.uk>
X-Newsreader: trn 4.0-test69 (20 September 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs <gibbs@scsiguy.com> wrote:
> >I have been running fine for over two months with 2.2.19 and the old 5.1.31
> >SCSI driver. When Red Hat 7.2 came out recently I though I would try again,
> >and created a boot floppy and a driver floppy.
> >
> >Booting with these still displayed the problems I described.
> >Using aic7xxx_mod (6.1.13) instead of aic7xxx resulted in a kernel panic.
> 
> Can you provide any information about the kernel panic?  6.1.13 is still
> quite old.  You may have better luck using version 6.2.4, but I can't
> really say without knowing more about your system, the devices on the
> bus, and the nature of the crash.  The 2930CU seems to work okay here.

This was at boot time, from the Red Hat 7.2 distribution floppies.
I'll try it again and note what it says.

I'll also try installing a clean 2.2.19 and applying the 6.2.4 driver patch
to it, and build it as an alternative boot kernel.

I still don't understand why 5.1.31 is the latest driver that works...

In the meantime, here are the details of my SCSI subsystem:

$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST36530N         Rev: 1206
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: FUJITSU  Model: M2694ES-512      Rev: 812A
  Type:   Direct-Access                    ANSI SCSI revision: 01 CCS
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02

$ cat /proc/scsi/aic7xxx/0 
Adaptec AIC7xxx driver version: 5.1.31/3.2.4
Compile Options:
  TCQ Enabled By Default : Disabled
  AIC7XXX_PROC_STATS     : Enabled
  AIC7XXX_RESET_DELAY    : 5

Adapter Configuration:
           SCSI Adapter: Adaptec AIC-7860 Ultra SCSI host adapter
                           Ultra Narrow Controller at PCI 0/9/0
    PCI MMAPed I/O Base: 0xefffe000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 9
                   SCBs: Active 0, Max Active 2,
                         Allocated 15, HW 3, Page 255
             Interrupts: 466583
      BIOS Control Word: 0x10b6
   Adapter Control Word: 0x005e
   Extended Translation: Enabled
Disconnect Enable Flags: 0x00ff
     Ultra Enable Flags: 0x0005
 Tag Queue Enable Flags: 0x0000
Ordered Queue Tag Flags: 0x0000
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:0:0)
  Device using Narrow/Sync transfers at 20.0 MByte/sec, offset 15
  Transinfo settings: current(12/15/0/0), goal(12/15/0/0), user(12/15/0/0)
  Total transfers 446289 (400941 reads and 45348 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+    64K+   128K+
   Reads:   87226   14652   29730   31168   39780   64915  133470       0
  Writes:   37688    6735     412     187     100     105     121       0


(scsi0:0:1:0)
  Device using Narrow/Async transfers.
  Transinfo settings: current(0/0/0/0), goal(255/0/0/0), user(12/15/0/0)
  Total transfers 20228 (20228 reads and 0 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+    64K+   128K+
   Reads:   20228       0       0       0       0       0       0       0
  Writes:       0       0       0       0       0       0       0       0


(scsi0:0:2:0)
  Device using Narrow/Sync transfers at 20.0 MByte/sec, offset 15
  Transinfo settings: current(12/15/0/0), goal(12/15/0/0), user(12/15/0/0)
  Total transfers 0 (0 reads and 0 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+    64K+   128K+
   Reads:       0       0       0       0       0       0       0       0
  Writes:       0       0       0       0       0       0       0       0


Cheers,
Tony
-- 
Tony Mountifield
Work: tony@softins.co.uk - http://www.softins.co.uk
Play: tony@mountifield.org - http://tony.mountifield.org
