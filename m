Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTJ3LWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 06:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTJ3LWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 06:22:35 -0500
Received: from mailgate.zeus.co.uk ([62.254.209.70]:15368 "EHLO
	mailgate.zeus.co.uk") by vger.kernel.org with ESMTP id S262375AbTJ3LWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 06:22:22 -0500
Date: Thu, 30 Oct 2003 11:22:10 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll gives broken results when interrupted with a signal
In-Reply-To: <Pine.LNX.4.56.0310291121560.973@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0310301102470.1597@stones.cam.zeus.com>
References: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310291121560.973@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1AFAsU-0002cg-00*7m1B0pfQ14M* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Davide Libenzi wrote:

> Can you try the patch below and show me a dmesg when this happen?

Ok, patch applied. (I changed DEBUG_EPOLL to 10 however, otherwise
nothing would be printed). Now, epoll appears to behave perfectly and I
can't re-create the problem :(
Maybe it is a race of some kind and the printks change the behaviour?
The bug still occured the first time I tried the patch with DEBUG_EPOLL
1.

> Also, it shouldn't change a whit, but are you able to try on a x86 UP?

I could set one up if needed; we have a x86 build machine running
2.6.0-test3 here which I can upgrade (epoll seems fine on that btw)

Here's the dmesg output anyway:


[0000010009d462c0] eventpoll: sys_epoll_create(10)
[0000010009d462c0] eventpoll: ep_file_init() ep=000001000475e000
[0000010009d462c0] eventpoll: sys_epoll_create(10) = 4
[0000010009d462c0] eventpoll: close() ep=000001000475e000
[0000010009d462c0] eventpoll: sys_epoll_create(256)
[0000010009d462c0] eventpoll: ep_file_init() ep=000001000475e000
[0000010009d462c0] eventpoll: sys_epoll_create(256) = 4
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 1, 5, 0000007fbffff070)
[0000010009d462c0] eventpoll: ep_find(00000100059c9580) -> 0000000000000000
[0000010009d462c0] eventpoll: ep_insert(000001000475e000, 00000100059c9580, 5)
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 1, 5, 0000007fbffff070) = 0
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 1, 6, 0000007fbffff290)
[0000010009d462c0] eventpoll: ep_find(000001000cc3a980) -> 0000000000000000
[0000010009d462c0] eventpoll: ep_insert(000001000475e000, 000001000cc3a980, 6)
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 1, 6, 0000007fbffff290) = 0
[0000010009d46b50] eventpoll: sys_epoll_create(1024)
[0000010009d46b50] eventpoll: ep_file_init() ep=000001000ccf2000
[0000010009d46b50] eventpoll: sys_epoll_create(1024) = 3
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 1, 7, 0000007fbffff1c0)
[0000010009d46b50] eventpoll: ep_find(0000010005e2c180) -> 0000000000000000
[0000010009d46b50] eventpoll: ep_insert(000001000ccf2000, 0000010005e2c180, 7)
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 1, 7, 0000007fbffff1c0) = 0
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 3, 7, 000000000070fcc0)
[0000010009d46b50] eventpoll: ep_find(0000010005e2c180) -> 00000100091cde00
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 3, 7, 000000000070fcc0) = 0
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000)
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d46b50] eventpoll: pollres file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00 events=1
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000) = 1
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000)
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 3, 6, 000000000070fcc0)
[0000010009d462c0] eventpoll: ep_find(000001000cc3a980) -> 00000100091cdec0
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 3, 6, 000000000070fcc0) = 0
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 3, 5, 000000000070fcc0)
[0000010009d462c0] eventpoll: ep_find(00000100059c9580) -> 00000100091cd980
[0000010009d462c0] eventpoll: sys_epoll_ctl(4, 3, 5, 000000000070fcc0) = 0
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 0)
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 0) = 0
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d46b50] eventpoll: pollres file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00 events=1
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000) = 1
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000)
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d46b50] eventpoll: pollres file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00 events=1
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000) = 1
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000)
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d46b50] eventpoll: pollres file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00 events=1
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000) = 1
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 1, 4, 0000007fbfffe9a0)
[0000010009d46b50] eventpoll: ep_find(000001000eb6a080) -> 0000000000000000
[0000010009d46b50] eventpoll: ep_insert(000001000ccf2000, 000001000eb6a080, 4)
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 1, 4, 0000007fbfffe9a0) = 0
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 3, 4, 000000000070fcc0)
[0000010009d46b50] eventpoll: ep_find(000001000eb6a080) -> 00000100091cdd40
[0000010009d46b50] eventpoll: sys_epoll_ctl(3, 3, 4, 000000000070fcc0) = 0
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000)
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 3000)
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 3000) = -4
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 2000)
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000) = 0
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000)
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 2000) = -4
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 1000)
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000) = 0
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000)
[0000010009d462c0] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 1000) = -4
[0000010009d462c0] eventpoll: poll_callback(000001000eb6a080) epi=00000100091cdd40 ep=000001000ccf2000
[0000010009d462c0] eventpoll: poll_callback(000001000eb6a080) epi=00000100091cdd40 ep=000001000ccf2000
[0000010009d462c0] eventpoll: poll_callback(00000100059c9580) epi=00000100091cd980 ep=000001000475e000
[0000010009d462c0] eventpoll: poll_callback(00000100059c9580) epi=00000100091cd980 ep=000001000475e000
[0000010009d462c0] eventpoll: eventpoll_release_file(00000100059c9580)
[0000010009d462c0] eventpoll: remove ep=000001000475e000 epi=00000100091cd980
[0000010009d462c0] eventpoll: ep_unlink(000001000475e000, 00000100059c9580) = 0
[0000010009d462c0] eventpoll: ep_remove(000001000475e000, 00000100059c9580) = 0
[0000010009d462c0] eventpoll: eventpoll_release_file(000001000cc3a980)
[0000010009d462c0] eventpoll: remove ep=000001000475e000 epi=00000100091cdec0
[0000010009d462c0] eventpoll: ep_unlink(000001000475e000, 000001000cc3a980) = 0
[0000010009d462c0] eventpoll: ep_remove(000001000475e000, 000001000cc3a980) = 0
[0000010009d462c0] eventpoll: close() ep=000001000475e000
[0000010009d462c0] eventpoll: poll_callback(0000010005e2c180) epi=00000100091cde00 ep=000001000ccf2000
[0000010009d46b50] eventpoll: polling file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00
[0000010009d46b50] eventpoll: pollres file=0000010005e2c180 ep=000001000ccf2000 epi=00000100091cde00 events=17
[0000010009d46b50] eventpoll: polling file=000001000eb6a080 ep=000001000ccf2000 epi=00000100091cdd40
[0000010009d46b50] eventpoll: pollres file=000001000eb6a080 ep=000001000ccf2000 epi=00000100091cdd40 events=16
[0000010009d46b50] eventpoll: sys_epoll_wait(3, 000000000073e3b0, 32, 1000) = 2
[0000010009d46b50] eventpoll: eventpoll_release_file(0000010005e2c180)
[0000010009d46b50] eventpoll: remove ep=000001000ccf2000 epi=00000100091cde00
[0000010009d46b50] eventpoll: ep_unlink(000001000ccf2000, 0000010005e2c180) = 0
[0000010009d46b50] eventpoll: ep_remove(000001000ccf2000, 0000010005e2c180) = 0
[0000010009d46b50] eventpoll: eventpoll_release_file(000001000eb6a080)
[0000010009d46b50] eventpoll: remove ep=000001000ccf2000 epi=00000100091cdd40
[0000010009d46b50] eventpoll: ep_unlink(000001000ccf2000, 000001000eb6a080) = 0
[0000010009d46b50] eventpoll: ep_remove(000001000ccf2000, 000001000eb6a080) = 0
[0000010009d46b50] eventpoll: close() ep=000001000ccf2000



-- 
Ben Mansell, <ben@zeus.com>                       Zeus Technology Ltd
Download the world's fastest webserver!   Universally Serving the Net
T:+44(0)1223 525000 F:+44(0)1223 525100           http://www.zeus.com
Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND
