Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132138AbRAOFen>; Mon, 15 Jan 2001 00:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132195AbRAOFee>; Mon, 15 Jan 2001 00:34:34 -0500
Received: from 23-97.apx-2.noc.supernet.com ([64.41.23.97]:4868 "EHLO
	lilith.belledonna.mine.nu") by vger.kernel.org with ESMTP
	id <S132138AbRAOFe0>; Mon, 15 Jan 2001 00:34:26 -0500
Date: Mon, 15 Jan 2001 00:34:08 -0500
From: James Mastros <james@rtweb.net>
To: linux-kernel@vger.kernel.org
Cc: james@rtweb.net
Subject: Loopback almost-freeze?
Message-ID: <20010115003406.A556@lilith.belledonna.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all.  I recently noticed, while setting up a disk image for plex86, a
bug in loopback mounting.  This happens on at least 2.4.0 and 2.4.0-ac9.

Steps for me to reproduce (as root):
1) losetup /dev/loop0 losetup -o $((512*63)) /dev/loop0 /usr/src/emu/plex86/guest/hdd
2) mount /dev/loop0 /mnt
3) cp -R /chris/windows/* /mnt/windows
After a few minutes, the copy will stop.  At this point, most new processes
seem to hang.  Sometimes, you can get an executable to start working at
random, from which point forward it will work fine.  Doing an ls in cp's
/proc/nnn directory will hang as well.  Sometimes SAK (SysRq-K) will kill
hung processes, somtimes not.  If it does, getty will run, but login won't
normaly, so you can't log back in.

After the freeze, SysRq-U and S won't work -- they never display the
per-device lines.

Step 3 doesn't have to be a simple cp.  I did tar -cvvI /chris/windows/*
|tar -xvvI /mnt/windows (or similar) to check once, and the same thing
happened.

This is a single-drive system, so all the files in question are on the same
hda, a IBM IDE drive on an AMD Viper chipset.

	 -=- James Mastros

PS -- Please CC me on replies; I'm not subscribed.
-- 
midendian: She never sleeps.
mousetrout: But I do.  I just regret it after I wake up.
AIM: theorbtwo homepage: http://www.rtweb.net/theorb/
ICBM: 40:04:15.100 N, 76:18:53.165 W
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
