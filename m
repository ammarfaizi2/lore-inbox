Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbRCMBlR>; Mon, 12 Mar 2001 20:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130723AbRCMBlH>; Mon, 12 Mar 2001 20:41:07 -0500
Received: from [203.25.66.2] ([203.25.66.2]:42348 "EHLO mail.zylotech.com.au")
	by vger.kernel.org with ESMTP id <S130721AbRCMBk7>;
	Mon, 12 Mar 2001 20:40:59 -0500
Message-ID: <3AAD7A73.C81750FD@zylotech.com.au>
Date: Tue, 13 Mar 2001 12:40:03 +1100
From: David Shoon <dave@zylotech.com.au>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
CC: dave@zylotech.com.au
Subject: system hang with "__alloc_page: 1-order allocation failed"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After some testing, 2.4.2, 2.4.2-pre3, and 2.4.3-ac18 and ac19 both
crash/hang when a fork loop (bomb) is executed (under a normal user) and
killed (by a superuser). This isn't what you'd expect in previous
kernels (2.2.x, and 2.0.x), as they both return to normal after killing
the process.

(This might be related to an earlier post about memory allocation?)

Anyway, a 'forkbomb' just looks like this (sorry, just clarifying the
obvious):

int main() {
    while (1)
        fork();
}

With 2.4.2, 2.4.2-pre3 after killing the process (ctrl-c or killall -9
prog) the kernel dumps error messages of: "__alloc_page: 1-order
allocation failed" continuously for a few minutes and then starts to
(randomly?) kill other processes which are active (such as xfs, bash)
with "Out of Memory: Killed process ### (etc.)". Keyboard input doesn't
work, but you can still switch vconsoles.

Under 2.4.2-ac18/19, the system doesn't show the error messages, but it
still hangs after you kill the process. All keyboard input freezes
eventually (can't switch vconsoles).

I'm not sure if it helps, but the system I'm testing this on is a PIII
500mhz, with 196megs of ram, with swap disabled just so I know it's not
device read/writes.

If anyone needs more info, give me a holler..

[ please cc: replies back to me since i'm not on the linux kernel list ]

p.s. apologies if this is already known or fixed
--
David Shoon
dave@zylotech.com.au


