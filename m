Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSEUBDb>; Mon, 20 May 2002 21:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316478AbSEUBDa>; Mon, 20 May 2002 21:03:30 -0400
Received: from surf.viawest.net ([216.87.64.26]:49077 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S316477AbSEUBD2>;
	Mon, 20 May 2002 21:03:28 -0400
Date: Mon, 20 May 2002 17:54:08 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: Two problems with 2.5.x, part 2
Message-ID: <20020521005408.GB7477@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 5:17pm  up 16:35,  2 users,  load average: 0.92, 0.27, 0.08
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        As for the second problem, which just happened: my web browser (Opera 
6.0 final, and 6.0B2) just crashed on me. Fine, no problem. But in crashing, 
should it lock up any shell running any program accessing /proc? This is 
reproducible with any kernel >= 2.5.7. After the crash, I get the following 
from ps:

bradl@bellicha:~> ps



        Hangs.

        'strace ps' shows:

open("/proc/1345/stat", O_RDONLY)       = 7
read(7, "1345 (in.identd) S 1340 1339 133"..., 511) = 184
close(7)                                = 0
open("/proc/1345/statm", O_RDONLY)      = 7
read(7, "254 254 193 8 5 241 61\n", 511) = 23
close(7)                                = 0
open("/proc/1345/status", O_RDONLY)     = 7
read(7, "Name:\tin.identd\nState:\tS (sleepi"..., 511) = 451
close(7)                                = 0
open("/proc/1345/cmdline", O_RDONLY)    = 7
read(7, "in.identd\0-P/dev/null\0", 2047) = 22
close(7)                                = 0
open("/proc/1345/environ", O_RDONLY)    = -1 EACCES (Permission denied)
stat64(0x4002eb60, 0xbffff3fc)          = 0
open("/proc/1528/stat", O_RDONLY)       = 7
read(7, "1528 (opera) S 1 292 231 1025 28"..., 511) = 183
close(7)                                = 0
open("/proc/1528/statm", O_RDONLY)      = 7
read(7, "261 261 212 84 0 177 49\n", 511) = 24
close(7)                                = 0
open("/proc/1528/status", O_RDONLY)     = 7
read(7, "Name:\topera\nState:\tS (sleeping)\n"..., 511) = 467
close(7)                                = 0
open("/proc/1528/cmdline", O_RDONLY)    = 7
read(7, "/bin/sh\0/usr/local/bin/X11/opera"..., 2047) = 33
close(7)                                = 0
open("/proc/1528/environ", O_RDONLY)    = 7
read(7, "PWD=/home/bradl\0XAUTHORITY=/home"..., 2047) = 1448
brk(0x816f000)                          = 0x816f000
close(7)                                = 0
stat64(0x4002eb60, 0xbffff3fc)          = 0
open("/proc/1529/stat", O_RDONLY)       = 7
read(7, 

        Then hangs. ctrl-c quits out of this.

        Even more so, any command accessing /proc hangs. this including w, ps, 
pstree, top, shutdown, kill, killall, and probably others I haven't tested 
yet. ps x will run, all the way up to the process which caused this, which is 
the crashed browser. But when a browser crashes, it shouldn't take out any 
other program accessing proc.

        So far, my only way around it, is a reboot. I can issue shutdown -r, 
and let it run through rc.K and rc.6. But.. it hangs in rc.K, which calls 
killall. I have to go into the box remotely (yep, even when runlevel6 has been 
called), manually remount all filesystems readonly, and issue a hard reboot 
command. it isn't pretty, but I get the system rebooted in a semi-clean way.

        The guys at Opera are saying that it's a kernel bug, since a process 
that has crashed shouldn't block accesses to /proc. But do concede that there 
could be a bug in Opera that triggers the bug in the kernel.

        Any ideas or insights into this?

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

