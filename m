Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262516AbREZXAG>; Sat, 26 May 2001 19:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbREZW7I>; Sat, 26 May 2001 18:59:08 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261968AbREZW65>;
	Sat, 26 May 2001 18:58:57 -0400
Date: Sat, 26 May 2001 19:06:24 +0300 (EEST)
From: Doru Petrescu <pdoru@kappa.ro>
Reply-To: pdoru@kappa.ro
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to open an initial console (on SMP machine)
In-Reply-To: <Pine.LNX.4.21.0105261610140.10848-400000@bigD.kappa.ro>
Message-ID: <Pine.LNX.4.21.0105261858380.11060-100000@bigD.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, here are some more details:

NO, i do not use devfs.
thre is no problem at boot time. /dev directory is where it was supposed
to be. /sbin/ /etc and everything else is OK.
nothing is wrong with /dev directory. everything else WORKS.

just that /dev/console /dev/ttyX and /dev/ttyXX and /dev/vcs* stop
working:

this is what i geT:
root@k:~# cat /dev/console
cat: /dev/console: No such device
root@k:~# cat /dev/tty1
cat: /dev/tty1: No such device
root@k:~# cat /dev/vcs1
cat: /dev/vcs1: No such device or address

what amuse me is that i get different responses ... :-)

also, as far as i can see the major/minor IS ok ... (see below)

-----------------------------------------
/proc/devices
/proc/tty/drivers

/proc/devices is missing one line, the last one: 
	"unknown              /dev/vc/%d      4    1-63 console"


--------------------------------------------

root@k:~# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 36 netlink
 89 i2c
128 ptm
136 pts
162 raw

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  7 loop
 22 ide1

root@k:/proc/tty# cat drivers
                     /dev/cua        5  64-127 serial:callout
                     /dev/ttyS       4  64-127 serial
pty_slave            /dev/pts      136   0-255 pty:slave
pty_master           /dev/ptm      128   0-255 pty:master
pty_slave            /dev/ttyp       3   0-255 pty:slave
pty_master           /dev/pty        2   0-255 pty:master
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
/dev/ptmx            /dev/ptmx       5       2 system
/dev/console         /dev/console    5       1 system:console
/dev/tty             /dev/tty        5       0 system:/dev/tty

root@k:/proc/tty# cat ldiscs
n_tty       0


root@k:/proc# cd /dev
root@k:/dev# l console
   0 crw-------   1 root     tty        5,   1 Apr 21  1999 console
root@k:/dev# l tty1
   0 crw--w--w-   1 root     root       4,   1 May  4 12:47 tty1
root@k:/dev# l vcs1
   0 crw--w--w-   1 root     tty        7,   1 May  6  1996 vcs1



Best regards,
Doru Petrescu



On Sat, 26 May 2001, Doru Petrescu wrote:

> 
> starting with kernels 2.4.5-preX I get this at startup:
> 
> 	Warning: unable to open an initial console.
> 
> then none of the /dev/vcs* /dev/tty* doesn't work.
> 
> 
> 
> then i get this in syslog:
> 	May 26 16:10:19 www modprobe: modprobe: Can't open dependencies file /lib/modules/2.4.5/modules.dep (No such file or directory)
> 	May 26 16:10:19 www /sbin/agetty[383]: /dev/tty5: cannot open as standard input: No such device
> 
> lucky me that this machine is a network server and most (all) of the
> administrative tasks are done via SSH ...
> 
> I attache the .config file and the dmesg results and the /proc/pci file  ...
> 
> i don't understand what is WORNG ... it worked BEFORE ...
> i have " Virtual terminal " and "Support for console on virtual
> terminal "  enabled ...
> 
> anybody has any idea ?
> 
> also i see an "WARNING: unexpected IO-APIC, please mail" ... can this be
> the problem ?!? 
> 
> 
> Best regards,
> ------
> Doru Petrescu
> KappaNet - Senior Software Engineer
> E-mail: pdoru@kappa.ro		 LINUX - the choice of the GNU generation
> 
> 
> 
> 

