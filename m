Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRCYWH2>; Sun, 25 Mar 2001 17:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132227AbRCYWHS>; Sun, 25 Mar 2001 17:07:18 -0500
Received: from 213.237.12.137.adsl.vby.worldonline.dk ([213.237.12.137]:41774
	"HELO ache.dk") by vger.kernel.org with SMTP id <S132226AbRCYWHJ>;
	Sun, 25 Mar 2001 17:07:09 -0500
Date: Mon, 26 Mar 2001 00:06:22 +0200
From: John Plate <plate@infotek.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.2.17-RAID: Eating memory
Message-ID: <20010326000622.C12805@infotek.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have patched the 2.2.17 kernel (Debian) with the "new RAID" patches
with no errors.

I experienced a the following problem:

Two partitions are set up as RAID-1, but not yet fully
created/initialized. On boot, the process starts/continues
automatically (partitions /dev/hda3 and /dev/hdc3 set to type "Linux
raid autodetect", but not mounted in /etc/fstab).

/proc/mdstat says: 
md2 : active raid1 hdc3[1] hda3[0] 4723008 blocks [2/2] [UU]
resync=11% finish=77.3min

While this is active, I start an rsync between two other partitions
(/dev/hda1 and /dev/hdc1). This should be fine because RAID is
expected to work in background only. After a while the system reports
on the console a lot of "VM: do_try_to_free_pages failed" for many of
the daemon programs running. Before that, the swap usage increases but
there is enough swap space.

I guess that this is some kind of race condition because the RAID
program runs fine with no other heavy load. The rsync also behaves
well under other circumstances. I expect the problem to be with the
RAID code. 

The system is stable, it has never crashed. This is my first problem
with a Linux kernel.

Can anyone please help?
-- 
John Plate 
