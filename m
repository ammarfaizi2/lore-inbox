Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTBKWdk>; Tue, 11 Feb 2003 17:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbTBKWdk>; Tue, 11 Feb 2003 17:33:40 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:58511 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S266527AbTBKWdj>; Tue, 11 Feb 2003 17:33:39 -0500
Subject: 2.5.60 problems with dbench and unkillable processes.
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 11 Feb 2003 15:40:22 -0700
Message-Id: <1045003222.2570.497.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.60, dbench starts, prints "1 clients started", but never prints
any "..." and doesn't finish.  

With 2.5.59-mm10, dbench runs normally.

I ran this:
ps -ewo user,pid,priority,%cpu,stat,command,wchan
with the 2.5.60 System.map copied to /boot, and got this:

root      1103  15  0.1 S    /usr/sbin/sshd   schedule_timeout
steven    1104  15  0.0 S    -bash            wait4
steven    1142  15  0.0 S    ./dbench 1       wait4
steven    1143  16  0.0 S    ./dbench 1       pause
steven    1153  16  0.0 S    /bin/sh /home/st wait4
steven    1154  16  0.0 R    ps -ewo user,pid -


I control-c'ed the dbench 1, and started ./dbench 4, and got this:

root      1103  15  0.0 S    /usr/sbin/sshd   schedule_timeout
steven    1104  15  0.0 S    -bash            wait4
steven    1143  16  0.0 S    ./dbench 1       pause
steven    1160  15  0.0 S    ./dbench 4       wait4
steven    1161  16  0.0 S    ./dbench 4       pause
steven    1162  16  0.0 S    ./dbench 4       pause
steven    1163  16  0.0 S    ./dbench 4       pause
steven    1164  16  0.0 S    ./dbench 4       pause
steven    1166  16  0.0 S    /bin/sh /home/st wait4
steven    1167  17  0.0 R    ps -ewo user,pid -

That process 1143 is now unkillable with kill -9.

After control-c-ing the ./dbench 4, I now have 4
dbench 4 processes which are unkillable with kill -9.

The system is 2-way PIII, kernel is SMP, PREEMPT.

Steven


