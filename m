Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279706AbRJYEyJ>; Thu, 25 Oct 2001 00:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279707AbRJYEx6>; Thu, 25 Oct 2001 00:53:58 -0400
Received: from marine.sonic.net ([208.201.224.37]:58665 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S279706AbRJYExs>;
	Thu, 25 Oct 2001 00:53:48 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 24 Oct 2001 21:53:28 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: modprobe problem with block-major-11
Message-ID: <20011024215328.A195@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a better list for this, let me know and I'll take the question
there.

I have a new CDRW I've been trying to get working for a couple of months
now.  Working with autoloading the modules anyway.

I've tried following the CD-Writing HOWTO for setting up modules.conf with
no luck.

Currently my modules.conf has:
options ide-cd ignore=hdc            # tell the ide-cd module to ignore h
alias block-major-11 sr_mod          # load sr_mod upon access of scd0
pre-install sg     modprobe ide-scsi # load ide-scsi before sg
pre-install sr_mod modprobe ide-scsi # load ide-scsi before sr_mod
pre-install ide-scsi modprobe ide-cd # load ide-cd   before ide-scsi

And lilo.conf has:
append="hdc=scsi"

Of course, also tried hdc=ide-scsi with same results.

Now, if I try something like ``head /dev/scd0''  I see the following in
dmesg:
SCSI subsystem driver Revision: 1.00
Uniform CD-ROM driver unloaded

And the following in /var/log/ksymoops:
20011024 214049 start /sbin/modprobe -s -k -- block-major-11 safemode=1
20011024 214050 probe ended

Now, if I take the command from that:
/sbin/modprobe -s -k -- block-major-11

I get the following:
thune:~# /sbin/modprobe -s -k -- block-major-11
Warning: loading /lib/modules/2.4.12/kernel/drivers/cdrom/cdrom.o will
taint the kernel: no license
Warning: loading /lib/modules/2.4.12/kernel/drivers/ide/ide-cd.o will taint the
kernel: no license
ide-cd: ignoring drive hdc
  Vendor: PHILIPS   Model: PCRW804           Rev:  2,1
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray

ksymoops has:
20011024 214923 start /sbin/modprobe -s -k -- block-major-11 safemode=0
20011024 214923 start modprobe ide-scsi safemode=0
20011024 214923 start modprobe ide-cd safemode=0
20011024 214924 probe ended
20011024 214924 probe ended
20011024 214924 probe ended

And dmesg shows:
CSI subsystem driver Revision: 1.00
ide-cd: ignoring drive hdc
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PHILIPS   Model: PCRW804           Rev:  2,1
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12


So, it appears to me that the autoloading should work.  But it's not.

What am I missing?

Help appreciated,
mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
