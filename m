Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVCRSZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVCRSZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVCRSZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:25:47 -0500
Received: from mx1.informatik.uni-stuttgart.de ([129.69.211.41]:62366 "EHLO
	mx1.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S262006AbVCRSZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:25:08 -0500
Date: Fri, 18 Mar 2005 19:25:06 +0100
From: Nils Radtke <Nils.Radtke@Think-Future.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Buffer I/O error on device hdg1, system freeze.
Message-ID: <20050318192506.A20997@marvin.informatik.uni-stuttgart.de>
Reply-To: Nils Radtke <Nils.Radtke@Think-Future.de>
Mail-Followup-To: Nils Radtke <Nils.Radtke@Think-Future.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Linux Kernel-Liste <linux-kernel@vger.kernel.org>
References: <20050318152952.7657144FBE@service.i-think-future.de> <58cb370e0503180929716ffea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <58cb370e0503180929716ffea3@mail.gmail.com>; from bzolnier@gmail.com on Fri, Mar 18, 2005 at 06:29:25PM +0100
X-Url: http://www.Think-Future.de
X-Editor: Vi it! http://www.vim.org
X-Bkp: p2mi
X-GnuPG-Key: gpg --keyserver search.keyserver.net --recv-keys 06232116
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi Bartlomiej,

Thanks for your link.

# >  hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
# >  hdg: dma_intr: error=0x40 { UncorrectableError }, LBAsect=262311, high=0, low=262311, sector=262311
# >  ide: failed opcode was: unknown
# >  end_request: I/O error, dev hdg, sector 262311
# >  Buffer I/O error on device hdg1, logical block 131124
# > 
# >   fscking this disk freezes the entire system.
# > 
# >  The disk was remounted ro afterwards.
# >  Disk itself is ok. Is a new one.

# http://smartmontools.sf.net
Extract from /usr/share/doc/smartmontools/WARNINGS.gz:

SYSTEM:   Promise 20265 IDE-controller
PROBLEM:  Smartctl locks system solid when used on CDROM/DVD device
REPORTER: see link below
LINK:     http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=208964
NOTE:     Problem seems to affect kernel 2.4.21 only.


SYSTEM:   Promise IDE-controllers and perhaps others also
PROBLEM:  System freezes under heavy load, perhaps when running SMART
commands
REPORTER: Mario 'BitKoenig' Holbe Mario.Holbe@RZ.TU-Ilmenau.DE
LINK:
http://groups.google.de/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=1wUXW-
2FA-9%40gated-at.bofh.it
NOTE:     Before freezing, SYSLOG shows the following message(s)
          kernel: hdf: dma timer expiry: dma status == 0xXX
          where XX is two hexidecimal digits. This may be a kernel bug
          or an underlying hardware problem.  It's not clear if
          smartmontools plays a role in provoking this problem.  FINAL
          NOTE: Problem was COMPLETELY resolved by replacing the power
          supply.  See URL above, entry on May 29, 2004 by Holbe.  Other
          things to try are exchanging cables, and cleaning PCI slots.


This sounds highly familiar and shows an at least hidden
correlation(-potential) between this kind of error and the Promise controller 
PDC drivers.
Ok, maybe I'm suffering prejudices now. We'll see.
A year ago, other disks (IBM/WD) had trouble on the PDC also, but not on onboard
controllers. And they are still spinning today. (Means, they had not to
be replaced for hard disk errors)

Fact is however, that as mailed last year, even after a complete
exchange of mainboard and processor, the problem perexists through any
kernel-version. Furthermore, countless posts indicate similar or same
symptoms.

Nevertheless, I keep the list up-to-date in case of new info.

smartctl -a /dev/hdc gives:
Error 18 occurred at disk power-on lifetime: 2249 hours (93 days + 17
hours)
  When the command that caused the error occurred, the device was active
or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 f8 a8 05 c3 e0  Error: UNC at LBA = 0x00c305a8 = 12780968

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  24 00 f8 a7 05 c3 06 00      00:08:14.850  READ SECTOR(S) EXT
  25 00 00 9f 05 c3 06 00      00:08:14.850  READ DMA EXT
  25 00 00 9f 04 c3 06 00      00:08:14.850  READ DMA EXT
  25 00 00 9f 03 c3 06 00      00:08:14.850  READ DMA EXT
  25 00 00 9f 02 c3 06 00      00:08:14.850  READ DMA EXT

Error 17 occurred at disk power-on lifetime: 2249 hours (93 days + 17
hours)
  When the command that caused the error occurred, the device was active
or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 47 06 c3 e0  Error: UNC at LBA = 0x00c30647 = 12781127

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 00 9f 05 c3 06 00      00:07:48.550  READ DMA EXT
  25 00 00 9f 04 c3 06 00      00:07:48.550  READ DMA EXT
  25 00 00 9f 03 c3 06 00      00:07:48.550  READ DMA EXT
  25 00 00 9f 02 c3 06 00      00:07:48.550  READ DMA EXT
  25 00 00 9f 01 c3 06 00      00:07:48.550  READ DMA EXT

Error 16 occurred at disk power-on lifetime: 2249 hours (93 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 20 b0 f2 57 e0  Error: UNC at LBA = 0x0057f2b0 = 5763760

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  24 00 20 af f2 57 10 00      00:43:45.600  READ SECTOR(S) EXT
  25 00 28 a7 f2 57 10 00      00:43:45.600  READ DMA EXT
  25 00 18 77 f2 57 10 00      00:43:45.600  READ DMA EXT
  25 00 18 5f 28 57 11 00      00:43:45.600  READ DMA EXT
  25 00 08 7f 10 54 10 00      00:43:45.600  READ DMA EXT

Error 15 occurred at disk power-on lifetime: 2249 hours (93 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 28 b9 f2 57 e0  Error: UNC 40 sectors at LBA = 0x0057f2b9 =
5763769

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 28 a7 f2 57 10 00      00:43:17.850  READ DMA EXT
  25 00 18 77 f2 57 10 00      00:43:17.850  READ DMA EXT
  25 00 18 5f 28 57 11 00      00:43:17.850  READ DMA EXT
  25 00 08 7f 10 54 10 00      00:43:17.850  READ DMA EXT
  25 00 08 77 28 57 11 00      00:43:17.850  READ DMA EXT

Error 14 occurred at disk power-on lifetime: 2249 hours (93 days + 17
hours)
  When the command that caused the error occurred, the device was doing
SMART Offline or Self-test.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 f8 23 3e 56 e0  Error: UNC at LBA = 0x00563e23 = 5652003

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  24 00 f8 07 3e 56 10 00      00:36:28.850  READ SECTOR(S) EXT
  25 00 00 ff 3d 56 10 00      00:36:28.850  READ DMA EXT
  25 00 00 ff 3c 56 10 00      00:36:28.850  READ DMA EXT
  25 00 00 ff 3b 56 10 00      00:36:28.850  READ DMA EXT
  25 00 00 ff 3a 56 10 00      00:36:28.850  READ DMA EXT


Could you please explain what these errors mean exactly and what may
have caused them?

Might it be possible that these transmission/xxx errors be caused 
by a bad card and/or driver?

I'm asking this as the disk never showed errors on onboard IDE ports.

        Nils

-- 
A+
* N.Radtke@                 * University of Stuttgart *    icq / lc   *
*      www.Think-Future.de  *    dep.comp.science     * 9336272/92045 *
:x                            UTM 32 0515651 5394088                 :)
   One FISHWICH coming up!! 
   
   
