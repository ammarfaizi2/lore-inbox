Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130180AbQK1Kfr>; Tue, 28 Nov 2000 05:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130234AbQK1Kfh>; Tue, 28 Nov 2000 05:35:37 -0500
Received: from cips.inwind.it ([212.141.53.74]:63952 "EHLO relay3.inwind.it")
        by vger.kernel.org with ESMTP id <S130180AbQK1KfR>;
        Tue, 28 Nov 2000 05:35:17 -0500
Message-Id: <3.0.6.32.20001128110817.00acae30@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 28 Nov 2000 11:08:17 +0100
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: lmbench on linux-2.4.0-test[4-11]
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


About 2 times on 3 lmbench-2alpha12 stops at "Local networking".
Below is a 'ps l':

  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
100     0   207     1   9   0  1980 1204 wait4  S    tty1       0:00 -bash
100     0   208     1  14   0  1968 1188 wait4  S    tty2       0:00 -bash
000     0   209     1   9   0  1004  456 read_c S    tty3       0:00
/sbin/getty 38400 tty3
000     0   210     1   9   0  1004  456 read_c S    tty4       0:00
/sbin/getty 38400 tty4
000     0   211     1   9   0  1004  456 read_c S    tty5       0:00
/sbin/getty 38400 tty5
000     0   212     1   9   0  1004  456 read_c S    tty6       0:00
/sbin/getty 38400 tty6
000     0  4096   207   9   0  1168  588 wait4  S    tty1       0:00 make
results
000     0  4255  4096   9   0  1748  852 wait4  S    tty1       0:00
/bin/sh ../scripts/results
000     0  4289  4255   9   0  1768  872 wait4  S    tty1       0:00
/bin/sh ../../scripts/lmbench CONFIG.lenstra
040     0  4740     1  10   0  1000  292 tcp_da S    tty1       0:00
lat_connect -s
040     0  4742     1   9   0  1068  380 wait_f S    tty1       0:00 bw_tcp -s
000     0  4753  4289  10   0  1036  480 inet_w S    tty1       0:00
lat_connect localhost
100     0  4761   208  17   0  2872 1256 -      R    tty2       0:00 ps l

lat_connect and bw_tcp are not running.
It looks like a deadlock between connect() and accept().

2.4.0-test[1-2] are not affected, don't know test3.
Athlon UP machine. All kernels compiled with the same
configuration and compiler, gcc 2.95.2

Does anyone confirm this problem?

--
Lorenzo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
