Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131234AbRBUAoo>; Tue, 20 Feb 2001 19:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131243AbRBUAo0>; Tue, 20 Feb 2001 19:44:26 -0500
Received: from mail.linux.student.kuleuven.ac.be ([193.190.253.82]:9990 "EHLO
	mail.linux.student.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S131234AbRBUAoN>; Tue, 20 Feb 2001 19:44:13 -0500
Date: Wed, 21 Feb 2001 01:44:10 +0100
From: Arnaud Installe <arnaud@bach.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: reiserfs probs on 2.2.17
Message-ID: <20010221014410.A2559@bach.iverlek.kotnet.org>
Reply-To: Arnaud Installe <a.installe@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending it, as it doesn't seem it got through the previous times.

----- Forwarded message from Arnaud Installe <arnaud@bach.kotnet.org> -----

To: linux-kernel@vger.kernel.org
Subject: reiserfs probs on 2.2.17
Date: Tue, 20 Feb 2001 00:42:29 +0100

Hello,

I've had a problem with a reiserfs partition on a 2.2.17 kernel the other
day.  Everything I did on it just waited forever.  (Since shutdown tries
to umount all partitions the only way to reboot the machine was to kill
the watchdog process.)

The problem persisted after the reboot, so the partition must've contained
errors.  Running `reiserfsck --replay-by-journal' fixed the problem.  (I
think: before that I also ran `reiserfsck --check 'on it.)

This is the output I got from `ps':

     EIP COMMAND                   PENDING  WCHAN WCHAN
400c415e init [4]         0000000000000000 1324d9 do_select
00000000 [kflushd]        0000000000000000 12b493 bdflush
00000000 [kupdate]        0000000000000000 12b508 kupdate
00000000 [kpiod]          0000000000000000 121382 kpiod
00000000 [kswapd]         0000000000000000 12496a kswapd
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
00000000 [kreiserfsd]     0000000000000000 16107c reiserfs_journal_commit_thread
400da15e portmap          0000000000000000 1324d9 do_select
400a8c41 /usr/sbin/atd    0000000000000000 1146d3 nanosleep
400a8c41 crond            0000000000000000 1146d3 nanosleep
401b615e /usr/sbin/sshd   0000000000000000 1324d9 do_select
400c415e xntpd -A         0000000000000000 1324d9 do_select
400c615e rpc.rstatd       0000000000000000 1324d9 do_select
400bdab4 /sbin/mingetty t 0000000000000000 19e3c3 read_chan
400c415e /sbin/syslogd -n 0000000000000000 1324d9 do_select
400e715e Xvnc :0 -desktop 0000000000000000 1324d9 do_select
401f315e twm              0000000000000000 1324d9 do_select
400eda04 /usr/jdk118/bin/ 0000000000000300 161e04 check_journal_end
40d7a310 /usr/sbin/snmpd  0000000000000000 1324d9 do_select
400c42f7 shutdown -r 0 w  0000000000010002 161e04 check_journal_end
00000000 [shutdown <defun 0000000000000000 119e8d do_exit
401b615e /usr/sbin/sshd   0000000000000000 1324d9 do_select
400c1ab4 -bash            0000000000000000 19e3c3 read_chan
400e68c9 su -l filepool / 0000000000000000 11a1e3 wait4
400ac8c9 -bash /usr/local 0000000000000000 11a1e3 wait4
401b615e /usr/sbin/sshd   0000000000000000 1324d9 do_select
400ac8c9 -bash            0000000000000000 11a1e3 wait4
400c42f7 sync             0000000000000002 161e04 check_journal_end
401b615e /usr/sbin/sshd   0000000000000000 1324d9 do_select
400ac8c9 -bash            0000000000000000 11a1e3 wait4
400bda04 cp /usr/local/bi 0000000000000002 1614b1 do_journal_begin_r
401b615e /usr/sbin/sshd   0000000000000000 1324d9 do_select
400ac8c9 -bash            0000000000000000 11a1e3 wait4
400bda04 cp /usr/local/bi 0000000000000002 1aba58 down_failed
401b615e /usr/sbin/sshd   0000000000000000      - -
400ac8c9 -bash            0000000000000000 11a1e3 wait4
00000000 [login]          0000000000000000 19eb6f tty_wait_until_sent
400a8c41 sleep 10         0000000000000000 1146d3 nanosleep
400c9ab4 ps -w -eo pid,us 0000000000000000      - -
400acc77 -bash            0000000000000000      - -

-- 
Arnaud Installe                                             a.installe@ieee.org

	"Cheshire-Puss," she began, "would you tell me, please, which way I
ought to go from here?"
	"That depends a good deal on where you want to get to," said the Cat.
	"I don't care much where--" said Alice.
	"Then it doesn't matter which way you go," said the Cat.



----- End forwarded message -----

-- 
Arnaud Installe                                             a.installe@ieee.org

Snoopy: No problem is so big that it can't be run away from.
