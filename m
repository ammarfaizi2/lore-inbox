Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTFHRtq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTFHRtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 13:49:46 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:7884 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263610AbTFHRtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 13:49:43 -0400
Date: Sun, 8 Jun 2003 19:08:38 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RAID0 breakage in 2.5.70-bk
Message-ID: <20030608180838.GA769@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current 2.5-bk has problems detecting a 2-disk RAID0 set.

Here's how things look in 2.4, and in 2.5.69

md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000154]
 [events: 00000154]
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1,1>
md: bind<hdg1,2>
md: running: <hdg1><hde1>
md: hdg1's event counter: 00000154
md: hde1's event counter: 00000154
md0: max total readahead window set to 1024k
md0: 2 data-disks, max readahead per data-disk: 512k
raid0: looking at hde1
raid0:   comparing hde1(45034752) with hde1(45034752)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdg1
raid0:   comparing hdg1(45034752) with hde1(45034752)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hde1 ... contained as device 0
  (45034752) is smallest!.
raid0: checking hdg1 ... contained as device 1
raid0: zone->nb_dev: 2, size: 90069504
raid0: current zone offset: 45034752
raid0: done.
raid0 : md_size is 90069504 blocks.
raid0 : conf->smallest->size is 90069504 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdg1 [events: 00000155]<6>(write) hdg1's sb offset: 45034816
md: hde1 [events: 00000155]<6>(write) hde1's sb offset: 45034816
md: ... autorun DONE

In current 2.5.70-bk however, things take a turn for the worst..

 md: Autodetecting RAID arrays.
 md: autorun ...
 md: considering hdg1 ...
 md:  adding hdg1 ...
 md:  adding hde1 ...
 md: created md0
 md: bind<hde1>
 md: bind<hdg1>
 md: running: <hdg1><hde1>
 md0: setting max_sectors to 256, segment boundary to 65535
 raid0: looking at hdg1
 raid0:   comparing hdg1(45034752) with hdg1(45034752)
 raid0:   END
 raid0:   ==> UNIQUE
 raid0: 1 zones
 raid0: looking at hde1
 raid0:   comparing hde1(45034752) with hdg1(45034752)
 raid0:   EQUAL
 raid0: FINAL 1 zones
 raid0: multiple devices for 1 - aborting!
 md: pers->run() failed ...
 md :do_md_run() returned -22
 md: md0 stopped.
 md: unbind<hdg1>
 md: export_rdev(hdg1)
 md: unbind<hde1>
 md: export_rdev(hde1)
 md: ... autorun DONE.


