Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRIRPPM>; Tue, 18 Sep 2001 11:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272090AbRIRPPC>; Tue, 18 Sep 2001 11:15:02 -0400
Received: from lilly.ping.de ([62.72.90.2]:29198 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S272092AbRIRPO6>;
	Tue, 18 Sep 2001 11:14:58 -0400
Date: 18 Sep 2001 17:14:16 +0200
Message-ID: <20010918171416.A6540@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

I gave your new vm a try and I have to report a problem. System is an
Athlon 1200 with 256MB memory. Workload:

1. top refreshing every second reniced to -10
2. alsaplayer -n -q -r *.wav
3. make -j4 bzImage modules

The problem is that with 2.4.10-pre11 alsaplayer is skiping very much.
Almost every ten seconds and then the break seems to be relatevily long
(like >1s). With 2.4.10-pre10 I noticed alsaplayer skiping once or twice
during the whole build (which takes about 6min) for a very short time
(like a cd player skipping over a scratch). Here is the diff output of
time -v of the make -j4 command:

planetzork:/usr/src/linux# diff -u time.out-2.4.10-pre1*
--- time.out-2.4.10-pre10-1000823801    Tue Sep 18 16:42:30 2001
+++ time.out-2.4.10-pre11-1000824952    Tue Sep 18 17:01:39 2001
@@ -1,16 +1,16 @@
-       Command being timed: "sh -c make dep clean>logfile-2.4.10-pre10 2>&1 && make -j4 bzImage modules>>logfile-2.4.10-pre10 2>&1"
-       User time (seconds): 241.28
-       System time (seconds): 17.82
+       Command being timed: "sh -c make dep clean>logfile-2.4.10-pre11 2>&1 && make -j4 bzImage modules>>logfile-2.4.10-pre11 2>&1"
+       User time (seconds): 242.11
+       System time (seconds): 17.10
        Percent of CPU this job got: 74%
-       Elapsed (wall clock) time (h:mm:ss or m:ss): 5:49.57
+       Elapsed (wall clock) time (h:mm:ss or m:ss): 5:47.60
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
-       Major (requiring I/O) page faults: 901054
-       Minor (reclaiming a frame) page faults: 934971
+       Major (requiring I/O) page faults: 906843
+       Minor (reclaiming a frame) page faults: 936570
        Voluntary context switches: 0
        Involuntary context switches: 0
        Swaps: 0


Best regards,

   Jochen

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
