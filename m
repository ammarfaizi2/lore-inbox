Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277851AbUKBAfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277851AbUKBAfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S386259AbUKBAfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:35:08 -0500
Received: from fep17.inet.fi ([194.251.242.242]:20417 "EHLO fep17.inet.fi")
	by vger.kernel.org with ESMTP id S270450AbUKBAXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:23:53 -0500
Date: Tue, 2 Nov 2004 02:23:45 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9 / reiserfs / exec-shield: /bin/bash changed!
Message-ID: <20041102002345.GA16561@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this is spooky.
I started getting segfaults when starting /bin/bash.
Turned out a couple hundred bytes starting from file offset 0xa000
had changed.

$ cmp -l bash-3.0-17-b0rk3n bash-3.0-17-virgin
 40961  10  21
 40963   0  27
 40964  24   0
 40965   0 303
 40966 120   0
 40967 133   0
 40968   5   0
 40969 370   0
 40970   3   0
 40972  30   0
 40973  10 260
 40974 134   0
 40975 133   0
...

I have no idea how that could have happened.
Now that I think of it, about three weeks ago the same happened
to one mozilla .so file, so it segfaulted on startup.
I had used mozilla only as non-privileged luser.

I have UP i386 2.6.9, /bin is on reiserfs partition (IBM-DTTA-351350 +
PIIX4), kernel compiled with gcc 2.95.3, no any odd kernel messages,
haven't used Direct IO.  Other devices in use RTL8139, ENS1371, BT878.
I haven't noticed corruption for music, image or tarball etc files...

I have also exec-shield-nx-2.6.9-A2.
Here /proc/*/maps of one bash process.  glibc is 2.3.3-73 from Fedora.

0052f000-00531000 r-xp 00000000 16:46 705185     /lib/libdl-2.3.3.so
00531000-00532000 r-xp 00001000 16:46 705185     /lib/libdl-2.3.3.so
00532000-00533000 rwxp 00002000 16:46 705185     /lib/libdl-2.3.3.so
00dbf000-00dc2000 r-xp 00000000 16:46 398897     /lib/libtermcap.so.2.0.8
00dc2000-00dc3000 rwxp 00002000 16:46 398897     /lib/libtermcap.so.2.0.8
05a4b000-05a60000 r-xp 00000000 16:46 705113     /lib/ld-2.3.3.so
05a60000-05a61000 r-xp 00014000 16:46 705113     /lib/ld-2.3.3.so
05a61000-05a62000 rwxp 00015000 16:46 705113     /lib/ld-2.3.3.so
05a64000-05b85000 r-xp 00000000 16:46 705184     /lib/tls/libc-2.3.3.so
05b85000-05b87000 r-xp 00120000 16:46 705184     /lib/tls/libc-2.3.3.so
05b87000-05b89000 rwxp 00122000 16:46 705184     /lib/tls/libc-2.3.3.so
05b89000-05b8b000 rwxp 05b89000 00:00 0 
08048000-080f4000 r-xp 00000000 16:46 709085     /bin/bash-3.0-17
080f4000-080fa000 rwxp 000ab000 16:46 709085     /bin/bash-3.0-17
080fa000-08162000 rwxp 080fa000 00:00 0 
b7db0000-b7db2000 rwxp b7db0000 00:00 0 
b7db2000-b7dbb000 r-xp 00000000 16:46 398835     /lib/libnss_files-2.3.3.so
b7dbb000-b7dbc000 r-xp 00008000 16:46 398835     /lib/libnss_files-2.3.3.so
b7dbc000-b7dbd000 rwxp 00009000 16:46 398835     /lib/libnss_files-2.3.3.so
b7dd7000-b7ddd000 r-xs 00000000 16:03 18788      /usr/lib/gconv/gconv-modules.cache
b7ddd000-b7dde000 r-xp 0077d000 16:03 125645     /usr/lib/locale/locale-archive
b7dde000-b7fde000 r-xp 00000000 16:03 125645     /usr/lib/locale/locale-archive
b7fde000-b7fe0000 rwxp b7fde000 00:00 0 
bfff9000-c0000000 rw-p bfff9000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 

How do I catch the guilty party (who's causing corruption) next time?
Some nice BUG_ONs to try?  (If we assume this is kernel bug...)

http://safari.iki.fi/config-20041030-1.txt

If someone (besides the bots) wants to view the
executables, replace "fix" with "fi"
http://safari.iki.fix/bash-3.0-17-virgin.bz2
http://safari.iki.fix/bash-3.0-17-b0rk3n.bz2
http://safari.iki.fix/bash-3.0-17.src.rpm

-- 
