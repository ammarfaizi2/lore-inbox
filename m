Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbTBWUxI>; Sun, 23 Feb 2003 15:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268549AbTBWUxI>; Sun, 23 Feb 2003 15:53:08 -0500
Received: from wall.ttu.ee ([193.40.254.238]:10768 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id <S267992AbTBWUxF>;
	Sun, 23 Feb 2003 15:53:05 -0500
Date: Sun, 23 Feb 2003 23:03:15 +0200 (EET)
From: Siim Vahtre <siim@pld.ttu.ee>
To: <alsa-devel@alsa-project.org>
cc: <linux-kernel@vger.kernel.org>
Subject: bug with alsa
Message-ID: <Pine.SOL.4.31.0302232248360.28624-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.5.62 kernel, w/o module support.

ALSA device list:
 #0: Intel 82801BA-ICH2 at 0xe800, irq 10

Firstly, I noticed that the soundsystem freezes in time-to-time for about
half second or so. And it is terribly annoying when playing mp3 or video.

But even worse, sometimes the program that uses audio suddenly freezes
with a kernel bug (given below) and after that, everything that wants to
use audio will hang completely aswell. For example, using 'strace' on
alsamixer now gives:

open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3

...and of course it hangs completely there.

After that, killing the process does not help either.
Rebooting the machine helps... for about few hours after the bug
appears again. Here is the bug that will come time-to-time when
using audio in the first place:

Unable to handle kernel NULL pointer dereference at virtual address
0000005f
 printing eip:
c02a1ed7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c02a1ed7>]    Not tainted
EFLAGS: 00210203
EIP is at snd_ctl_release+0x97/0xf0
eax: 0000005f   ebx: c7dfd94c   ecx: c7dfd95c   edx: 0000005f
esi: c60599e0   edi: c7dfd800   ebp: c4d06260   esp: c51b3f58
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 3452, threadinfo=c51b2000 task=c53b3260)
Stack: ffffffff c4d06260 00000000 c6059a00 c4d06260 c7fba520 c139ebd0
c3270580
       c014d89b c139ebd0 c4d06260 c4d06260 00000000 c38442a0 c51b2000
c014bb64
       c4d06260 c38442a0 c38442a0 c4d06260 00000000 c014bbf2 c4d06260
c38442a0
Call Trace:
 [<c014d89b>] __fput+0xdb/0xe0
 [<c014bb64>] filp_close+0x74/0xa0
 [<c014bbf2>] sys_close+0x62/0xa0
 [<c01095df>] syscall_call+0x7/0xb

Code: 8b 00 0f 18 00 39 ca 75 f0 89 d8 ba ff ff 00 00 0f c1 10 0f


