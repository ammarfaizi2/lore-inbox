Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRDWF2T>; Mon, 23 Apr 2001 01:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRDWF2B>; Mon, 23 Apr 2001 01:28:01 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:43157 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S131246AbRDWF1q>; Mon, 23 Apr 2001 01:27:46 -0400
Date: Sun, 22 Apr 2001 22:27:01 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <manuel@mclure.org>,
        Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
In-Reply-To: <200104230517.f3N5HqP214245@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0104222221150.32508-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Albert D. Cahalan wrote:

> Try this:
>
> ps -t pts/2 -o pid,ppid,pgid,sess,f,stat,ruid,euid,fname,nwchan,wchan
> ps -t pts/2 s

OK, below are the results.  Since I'm sleepy I haven't looked up the ps
man page to see what it all means or whether I need to translate any
numbers into symbols, sorry.  Let me know if you'd like anything else.

Cheers, Wayne


[whitney@pizza whitney]$ ps auxwOT
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
[ . . . ]
root      1792  0.1  0.2  2300 1068 pts/0    S    22:19   0:00 /bin/su -
root      1796  0.2  0.2  2356 1384 pts/0    S    22:19   0:00 -bash
root      1825  0.0  0.1  2112  952 pts/0    S    22:19   0:00 /bin/su -
root      1826  0.2  0.2  2188 1148 pts/0    S    22:19   0:00 -bash
root      1854  0.0  0.0  1352  412 pts/0    T    22:19   0:00 stty erase ?
whitney   1855  0.0  0.1  2664  792 pts/2    R    22:19   0:00 ps auxwOT
[whitney@pizza whitney]$ ps -t pts/0 -o pid,ppid,pgid,sess,f,stat,ruid,euid,fname,nwchan,wchan
  PID  PPID  PGID  SESS   F STAT  RUID  EUID COMMAND   WCHAN WCHAN
 1722  1711  1722  1722 000 S      500   500 bash     117801 wait4
 1792  1722  1792  1722 000 S      500     0 su       117801 wait4
 1796  1792  1796  1722 100 S        0     0 bash     117801 wait4
 1825  1796  1825  1722 000 S        0     0 su       117801 wait4
 1826  1825  1826  1722 100 S        0     0 bash     117801 wait4
 1854  1826  1826  1722 000 T        0     0 stty     106a5f do_signal
[whitney@pizza whitney]$ ps -t pts/0 s
  UID   PID   PENDING   BLOCKED   IGNORED    CAUGHT STAT TTY        TIME COMMAND
  500  1722  00000000  00010000 <00384004  4b813efb S    pts/0      0:00 bash
    0  1792  00000000 <fffb9eff <00000000  00004000 S    pts/0      0:00 /bin/su -
    0  1796  00000000  00010000 <00384004  4b813efb S    pts/0      0:00 -bash
    0  1825  00000000 <fffb9eff <00000000  00004000 S    pts/0      0:00 /bin/su -
    0  1826  00000000  00010000 <00384004  4b813efb S    pts/0      0:00 -bash
    0  1854  00000000  00000000 <00000000  00000000 T    pts/0      0:00 stty erase ?

