Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTFFA5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 20:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbTFFA5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 20:57:37 -0400
Received: from first.knowledge.no ([193.212.174.4]:7645 "EHLO knowledge.no")
	by vger.kernel.org with ESMTP id S265279AbTFFA5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 20:57:35 -0400
Date: Fri, 6 Jun 2003 03:11:04 +0200
From: Magnus Solvang <magnus@solvang.net>
To: linux-kernel@vger.kernel.org
Subject: gnome-terminal hangs while running mutt (kernel 2.5.70)
Message-ID: <20030606011104.GA4700@first.knowledge.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what causes this problem, but I thought I
should mention it, since it only happens with my 2.5.70-
kernel, and not with 2.4.20.

Using gnome-terminal with an updated Red Hat Linux 9, and
ssh'ing to my mailserver, my gnome-terminal hangs while
mutt is sorting my mailbox. It always hangs on the same
sort-count, displaying:

  Reading /var/spool/mail/magnus... 194 (38%)

on the bottom of the screen. This is not a problem with
other kernels, or using xterm in 2.5.70, so I guess it's
not a mutt-problem.

Starting a gnome-terminal from xterm, logging into my
mailserver with ssh, and starting mutt, the following
error message loops infinitly in xterm while gnome-terminal
hangs:

** (gnome-terminal:5486): WARNING **: Error reading from
 child: Bad address.

Not a lot to find on Google about that one...

(client)
Gnome gnome-terminal 2.2.1
OpenSSH_3.5p1, SSH protocols 1.5/2.0, OpenSSL 0x0090701f

(mailserver)
Mutt 1.4.1i (2003-03-19)
sshd version OpenSSH_3.4p1


strace-output, done from the xterm that starts gnome-terminal:

[...]
getpid()                                = 6917
write(2, "\n** (gnome-terminal:6917): WARNI"..., 78
** (gnome-terminal:6917): WARNING **: Error reading from child: Bad address.
) = 78
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=17, events=POLLIN}, {fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=
8, events=POLLIN}, {fd=10, events=POLLIN|POLLPRI}, {fd=11, events=POLLIN|POLLPRI
}, {fd=12, events=POLLIN|POLLPRI}, {fd=13, events=POLLIN|POLLPRI}, {fd=15, event
s=POLLIN|POLLPRI}, {fd=14, events=POLLIN|POLLPRI}], 10, 0) = 0
write(3, "5\20\4\0\2\10\200\2\3\1\200\2\20\0\23\0007\0\5\0\3\10\200"..., 356) = 
356
read(3, 0xbffff6e0, 32)                 = -1 EAGAIN (Resource temporarily unavai
lable)
select(4, [3], NULL, NULL, NULL)        = 1 (in [3])
read(3, "\1\1^\36\0\0\0\0&\0 \2\0\0\0\0\0\0\0\0\0\0\0\0P\333i\10"..., 32) = 32
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=17, events=POLLIN}, {fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=
8, events=POLLIN}, {fd=10, events=POLLIN|POLLPRI}, {fd=11, events=POLLIN|POLLPRI
}, {fd=12, events=POLLIN|POLLPRI}, {fd=13, events=POLLIN|POLLPRI}, {fd=15, event
s=POLLIN|POLLPRI}, {fd=14, events=POLLIN|POLLPRI}, {fd=16, events=POLLIN, revent
s=POLLIN}], 11, 0) = 1
read(16, 0xbfffe740, 4294965250)        = -1 EFAULT (Bad address)
getpid()                                = 6917
write(2, "\n** (gnome-terminal:6917): WARNI"..., 78
** (gnome-terminal:6917): WARNING **: Error reading from child: Bad address.
) = 78
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=17, events=POLLIN}, {fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=
8, events=POLLIN}, {fd=10, events=POLLIN|POLLPRI}, {fd=11, events=POLLIN|POLLPRI
}, {fd=12, events=POLLIN|POLLPRI}, {fd=13, events=POLLIN|POLLPRI}, {fd=15, event
s=POLLIN|POLLPRI}, {fd=14, events=POLLIN|POLLPRI}], 10, 0) = 0
write(3, "5\20\4\0\10\10\200\2\3\1\200\2\20\0\23\0007\0\5\0\t\10"..., 356) = 356
read(3, 0xbffff6e0, 32)                 = -1 EAGAIN (Resource temporarily unavai
lable)
select(4, [3], NULL, NULL, NULL)        = 1 (in [3])
read(3, "\1\1s\36\0\0\0\0&\0 \2\0\0\0\0\0\0\0\0\0\0\0\0P\333i\10"..., 32) = 32
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=17, events=POLLIN}, {fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=
8, events=POLLIN}, {fd=10, events=POLLIN|POLLPRI}, {fd=11, events=POLLIN|POLLPRI
}, {fd=12, events=POLLIN|POLLPRI}, {fd=13, events=POLLIN|POLLPRI}, {fd=15, event
s=POLLIN|POLLPRI}, {fd=14, events=POLLIN|POLLPRI}, {fd=16, events=POLLIN, revent
s=POLLIN}], 11, 0) = 1
read(16, 0xbfffe740, 4294965250)        = -1 EFAUctl(3, FIONREAD <unfinished ...
>

Let me know, and I'll give you more info.

- M
