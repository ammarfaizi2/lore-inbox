Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291908AbSBTPTe>; Wed, 20 Feb 2002 10:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291918AbSBTPTY>; Wed, 20 Feb 2002 10:19:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:57731 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291908AbSBTPTS>; Wed, 20 Feb 2002 10:19:18 -0500
Date: Wed, 20 Feb 2002 10:21:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Glover George <dime@gulfsales.com>
cc: "'Mr. James W. Laferriere'" <babydr@baby-dragons.com>,
        linux-kernel@vger.kernel.org
Subject: RE: st0: Block limits 1 - 16777215 bytes.
In-Reply-To: <003601c1ba1e$ce631630$0300a8c0@yellow>
Message-ID: <Pine.LNX.3.95.1020220100827.5893A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Glover George wrote:

> Ok, after playing with it a little more I found out that the message I'm
> getting about the block sizes isn't related to the lockups.  I can lock
> the system up by tar'ing up the /proc directory (why are you tar'ing the
> /proc directory!!! I know!!! But that's not the point).  I had no
> problem with RH 7.2's supplied 7.2 kernel (2.4.7-10).  However, this is
> 2.4.17 (with the linux-abi patch). 
> 
> I have been able to make succesful backups as long as I ignore the /proc
> directory but something must be wrong.  Doing an "ls -la *" doesn't lock
> the machine though.  Only when tar'ing it (I suppose because of a read).
> It doesn't lock up consistently in the same place when reading from the
> proc directory however, but always in the proc.  I made about 15 test
> runs and they all died in proc and --exclude proc doesn't cause it to
> lock somewhere else.

You do not tar /proc!  There is kcore there! `tar` thinks it's a real
file. Reading (accessing) some kernel areas will cause a deadlock.

If you don't want to --exclude proc, then `umount` it before your
backups. FYI, it's SOP to backup different mounted file-systems so
you don't end up backing up N disks on a single media. Therefore
your `tar` sequence would be something like:

tar -czlf root.tar.gz /
tar -czlf user.tar.gz /user
       |________ stay on the same file-system.
..etc..

Since /proc is a seperate file-system, you never have problems like
you describe and the mount-point gets backed up as required.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

