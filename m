Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130848AbQKBIsR>; Thu, 2 Nov 2000 03:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131064AbQKBIsH>; Thu, 2 Nov 2000 03:48:07 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:56815 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130848AbQKBIr4>; Thu, 2 Nov 2000 03:47:56 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process, 2.4.0-test10
In-Reply-To: <Pine.LNX.4.21.0011011643050.6740-100000@duckman.distro.conectiva>
Organisation: SAP LinuxLab
Date: 02 Nov 2000 09:40:31 +0100
In-Reply-To: Rik van Riel's message of "Wed, 1 Nov 2000 16:48:04 -0200 (BRDT)"
Message-ID: <qwwpuke6a2o.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

I can probably give some more datapoints. Here is the console output
of my test machine (there is a 'vmstat 5' running in background):

[root@ls3016 /root]# killall shmtst
[root@ls3016 /root]#
 1 12  2      0 1607668  18932 2110496   0   0 67154 1115842 1050063 2029389   0   2  98
 0 10  2      0 1607564  18932 2110496   0   0     0   300  317   426   0   0 100
 0 10  2      0 1607408  18932 2110496   0   0     0   301  336   473   0   0 100
 0 10  2      0 1607560  18932 2110508   0   0     0   307  318   430   0   0 100
 0 10  2      0 1607556  18932 2110512   0   0     0   304  324   433   0   0 100
 0 10  2      0 1607528  18932 2110512   0   0     0   272  308   410   0   1  99
 0 10  2      0 1607440  18932 2110516   0   0     0   315  323   438   0   1  99
 0 10  2      0 1607528  18932 2110516   0   0     0   323  316   424   0   0 100
 0 10  2      0 1607556  18932 2110516   0   0     0   304  309   410   0   0 100
 0 10  2      0 1607600  18932 2110528   0   0     0   298  314   418   0   0 100
 0 10  2      0 1607384  18932 2110528   0   0     0   296  307   406   0   1  99
 0 10  2      0 1607284  18932 2110528   0   0     0   304  315   421   0   0 100
 0 10  2      0 1607668  18932 2110528   0   0     0   298  304   402   0   0 100
 0 10  2      0 1607576  18932 2110528   0   0     0   285  307   405   0   0 100
 0 10  2      0 1607656  18932 2110528   0   0     0   292  303   399   0   1  99
 0 10  2      0 1607928  18932 2110528   0   0     0   313  310   408   0   0 100
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 10  2      0 1608440  18932 2110528   0   0     0   340  313   417   0   1  99
 0 10  2      0 1608260  18932 2110528   0   0     0   298  318   426   0   0 100
 0 10  2      0 1608208  18932 2110528   0   0     0   314  334   448   0   1  99
 0 10  2      0 1608396  18932 2110528   0   0     0   323  316   421   0   1  99
 0 10  2      0 1608204  18932 2110548   0   0     0   334  333   458   0   0 100
 0 10  2      0 1607888  18932 2110580   0   0     0   336  329   448   0   1  99
 0 10  2      0 1608040  18932 2110584   0   0     0   317  321   435   0   0 100
 0 10  2      0 1608032  18932 2110588   0   0     0   241  318   425   0   0 100
 0 10  2      0 1608028  18932 2110592   0   0     0   257  325   443   0   1  99
 0 10  3      0 1608028  18932 2110592   0   0     0   258  323   435   0   0  99
 0 10  2      0 1608032  18932 2110592   0   0     0   241  316   425   0   0 100
 0 10  2      0 1608024  18932 2110592   0   0     0   261  337   460   0   0 100
 0 10  2      0 1608016  18932 2110592   0   0     0   253  328   444   0   0 100
 0 10  2      0 1608024  18932 2110592   0   0     0   252  320   435   0   0 100
 0 10  2      0 1608012  18932 2110592   0   0     0   255  326   446   0   0 100
 0 10  2      0 1608020  18932 2110592   0   0     0   255  326   444   0   1  99
 0 10  2      0 1608012  18932 2110600   0   0     0   261  341   469   0   0 100
 0 10  2      0 1607992  18932 2110608   0   0     0   261  344   479   0   0 100
 0 10  2      0 1607992  18932 2110612   0   0     0   264  342   471   0   0 100
 0 10  2      0 1607984  18932 2110612   0   0     0   266  334   462   0   0 100
 0 10  2      0 1607980  18932 2110620   0   0     0   273  340   468   0   0  99
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 10  2      0 1607972  18932 2110624   0   0     0   266  345   474   0   1  99
 0 10  2      0 1607940  18932 2110640   0   0     0   256  341   462   0   0 100
 0 10  2      0 1607936  18932 2110644   0   0     0   262  339   462   0   1  99
 0 10  2      0 1607940  18932 2110644   0   0     0   261  333   450   0   1  99
0 10  2      0 1607944  18932 2110644   0   0     0   253  335   454   0   0 100
0 10  2      0 1607944  18932 2110644   0   0     0   272  352   479   0   1  99

[root@ls3016 /root]# ps l
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
100     0   820     1   9   0  2200 1168 wait4  S    ttyS0      0:00 login -- ro
100     0   862   820  14   0  1756  976 wait4  S    ttyS0      0:00 -bash
000     0   878   862   9   0  1080  360 down   D    ttyS0     11:27 ./shmtst 10
000     0   879   862   9   0  1080  360 down   D    ttyS0     15:21 ./shmtst 15
040     0   880   878   9   0  1092  416 wait_o D    ttyS0      8:55 ./shmtst 10
040     0   881   878   9   0  1080  360 down   D    ttyS0     10:22 ./shmtst 10
444     0   882   878   9   0     0    0 do_exi Z    ttyS0     10:00 [shmtst <de
040     0   883   878   9   0  1092  416 wait_o D    ttyS0      9:30 ./shmtst 10
040     0   884   878   9   0  1092  416 down   D    ttyS0      8:44 ./shmtst 10
040     0   885   878   9   0  1092  416 down   D    ttyS0      9:01 ./shmtst 10
444     0   886   878   9   0     0    0 do_exi Z    ttyS0      7:59 [shmtst <de
444     0   887   879   9   0     0    0 do_exi Z    ttyS0     17:11 [shmtst <de
040     0   888   878   9   0  1080  360 down   D    ttyS0     10:21 ./shmtst 10
040     0   889   878   9   0  1092  416 down   D    ttyS0      9:06 ./shmtst 10
000     0   891   862   9   0  1136  488 nanosl S    ttyS0      0:23 vmstat 5
000     0  1226   862  19   0  2756 1084 -      R    ttyS0      0:00 ps l
[root@ls3016 /root]#  0 10  2      0 1607936  18932 2110652   0   0     0   275  368   488   0   0  99
 0 10  2      0 1607912  18932 2110660   0   0     0   266  334   457   0   0 100
 0 10  2      0 1607848  18932 2110672   0   0     0   302  354   498   0   0 100
 0 10  2      0 1607892  18932 2110688   0   0     0   287  352   496   0   0 100
 0 11  2      0 1607868  18932 2110704   0   0     1   282  338   472   0   1  99

So the processes don't finish exiting at least 47*5sec. They have
shared mmaped some 666000000 bytes long plain file on a 8GB machine.

The rest of the machine behaves nicely.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
