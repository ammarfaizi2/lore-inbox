Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVDAXfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVDAXfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVDAXfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:35:00 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:36557 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S262799AbVDAXea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:34:30 -0500
Date: Fri, 01 Apr 2005 18:34:22 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-reply-to: <424D9F6A.8080407@cybsft.com>
To: linux-kernel@vger.kernel.org
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Message-id: <200504011834.22600.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050325145908.GA7146@elte.hu>
 <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 April 2005 14:22, K.R. Foley wrote:
>Gene Heskett wrote:
>> On Friday 01 April 2005 13:27, K.R. Foley wrote:
>>>Gene Heskett wrote:
>>><snip>
>>>
>>>>It was up to 43-04 by the time I got there.
>>>>
>>>>This one didn't go in cleanly Ingo.  From my build-src scripts
>>>>output: -------------------
>>>>Applying patch realtime-preempt-2.6.12-rc1-V0.7.43-04
>>>>[...]
>>>>patching file lib/rwsem-spinlock.c
>>>>Hunk #5 FAILED at 133.
>>>>Hunk #6 FAILED at 160.
>>>>Hunk #7 FAILED at 179.
>>>>Hunk #8 FAILED at 194.
>>>>Hunk #9 FAILED at 204.
>>>>Hunk #10 FAILED at 231.
>>>>Hunk #11 FAILED at 250.
>>>>Hunk #12 FAILED at 265.
>>>>Hunk #13 FAILED at 274.
>>>>Hunk #14 FAILED at 293.
>>>>Hunk #15 FAILED at 314.
>>>>11 out of 15 hunks FAILED -- saving rejects to file
>>>>lib/rwsem-spinlock.c.rej
>>>>-----------
>>>>I doubt it would run, so I haven't built it.  Should I?
>>>
>>>Adding the attached patch on top of the above should resolve the
>>>failures, at least in the patching. Still working on building it.
>>
>> I assume you mean apply before the 43-04 patch?
>
>No actually I meant to apply it after the 43-04 patch. However, Ingo
> has a new patch that should cover this also.
>
>> I'll give it a go later today, right now I've got dirt to move in
>> the yard.

3 hrs later, rained out, or in as the case may be.  43-05 is building 
now, with lots of traceing turned on to see what sorts of grins I 
might get out of it.

No one has commented about the loss of video in the tvtime/pcHDTV-3000 
card situation, am I on my own, basicly reverting to the 
pcHDTV-2.0.tar.gz stuff to overwrite the kernel stuff?

------

2 friggin hours later, I'm finally rebooted.  I start heyu in my
rc.local file by launching a series of scripts to set that all up,
and my cm-11a interface decided, for the first time in a couple
of years, to not talk to the 'heyu setclock' command.  Boot hung,
but not of course until I'd used up half the boots per fsck on
100GB of disks.  Grrrrroooowwff.

Anyway, now lets see what works.
tvtime doesn't, even if I re-install the drivers from the pcHDTV-2.0
archive.  No video, just a blue screen, sound so-so.
kino works
xsane works
spcagui works

But, I did get some odd stuff in the logs while doing this as I had
a lot of traceing stuff turned on over and above the defaults:

Warning, this IS lengthy
---------------------------
Apr  1 18:05:13 coyote gconfd (root-5947): starting (version 2.6.0), pid 5947 user 'root'
Apr  1 18:05:13 coyote gconfd (root-5947): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at position 0
Apr  1 18:05:13 coyote gconfd (root-5947): Resolved address "xml:readwrite:/root/.gconf" to a writable config source at position 1
Apr  1 18:05:13 coyote gconfd (root-5947): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at position 2
Apr  1 18:05:19 coyote ieee1394.agent[6002]: ... no drivers for IEEE1394 product 0x/0x/0x
Apr  1 18:05:20 coyote kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Apr  1 18:05:20 coyote ieee1394.agent[6016]: ... no drivers for IEEE1394 product 0x/0x/0x
Apr  1 18:05:24 coyote kernel:
Apr  1 18:05:24 coyote kernel: ==========================================
Apr  1 18:05:24 coyote kernel: [ BUG: lock recursion deadlock detected! |
Apr  1 18:05:24 coyote kernel: ------------------------------------------
Apr  1 18:05:24 coyote kernel: already locked:  [e4d17228] {(struct semaphore *)(&fi->complete_sem)}
Apr  1 18:05:24 coyote kernel: .. held by:              kino: 6082 [e13ecbb0, 118]
Apr  1 18:05:24 coyote kernel: ... acquired at:  raw1394_read+0x104/0x110 [raw1394]
Apr  1 18:05:24 coyote kernel:
Apr  1 18:05:24 coyote kernel: ------------------------------
Apr  1 18:05:24 coyote kernel: | showing all locks held by: |  (kino/6082 [e13ecbb0, 118]):
Apr  1 18:05:24 coyote kernel: ------------------------------
Apr  1 18:05:24 coyote kernel:
Apr  1 18:05:24 coyote kernel: #001:             [e4d17228] {(struct semaphore *)(&fi->complete_sem)}
Apr  1 18:05:24 coyote kernel: ... acquired at:  raw1394_read+0x104/0x110 [raw1394]
Apr  1 18:05:24 coyote kernel:
Apr  1 18:05:24 coyote kernel: -{current task's backtrace}----------------->
Apr  1 18:05:24 coyote kernel:  [<c0103353>] dump_stack+0x23/0x30 (20)
Apr  1 18:05:24 coyote kernel:  [<c013093e>] check_deadlock+0x2fe/0x320 (44)
Apr  1 18:05:24 coyote kernel:  [<c01313b7>] task_blocks_on_lock+0x37/0xf0 (36)
Apr  1 18:05:24 coyote kernel:  [<c0374987>] __down_interruptible+0x257/0x4f0 (88)
Apr  1 18:05:24 coyote kernel:  [<c0132cba>] rt_down_interruptible+0xba/0x1f0 (48)
Apr  1 18:05:24 coyote kernel:  [<f8c9d8f4>] raw1394_read+0x104/0x110 [raw1394] (32)
Apr  1 18:05:24 coyote kernel:  [<c015d45d>] vfs_read+0xcd/0x140 (36)
Apr  1 18:05:24 coyote kernel:  [<c015d750>] sys_read+0x50/0x80 (44)
Apr  1 18:05:24 coyote kernel:  [<c0102cf8>] sysenter_past_esp+0x61/0x89 (-4028)
Apr  1 18:05:24 coyote kernel:
Apr  1 18:05:24 coyote kernel: showing all tasks:
Apr  1 18:05:24 coyote kernel: S            init:    1 [c190d670, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S     ksoftirqd/0:    2 [c190d0e0, 105] (not blocked)
Apr  1 18:05:24 coyote kernel: S       desched/0:    3 [c190cb50, 105] (not blocked)
Apr  1 18:05:24 coyote kernel: S        events/0:    4 [c190c5c0,  98] (not blocked)
Apr  1 18:05:24 coyote kernel: S         khelper:    5 [c190c030, 112] (not blocked)
Apr  1 18:05:24 coyote kernel: S         kthread:   10 [c192d690, 110] (not blocked)
Apr  1 18:05:24 coyote kernel: S          kacpid:   19 [c192d100, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 9:   20 [c192cb70,  50] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kblockd/0:  147 [c192c5e0, 110] (not blocked)
Apr  1 18:05:24 coyote kernel: S           khubd:  160 [c192c050, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S         pdflush:  220 [c1b796b0, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S         pdflush:  221 [c1b79120, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S           aio/0:  223 [c1b78600, 112] (not blocked)
Apr  1 18:05:24 coyote kernel: S         kswapd0:  222 [c1b78b90, 125] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 8:  808 [f7c3f6d0,  51] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 0:  820 [f7c3f140,  52] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 6:  840 [f7c3ebb0,  53] (not blocked)
Apr  1 18:05:24 coyote kernel: S         kseriod:  812 [c1b78070, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S          IRQ 14:  859 [f7c3e620,  54] (not blocked)
Apr  1 18:05:24 coyote kernel: S          IRQ 15:  861 [f7c3e090,  55] (not blocked)
Apr  1 18:05:24 coyote kernel: S          IRQ 12:  883 [f7cae0b0,  56] (not blocked)
Apr  1 18:05:24 coyote kernel: S          IRQ 11:  888 [f7ccd710,  57] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 5:  892 [f7ccd180,  58] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 1:  944 [f7d35240,  59] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald:  949 [f7d2a700, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald: 1432 [f7e477f0, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald: 1433 [f7f13930, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald: 1434 [f7d34cb0, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald: 1435 [f7d1c150, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald: 1436 [f7d1d200, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald: 1437 [f7d1c6e0, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S       kjournald: 1438 [f7d2b7b0, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S        khpsbpkt: 1496 [f7d2b220, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S     knodemgrd_0: 1557 [f7fc8940, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 4: 1614 [f7d2ac90,  60] (not blocked)
Apr  1 18:05:24 coyote kernel: S           IRQ 3: 1615 [f7f8c920,  61] (not blocked)
Apr  1 18:05:24 coyote kernel: S         syslogd: 1921 [f7e46cd0, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S           klogd: 1925 [f7d357d0, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S         portmap: 1936 [f7caf6f0, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S       rpc.statd: 1955 [f7f8ceb0, 121] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nscd: 1992 [f7e46740, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nscd: 1993 [f7fc83b0, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nscd: 1994 [f7caf160, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nscd: 1995 [f7fc99f0, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nscd: 1996 [f7fc8ed0, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nscd: 1997 [f7fc9460, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S            ntpd: 2012 [f7caebd0, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S     mount.smbfs: 2022 [f7cccbf0, 119] (not blocked)
Apr  1 18:05:24 coyote kernel: S          smbiod: 2024 [f7ccc0d0, 115] (not blocked)
Apr  1 18:05:24 coyote kernel: S     mount.smbfs: 2027 [f7d2a170, 121] (not blocked)
Apr  1 18:05:24 coyote kernel: S          identd: 2037 [f7d34190, 123] (not blocked)
Apr  1 18:05:24 coyote kernel: S          identd: 2044 [f7cae640, 124] (not blocked)
Apr  1 18:05:24 coyote kernel: S          identd: 2045 [f7f26e30, 123] (not blocked)
Apr  1 18:05:24 coyote kernel: S          identd: 2046 [f7f27950, 123] (not blocked)
Apr  1 18:05:24 coyote kernel: S          smartd: 2054 [f7d34720, 122] (not blocked)
Apr  1 18:05:24 coyote kernel: S        arpwatch: 2063 [f7f268a0, 116] (not blocked)
Apr  1 18:05:24 coyote kernel: S            sshd: 2074 [f7e461b0, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S          xinetd: 2089 [f7e47260, 117] (not blocked)
Apr  1 18:05:24 coyote kernel: S     rpc.rquotad: 2102 [f7f273c0, 119] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2106 [f7f8c390, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2107 [f7f8d9d0, 119] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2108 [f7f12880, 119] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2109 [f7f133a0, 119] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2110 [f7f12e10, 119] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2111 [f7d1d790, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2112 [f7d1cc70, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S            nfsd: 2113 [f6db7a30, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S           lockd: 2117 [f6db74a0, 122] (not blocked)
Apr  1 18:05:24 coyote kernel: S        rpciod/0: 2118 [f6db6f10, 111] (not blocked)
Apr  1 18:05:24 coyote kernel: S      rpc.mountd: 2119 [f6db6980, 121] (not blocked)
Apr  1 18:05:24 coyote kernel: S      rpc.rstatd: 2148 [f7f26310, 122] (not blocked)
Apr  1 18:05:24 coyote kernel: S       S61xprint: 2261 [f6df4410, 121] (not blocked)
Apr  1 18:05:24 coyote kernel: S       S61xprint: 2264 [f6e7f0e0, 124] (not blocked)
Apr  1 18:05:24 coyote kernel: S       S61xprint: 2267 [f6df5a50, 120] (not blocked)
Apr  1 18:05:24 coyote kernel: S Apr  1 18:05:13 coyote gconfd (root-5947): starting (version 2.6.0), pid 5947 user 'root'
Apr  1 18:05:13 coyote gconfd (root-5947): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at position 0
Apr  1 18:05:13 coyote gconfd (root-5947): Resolved address "xml:readwrite:/root/.gconf" to a writable config source at position 1
Apr  1 18:05:13 coyote gconfd (root-5947): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at position 2
Apr  1 18:05:19 coyote ieee1394.agent[6002]: ... no drivers for IEEE1394 product 0x/0x/0x
Apr  1 18:05:20 coyote kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Apr  1 18:05:20 coyote ieee1394.agent[6016]: ... no drivers for IEEE1394 product 0x/0x/0x
[...]
Apr  1 18:05:24 coyote kernel:
Apr  1 18:05:24 coyote kernel: ==========================================
Apr  1 18:05:24 coyote kernel: [ BUG: lock recursion deadlock detected! |
Apr  1 18:05:24 coyote kernel: ------------------------------------------
[...snip copy]
[...snip copy]
Apr  1 18:05:26 coyote kernel: #042:             [c045fa00] {tasklist_lock}
Apr  1 18:05:26 coyote kernel: .. held by:              kino: 6082 [e13ecbb0, 118]
Apr  1 18:05:26 coyote kernel: ... acquired at:  show_all_locks+0x30/0x130
Apr  1 18:05:26 coyote kernel: =============================================
Apr  1 18:05:26 coyote kernel:
Apr  1 18:05:26 coyote kernel: [ turning off deadlock detection. Please report this trace. ]
Apr  1 18:05:26 coyote kernel:
Apr  1 18:05:43 coyote gconfd (root-5947): GConf server is not in use, shutting down.
Apr  1 18:05:43 coyote gconfd (root-5947): Exiting
Apr  1 18:08:33 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: USB SPCA5XX camera found.Type Labtec Webcam Pro Zc0302 + Hdcs2020
Apr  1 18:08:33 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: [spca50x_probe:7258] Camera type JPEG
Apr  1 18:08:33 coyote kernel: usbcore: registered new driver spca50x
Apr  1 18:08:33 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: spca5xx driver 56.02.06 registered
Apr  1 18:08:33 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/zc3xx.h: [zc3xx_init:231] Find Sensor HDCS2020
Apr  1 18:08:33 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: init isoc: usb_submit_urb(0) ret -28
Apr  1 18:08:47 coyote kernel: ohci_hcd 0000:00:02.1: bad entry 37ce6440
                                                                                                                      [e9d36d08] {(struct semaphore *)(&tty->atomic_write)}
--------------------------------
There are several sets of duplicate entries above, and to took
the liberty of clipping some of them back out, almost as if
the logging got stuck in a loop.

But, I only started kino once.  And switched it to capture mode after
starting, once, and shut it down once.

And, as far as getting video from the camera and displaying it on screen,
that was fine ANAICT.

Make of this what you can.  It certainly looks unusual to me.
                                                                                                                 
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
