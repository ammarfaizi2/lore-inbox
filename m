Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311940AbSCOGhJ>; Fri, 15 Mar 2002 01:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311941AbSCOGg7>; Fri, 15 Mar 2002 01:36:59 -0500
Received: from syr-24-24-11-40.twcny.rr.com ([24.24.11.40]:16632 "EHLO
	server.foo") by vger.kernel.org with ESMTP id <S311940AbSCOGgy>;
	Fri, 15 Mar 2002 01:36:54 -0500
Date: Fri, 15 Mar 2002 01:36:44 -0500
From: Dan Maas <dmaas@dcine.com>
To: linux-kernel@vger.kernel.org
Subject: unwanted disk access by the kernel?
Message-ID: <20020315013644.A26891@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Info: http://www.dcine.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to set up my laptop for mobile use. I'm having a
problem with unwanted disk activity - even when the system is
completely idle, there is still an occasional trickle of disk writes
(which prevents the poor hard drive from ever spinning down). 

Yes, I thought this was a user-space issue too - but even booting into
a bare-bones root environment does not stop the occasional disk
access! Here is everything that's left:

 PID USER       VSZ  RSS     TIME STAT COMMAND          WCHAN
    7 root         0    0 00:00:00 SW   [kupdated]       kupdate
    6 root         0    0 00:00:00 SW   [bdflush]        bdflush
    5 root         0    0 00:00:00 SW   [kswapd]         kswapd
    4 root         0    0 00:00:00 SWN  [ksoftirqd_CPU0] ksoftirqd
    1 root      1316  524 00:00:05 S    init [S]         select
    2 root         0    0 00:00:00 SW   [keventd]        context_thread
    3 root         0    0 00:00:00 SW   [kapmd]          apm_mainloop
    8 root         0    0 00:00:00 Z    [khubd <defunct> exit
  879 root      1316  524 00:00:00 S    init [S]         wait4
  880 root      2556 1576 00:00:00 S     \_ bash         wait4
  927 root      3524 1512 00:00:00 R         \_ ps afx - -

If I manually spin down the disk, it always wakes up within 30 seconds
or so. During the spin-up, kupdated goes into the 'D' state and blocks
in wait_on_buffer(). This means it's writing dirty filesystem buffers,
right? So who is doing the dirtying? I've eliminated all possible
user-space sources of I/O! (strace confirms that NO user-space
processes are doing I/O; they're all sleeping...)

(I'm running a stock Linus 2.4.18 kernel, with APM enabled. The system
is Debian woody. All filesystems are ext2.)

Regards,
Dan
