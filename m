Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279711AbRJ3BHs>; Mon, 29 Oct 2001 20:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279712AbRJ3BHj>; Mon, 29 Oct 2001 20:07:39 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:2508 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S279711AbRJ3BHZ>; Mon, 29 Oct 2001 20:07:25 -0500
Date: Mon, 29 Oct 2001 20:05:51 -0500
From: Les Schaffer <schaffer@optonline.net>
X-Face: [V?bWTh\+_V")"gXxY9KGQozO(|>ggwp;\Ds6@YGoS$wreQaSLmhWUp%V;okpj4C^i$FQWK
 Q:/luO.Zh=VP"U5M.%m1cK:v9DgiQp^JK47nxE^=e3~HPoLmY,igNBZo)LUT3a2CFm*chsyaq7~=dU
 _IX>v[h$BZsa*yn5;?{|3Z@ZI@FL(e`-@wq`f?~{1){A%o:/t"39M@}ER]6.62NbfxrD%!{9!So^\9
 c
Subject: 2.4.13 (SMP): kswapd working furiously, to no effect
To: linux-kernel@vger.kernel.org
Reply-to: Les Schaffer <schaffer@optonline.net>
Message-id: <15325.64751.75250.887741@gargle.gargle.HOWL>
MIME-version: 1.0
X-Mailer: VM 6.96 under 21.5  (beta2) "artichoke" XEmacs Lucid
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a problem for the last several days (2.4.13 Tyan PIII Dual)
but couldnt put my finger on it till i started paying attention:
kswapd is working furiously, but accomplishing nothing.

that is, kswapd is logging lots of CPU time, but no swap space is
being used. (see below).

i dont recall having problems until towards the end of the day (i
shutdown at nite). when i open or close a netscape session for
example, or do a dpkg blah-blah, the process hangs for a long time
before getting going.  at one point prior to the 'top' below, i had
something like 500XXXK used, and still not a drop, err byte, of swap
used.

this behavior was not occuring with 2.4.12 (will check tmw) and
earlier versions.

les schaffer

================= INFO =================
speggy)~/: dmesg | grep swap
Starting kswapd
Adding Swap: 506036k swap-space (priority -1)

--------------

(speggy)~/: top

19:07:09 up 13:12,  3 users,  load average: 1.68, 1.45, 1.24
69 processes: 66 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  14.4% user,  85.5% system,   0.0% nice,   0.1% idle
Mem:    513916K total,   443932K used,    69984K free,     7808K buffers
Swap:   506036K total,        0K used,   506036K free,   166992K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 2873 godzilla   9   0 31984  30M 12272 S     0.0  6.0   0:00 mozilla-bin
             [ mozilla-bin repeated ad infinitum)
  356 godzilla   9   0 27528  26M  3688 S     0.0  5.3   4:16 xemacs
  298 root       6 -10  202M  26M  4120 S <   0.9  5.1   9:04 XFree86
  335 godzilla   9   0  7672 7668  6100 S     0.0  1.4   0:17 gabber
  326 godzilla   9   0  4908 4908  3812 S     0.0  0.9   0:06 panel
             [ etc ... ]
    3 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU1
    5 root      19   0     0    0     0 RW   95.9  0.0 282:40 kswapd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush

--------------

(speggy)~/: ps uxwa     // about 50 minutes after 'top' above 

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         5 37.9  0.0     0    0 ?        SW   05:54 315:56 [kswapd]

--------------

(speggy)/proc/: cat swaps 
Filename			Type		Size	Used	Priority
/dev/hda4                       partition	506036	0	-1


