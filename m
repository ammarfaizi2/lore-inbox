Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTDXTN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTDXTN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:13:59 -0400
Received: from sol.cobite.com ([208.222.80.183]:16620 "EHLO sol.cobite.com")
	by vger.kernel.org with ESMTP id S263791AbTDXTN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:13:56 -0400
Date: Thu, 24 Apr 2003 15:26:00 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@sol.cobite.com
To: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: odd gnome-terminal behavior in 2.5.67-mm3
Message-ID: <Pine.LNX.4.44.0304241518550.31091-100000@sol.cobite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, list

I've been experiencing some odd behavior running 2.5.67-mm3 on my RH9 
based desktop.

It's probably an application bug, but something strange is happening 
anyway that doesn't happen in 'stable' kernels.

What happens is that gnome-terminal gets stuck in some sort of 'infinite 
loop' when a lot of output is going to the screen and also keypresses are 
going in (like paging through a large file - holding down pgup/pgdown).

Xterm doesn't seem to be affected.

If I kill off the shell running inside the terminal, it recovers (that is, 
when gnome-terminal is running as a 'factory' the window that is hung 
disappears but the process and all of the other windows are fine).

I captured some 'strace' of this while it was happening (sorry about the 
wrapping, the lines are quite long):

ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=17, events=POLLIN}, {fd=3, events=POLLIN}, {fd=4, 
events=POLLIN}, {fd=8, events=POLLIN}, {fd=10, events=POLLIN|POLLPRI}, 
{fd=11, events=POLLIN|POLLPRI}, {fd=12, ev
ents=POLLIN|POLLPRI}, {fd=13, events=POLLIN|POLLPRI}, {fd=15, 
events=POLLIN|POLLPRI}, {fd=14, events=POLLIN|POLLPRI}], 10, 0) = 0
write(3, "+\20\1\0", 4)                 = 4
read(3, "\1\1-\205\0\0\0\0&\0\300\3\0\0\0\0\1\0\0\0\0\0\0\0\370"..., 32) = 
32
ioctl(3, FIONREAD, [0])                 = 0
write(3, "5\20\4\0.\356)\2q\266#\2\24\0\25\0007\0\5\0/\356)\2.\356"..., 
328) = 328
read(3, "\1\1A\205\0\0\0\0&\0\300\3\0\0\0\0\0\0\0\0\0\0\0\0\370"..., 32) = 
32
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=17, events=POLLIN}, {fd=3, events=POLLIN}, {fd=4, 
events=POLLIN}, {fd=8, events=POLLIN}, {fd=10, events=POLLIN|POLLPRI}, 
{fd=11, events=POLLIN|POLLPRI}, {fd=12, ev
ents=POLLIN|POLLPRI}, {fd=13, events=POLLIN|POLLPRI}, {fd=15, 
events=POLLIN|POLLPRI}, {fd=14, events=POLLIN|POLLPRI}, {fd=22, 
events=POLLIN}, {fd=23, events=POLLIN}, {fd=21,
 events=POLLIN, revents=POLLIN}, {fd=24, events=POLLIN}, {fd=16, 
events=POLLIN}, {fd=25, events=POLLIN}], 16, 0) = 1
read(21, 0xbfffe8f0, 4294965249)        = -1 EFAULT (Bad address)
getpid()                                = 31085
write(2, "\n** (gnome-terminal:31085): WARN"..., 79) = 79

This exact sequence repeats ad infinitum. 

The gnome-terminal is apparently doing an invalid read of -1 bytes after 
poll is saying there is data available.

I don't know what this could mean.

David


-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


