Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRIPX30>; Sun, 16 Sep 2001 19:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273215AbRIPX3Q>; Sun, 16 Sep 2001 19:29:16 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:54494 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S273213AbRIPX3J>; Sun, 16 Sep 2001 19:29:09 -0400
Message-Id: <200109162329.f8GNTY918084@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: linux-kernel@vger.kernel.org
Subject: Disk errors and Reiserfs
Date: Sun, 16 Sep 2001 19:29:27 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Device 08:11 not ready.
 I/O error: dev 08:11, sector 26908624
Device 08:11 not ready.
 I/O error: dev 08:11, sector 121208
Device 08:11 not ready.
 I/O error: dev 08:11, sector 26908624
Device 08:11 not ready.
 I/O error: dev 08:11, sector 278936
vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [487 
175497 0x0 SD] stat data<6>Device 08:11 not ready.
 I/O error: dev 08:11, sector 75432
vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [260 
487 0x0 SD] stat data<6>Device 08:11 not ready.
 I/O error: dev 08:11, sector 65680
journal-712: buffer write failed
kernel BUG at prints.c:332!

Basically, one of the server's drives (not the root one, though) stopped 
responding.  It seems better after a power cycle, but it definately 
appeared to be a hardware problem.

My issue, though, is Linux did not handle it well.  Userspace actually has 
an 'EIO' error code for this situation but, instead, any program touching 
the mounted partition hung in a D state.

You can't kill the processes; you can't unmount the partition; you 
consequently can't reboot the box in any normal manner.  The box was in a 
pretty broken, unusable state.

Is it possible for the kernel to handle this with enough grace that you 
can kill the processes and unmount the partition?  (Thus allowing the box 
to continue in a hobbled, but function manner.)  Failing that, is it 
possible for the kernel to handle it well enough for 'shutdown' to cleanly 
shutdown the box?

Thank you
	-- Brian
