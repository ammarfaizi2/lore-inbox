Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbTCZPVC>; Wed, 26 Mar 2003 10:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbTCZPVC>; Wed, 26 Mar 2003 10:21:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21376 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261738AbTCZPVA>; Wed, 26 Mar 2003 10:21:00 -0500
Date: Wed, 26 Mar 2003 07:32:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 503] New: Hyper Threading technology
Message-ID: <227380000.1048692729@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=503

           Summary: Hyper Threading technology
    Kernel Version: 2.5.65
            Status: NEW
          Severity: low
             Owner: rml@tech9.net
         Submitter: koch@dfki.uni-kl.de


Distribution: SuSE 8.0
Hardware Environment: Tyan Thunder i860 S2603, dual XEON 2.8GHz, 512MB RDRAM
Software Environment:
Problem Description: System hung after enabling HT in BIOS

Steps to reproduce: I just installed SuSE 8.0 on the machine, downloaded the
kernel, configured it (i think to sane settings), put it into /boot and ran
lilo. After reboot, i did some benchmarking and the machine seemed to run
fine. When i rebooted a second time and enabled HT in the BIOS, the machine
came up but hung after i logged in (before i could run any benchmark). I
tried everything, but had to use hardware reset. I didn't investigate this
further because the machine had to be finished yesterday.

And now something completely different: Did i say benchmarking? No, not
really. I did compile the 2.5.65 kernel with several different 'make -j'
options to see the impact of HT and if i should enable or disable it and
what the benefit of using a 2.5 kernel would be. I know that compiling a
kernel is not exactly a benchmark, but since the machine will be used in
software development under C i thought it might reveal some issues anyway.
What i found out is interesting (at least for me) and did not meet my (and
other peoples) expectations:
The penalty of using the 2.5.65 kernel (4.6%) is bigger than the penalty of
enabling HT on the 2.4.18 that came with SuSE 8.0 (only 2%). The gain of
using HT on the 2.4.18 is quite astonishing: about 14%.
Here are my numbers:

2 x XEON 2.8GHz (HT enabled)    SuSE 8.0 Kernel 2.4.18
                                real            user            sys
        make            -       243.6           229.0           23.6
        make -j 2       -       132.9           247.6           26.2
        make -j 3       -       120.8           335.3           30.8
        make -j 4       -       115.8           406.1           34.6
        make -j 5       -       116.0           406.0           34.8

2 x XEON 2.8GHz (HT disabled)   SuSE 8.0 Kernel 2.4.18

        make            -       239.0           223.8           22.3
        make -j 2       -       132.3           229.7           23.4
        make -j 3       -       132.8           231.3           24.5

2 x XEON 2.8GHz (HT enabled)    SuSE 8.0 Kernel 2.5.65

        --------- System hung before any benchmark was run ---------

2 x XEON 2.8GHz (HT disabled)   SuSE 8.0 Kernel 2.5.65

        make            -       250.5           229.9           25.0
        make -j 2       -       134.9           235.8           27.1
        make -j 3       -       136.7           237.3           27.5

