Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289085AbSAGBtf>; Sun, 6 Jan 2002 20:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289086AbSAGBt2>; Sun, 6 Jan 2002 20:49:28 -0500
Received: from gear.torque.net ([204.138.244.1]:41739 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S289087AbSAGBtL>;
	Sun, 6 Jan 2002 20:49:11 -0500
Message-ID: <3C38FE40.CF9E84A@torque.net>
Date: Sun, 06 Jan 2002 20:47:44 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: elim <elim@warthog.ern-e.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: slow scsi disk perf (sym53c875 and IBM drives)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been having relatively poor scsi disk performance 
> for as long as I can remember now. I've experienced this 
> with ~2.2.12 all the way up to 2.4.17.
> 
> I'm not much of a scsi buff but I've read some 
> suggestions such as proper termination, queue depths, 
> etc but nothing seems to have helped. My understanding 
> is that I should be getting better performance than I'm
> getting with these drives.

I have a few DCHS UW disks and get about 10 MB/sec on
a streaming read from them (slower toward the end of
the disk). You can make your own measurements bypassing
the block subsystem (and sd) with the sg_dd utility
found in sg3_utils package. That package is now listed
on freshmeat.net .

For example:
$ time sg_dd if=/dev/sg0 of=/dev/null bs=512 count=2M
to time a 1GB (approx) read at the start of the disk.
[Use sg_map to work out the mapping between the "sd"
and "sg" device names.]

If there is a major discrepancy between this figure
and what you are seeing from hdparm then there is
a problem.


On the disk in this box (Seagate ST318451LW 15Krpm)
I get:
 hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  1.99 seconds = 32.16 MB/sec

In my sg_dd tests I get better than 40 MB/sec. The hdparm
test definitely was timing extraneous activity because
the disk light was not on all the time.

> Any suggestions would be appreciated and if this is not 
> the right forum to ask.. please direct me to the proper
> place.

linux-scsi@vger.kernel.org is arguably a more appropriate
newsgroup.

Doug Gilbert



Rest of original post [for the linux-scsi list]
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
hdparm output:

/dev/sda:
 Timing buffered disk reads:  64 MB in 10.94 seconds =  5.85 MB/sec

/dev/sdb:
 Timing buffered disk reads:  64 MB in  8.66 seconds =  7.39 MB/sec

/dev/sdc:
 Timing buffered disk reads:  64 MB in 10.88 seconds =  5.88 MB/sec

SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Symbios NVRAM
sym53c875-0: rev 0x26 on pci bus 0 device 12 function 0 irq 10
sym53c875-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875-0: on-chip RAM at 0xe0502000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
sym53c875-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 15)
  Vendor: IBM       Model: DCHS09W           Rev: 6363
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-0-<1,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
  Vendor: IBM       Model: DGHS09U           Rev: 03E0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875-0-<4,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 15)
  Vendor: IBM       Model: DCHS09W           Rev: 6363
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-0-<0,0>: tagged command queue depth set to 8
sym53c875-0-<1,0>: tagged command queue depth set to 8
sym53c875-0-<4,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
Partition check:
 sda: sda1 < sda5 sda6 sda7 >
SCSI device sdb: 17774160 512-byte hdwr sectors (9100 MB)
 sdb: sdb1 sdb2
SCSI device sdc: 17774160 512-byte hdwr sectors (9100 MB)
 sdc: sdc1
