Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268277AbUHQPME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268277AbUHQPME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUHQPMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:12:03 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:51413 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S268277AbUHQPLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:11:11 -0400
Message-ID: <41221FDB.1020807@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:10:19 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [0/10]
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of fixes for gcc-3.4 inlining failures.
Most of them follow the "inline functions must be defined
before they're used" rule. Fixes were taken from the 2.6
tree whenever possible. These patches  apply after Mikael's
inline fixes posted recently at this list. Compile tested
with gcc-3.4.0.  Please review and apply to 2.4.28.

Regards,
Ozkan Sezer

#01 -> drivers/block/*
#02 -> drivers/char/*
#03 -> drivers/ieee1394/*, drivers/isdn/*
#04 -> drivers/media/*
#05 -> drivers/mtd/*
#06 -> drivers/net/*
#07 -> drivers/scsi/*
#08 -> drivers/usb/*, drivers/video/*
#09 -> fs/*
#10 -> net/*

  drivers/block/cciss.c                  |   59 +-
  drivers/block/cpqarray.c               |   27 -
  drivers/char/ip2main.c                 |    8
  drivers/char/istallion.c               |   40 -
  drivers/char/mxser.c                   |  196 ++++----
  drivers/ieee1394/eth1394.c             |   29 -
  drivers/isdn/hisax/isar.c              |   30 -
  drivers/media/radio/radio-maestro.c    |   48 +-
  drivers/media/video/w9966.c            |   16
  drivers/mtd/devices/doc1000.c          |  227 ++++-----
  drivers/net/dmfe.c                     |   28 -
  drivers/net/e100/e100_main.c           |  272 +++++------
  drivers/net/e1000/e1000_main.c         |  126 ++---
  drivers/net/eql.c                      |  334 +++++++-------
  drivers/net/hamachi.c                  |  206 ++++-----
  drivers/net/hamradio/dmascc.c          |  237 +++++-----
  drivers/net/smc9194.c                  |  250 +++++------
  drivers/scsi/AM53C974.c                |  144 +++---
  drivers/scsi/aic7xxx/aic79xx_osm.c     |   26 -
  drivers/scsi/ips.c                     |  750 
++++++++++++++++-----------------
  drivers/scsi/megaraid.c                |   36 -
  drivers/scsi/megaraid2.c               |  482 ++++++++++-----------
  drivers/scsi/megaraid2.h               |   10
  drivers/scsi/nsp32.c                   |   85 +--
  drivers/scsi/qla1280.c                 |   69 +--
  drivers/scsi/scsiiom.c                 |  120 ++---
  drivers/scsi/sim710.c                  |  332 +++++++-------
  drivers/usb/host/hc_sl811.c            |    6
  drivers/usb/ov511.c                    |    6
  drivers/usb/se401.c                    |   76 +--
  drivers/usb/w9968cf.c                  |   10
  drivers/video/riva/fbdev.c             |    2
  fs/freevxfs/vxfs_extern.h              |    2
  fs/freevxfs/vxfs_subr.c                |   13
  fs/intermezzo/cache.c                  |    8
  fs/intermezzo/file.c                   |    9
  fs/intermezzo/journal_xfs.c            |    2
  fs/intermezzo/methods.c                |    2
  fs/intermezzo/psdev.c                  |    7
  fs/intermezzo/sysctl.c                 |    5
  fs/ncpfs/ncplib_kernel.h               |    2
  include/linux/fs.h                     |    2
  include/linux/fsfilter.h               |   32 -
  include/linux/intermezzo_fs.h          |  124 ++---
  include/linux/reiserfs_fs.h            |   24 -
  include/net/irda/irlmp_frame.h         |    2
  include/net/irda/timer.h               |   18
  net/appletalk/ddp.c                    |    4
  net/atm/lec.c                          |    8
  net/bluetooth/l2cap.c                  |   18
  net/bluetooth/sco.c                    |   49 +-
  net/ipv4/netfilter/ip_nat_snmp_basic.c |  142 +++---
  net/irda/wrapper.c                     |   54 +-
  53 files changed, 2406 insertions(+), 2408 deletions(-)
