Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbTGHN70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbTGHN6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:58:14 -0400
Received: from franka.aracnet.com ([216.99.193.44]:12961 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S267354AbTGHN4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:56:54 -0400
Date: Tue, 08 Jul 2003 07:11:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 890] New: performance regression compared to 2.4.20 under tight RAM conditions 
Message-ID: <40390000.1057673479@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=890

           Summary: performance regression compared to 2.4.20 under tight
                    RAM conditions
    Kernel Version: 2.5.73
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: idan@idanso.dyndns.org


Distribution:
debian unstable

Hardware Environment:
Pentium III 700Mhz
I815E Based motherboard
64MB SDRAM 133
WD 6GB harddrive, UDMA2

Software Environment:
GCC 3.3-2
glibc 2.3.1-16
Swap partition 123MB
Swap file(on ext3 fs) of about 96MB

Problem Description:

For quite a time I had the feeling that the 2.5.x kernels perform worse than
2.4.x on my box, especially when having to do aggrassive swapping(Switching
between relatively heavyweight(ram wise) applications)

I considered this feeling subjective at first, however, eventually I took the
time to write some benchmarking code and compare results.

The code(attached) is pretty trivial, it forks, mallocs and initialize a very
large bulk of memory(I used total RAM*1.5), in order to force the system to
swap, and simulate two processes fighting on RAM space when there is no enough
of that scared resource:-)

After both processes end their work, the parent process reports on the total
running time.

The code was compiled using gcc 3.3 with -O2 parameter.

I've done 20 iterations on each of the three kernels:
Stock debian 2.4.20 (kernel-source-2.4.20-5)
Stock vanilla 2.5.73 with preempt
Stock vanilla 2.5.73 without preempt

Result are at follows:
2.4.20            : Mean - 14.1732 Max - 16.0875 Min - 12.9977 
2.5.73            : Mean - 17.1692 Max - 21.8161 Min - 15.4827
2.5.73(w/o prempt): Mean - 16.9054 Max - 19.0174 Min - 15.4137

As can be seen, the differences are quite significant, about three seconds on
average, which I believe may be related to the increased swapping time I have
encountered.

