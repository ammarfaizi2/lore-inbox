Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131141AbRCGSWH>; Wed, 7 Mar 2001 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbRCGSV6>; Wed, 7 Mar 2001 13:21:58 -0500
Received: from [213.203.46.68] ([213.203.46.68]:6673 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131141AbRCGSVt>; Wed, 7 Mar 2001 13:21:49 -0500
To: linux-kernel@vger.kernel.org
Subject: process with connection in CLOSE_WAIT won't die in 2.4.2
From: remco@solbors.no (Remco B. Brink)
Organization: Norge-iNvest <http://www.norge-invest.no>
Date: 07 Mar 2001 19:19:47 +0100
Message-ID: <m38zmh8mrg.fsf@localhost.localdomain>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after Emacs+Gnus went unusable (blank unresponsive Emacs client)
I noticed that there's no way to kill the Emacs process.

According to ps output, the process is in Uninterruptable sleep (usually IO).

One NNTP connection is left open in CLOSE_WAIT and lsof shows that
a unix socket and a couple of sockets with unidentified protocol
are still open.

Emacs still consumes about 13megs of memory and generates a .2 load.

Tried shooting the process with all logical kill signals, no success.

Tried going into single-user mode, tried shutting down network and 
the network interface (eth0), no success. (Which reminds me, why after
shutting down network and ifdown eth0 is it still leaving FTP connections
open and will data still come in? Shouldn't the system shut down all
connections?)

Netstat output:
[root@grolsch /root]# netstat
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp       28      0 grolsch.solbors.no:3093 forums.sybase.com:nntp  CLOSE_WAIT  

lsof output:
[root@grolsch /root]# lsof -p 444
COMMAND PID  USER   FD   TYPE     DEVICE    SIZE      NODE NAME
emacs   444 remco  cwd    DIR        3,6    4096     32769 /home/remco
emacs   444 remco  rtd    DIR        3,1    4096         2 /
emacs   444 remco  txt    REG        3,1 3507800     64379 /usr/bin/emacs
emacs   444 remco  mem    REG        3,1  434945    384004 /lib/ld-2.1.92.so
emacs   444 remco  mem    REG        3,1  298296    625419 /usr/X11R6/lib/libXaw3d.so.7.0
emacs   444 remco  mem    REG        3,1   84200    624194 /usr/X11R6/lib/libXmu.so.6.1
emacs   444 remco  mem    REG        3,1  309328    624200 /usr/X11R6/lib/libXt.so.6.0
emacs   444 remco  mem    REG        3,1   32028    624178 /usr/X11R6/lib/libSM.so.6.0
emacs   444 remco  mem    REG        3,1   82964    624174 /usr/X11R6/lib/libICE.so.6.3
emacs   444 remco  mem    REG        3,1   52420    624188 /usr/X11R6/lib/libXext.so.6.4
emacs   444 remco  mem    REG        3,1  843812    624180 /usr/X11R6/lib/libX11.so.6.1
emacs   444 remco  mem    REG        3,1  257300    240383 /usr/lib/libncurses.so.5.2
emacs   444 remco  mem    REG        3,1  501140    384017 /lib/libm-2.1.92.so
emacs   444 remco  mem    REG        3,1 4776568    384011 /lib/libc-2.1.92.so
emacs   444 remco  mem    REG        3,1   55524    624198 /usr/X11R6/lib/libXpm.so.4.11
emacs   444 remco  mem    REG        3,1  234205    384034 /lib/libnss_files-2.1.92.so
emacs   444 remco  mem    REG        3,1  290019    384040 /lib/libnss_nisplus-2.1.92.so
emacs   444 remco  mem    REG        3,1  380006    384020 /lib/libnsl-2.1.92.so
emacs   444 remco  mem    REG        3,1  274024    384038 /lib/libnss_nis-2.1.92.so
emacs   444 remco  mem    REG        3,1   63446    384032 /lib/libnss_dns-2.1.92.so
emacs   444 remco  mem    REG        3,1  231175    384045 /lib/libresolv-2.1.92.so
emacs   444 remco    0r   CHR        1,3            192153 /dev/null
emacs   444 remco    1u   CHR        4,1            196113 /dev/tty1
emacs   444 remco    2u   CHR        4,1            196113 /dev/tty1
emacs   444 remco    3u  sock        0,0         126021605 can't identify protocol
emacs   444 remco    4u  unix 0xc2657cc0         126021557 socket
emacs   444 remco    5u  sock        0,0         128807295 can't identify protocol
emacs   444 remco    6u  sock        0,0         129072216 can't identify protocol
emacs   444 remco    7w   REG        3,6 5193728   2260997 /home/remco/Mail/archive/mail-archive~





How do I get rid of this process?

regards,
Remco

-- 
Remco B. Brink                                  Norge-iNvest AS
Kung foo                            http://www.norge-invest.com
        PGP/GnuPG key at http://remco.xgov.net/rbb.pgp

In most countries selling harmful things like drugs is punishable.
Then howcome people can sell Microsoft software and go unpunished?
(By hasku@rost.abo.fi, Hasse Skrifvars)

