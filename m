Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUL2Wp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUL2Wp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUL2Wp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:45:56 -0500
Received: from mail.dif.dk ([193.138.115.101]:56503 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261430AbUL2Wpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:45:46 -0500
Date: Wed, 29 Dec 2004 23:56:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paulo Marques <pmarques@grupopie.com>
Cc: William Park <opengeometry@yahoo.ca>, linux-kernel@vger.kernel.org,
       Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
In-Reply-To: <41D306AF.1020500@grupopie.com>
Message-ID: <Pine.LNX.4.61.0412292341400.3495@dragon.hygekrogen.localhost>
References: <20041227195645.GA2282@node1.opengeometry.net>
 <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at>
 <20041229005922.GA2520@node1.opengeometry.net>
 <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost>
 <20041229015622.GA2817@node1.opengeometry.net> <41D2A7BE.2030806@grupopie.com>
 <20041229191525.GA2597@node1.opengeometry.net> <41D306AF.1020500@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Paulo Marques wrote:

> William Park wrote:
> > [...]
> > I read Documentation/initrd.txt and I don't understand it.  If I
> > understand it right, I have to build a complete root filesystem with all
> > the stuffs necessary for mounting the second (real) root filesystem.  If
> > I'm loading the kernel from floppy, then I only have 200k to work with.
> > I'll try initrd.txt, step by step over the holidays.
> 
> Yes, but if you use "nash" as a script parser and compile everything you need
> static with dietlibc or uClibc (or some other small libc replacement), 200k
> will be plenty to accomplish what you want. You'll probably be able to find
> pre-compiled binaries like these on the net, if you search for them.
> 
ash is also a great little shell for stuff like that - it's very close to 
bash syntax (which most people are familliar with) and it's resonably 
small.

Also, busybox is something you want to take a look at, it's a single 
binary that implements tiny versions of a lot of unix utilities - current 
version implements these (note it includes a tiny ash shell as well): 

addgroup, adduser, adjtimex, ar, arping, ash, awk, basename, bunzip2,
busybox, bzcat, cal, cat, chgrp, chmod, chown, chroot, chvt, clear, cmp,
cp, cpio, crond, crontab, cut, date, dc, dd, deallocvt, delgroup, deluser,
devfsd, df, dirname, dmesg, dos2unix, dpkg, dpkg-deb, du, dumpkmap,
dumpleases, echo, egrep, env, expr, false, fbset, fdflush, fdformat, fdisk,
fgrep, find, fold, free, freeramdisk, fsck.minix, ftpget, ftpput, getopt,
getty, grep, gunzip, gzip, halt, hdparm, head, hexdump, hostid, hostname,
httpd, hush, hwclock, id, ifconfig, ifdown, ifup, inetd, init, insmod,
install, ip, ipaddr, ipcalc, iplink, iproute, iptunnel, kill, killall,
klogd, lash, last, length, linuxrc, ln, loadfont, loadkmap, logger, login,
logname, logread, losetup, ls, lsmod, makedevs, md5sum, mesg, mkdir,
mkfifo, mkfs.minix, mknod, mkswap, mktemp, modprobe, more, mount, msh, mt,
mv, nameif, nc, netstat, nslookup, od, openvt, passwd, patch, pidof, ping,
ping6, pipe_progress, pivot_root, poweroff, printf, ps, pwd, rdate,
readlink, realpath, reboot, renice, reset, rm, rmdir, rmmod, route, rpm,
rpm2cpio, run-parts, rx, sed, seq, setkeycodes, sha1sum, sleep, sort,
start-stop-daemon, strings, stty, su, sulogin, swapoff, swapon, sync,
sysctl, syslogd, tail, tar, tee, telnet, telnetd, test, tftp, time, top,
touch, tr, traceroute, true, tty, udhcpc, udhcpd, umount, uname,
uncompress, uniq, unix2dos, unzip, uptime, usleep, uudecode, uuencode,
vconfig, vi, vlock, watch, watchdog, wc, wget, which, who, whoami, xargs,
yes, zcat

Most of these are ofcourse somewhat limited in functionality compared to 
their full-blown cousins, but for use on a initrd busybox can be close to 
the only app you need, and you can build it to include or exclude the 
commands you need/don't need, so it can get quite tiny.
A static build of busybox with just the commands that you need enabled and 
linked against uClibc or similar is what I would use.

Take a look : http://www.busybox.net/


-- 
Jesper Juhl


