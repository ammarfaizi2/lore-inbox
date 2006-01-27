Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWA0IGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWA0IGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWA0IGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:06:42 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:425 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S964905AbWA0IGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:06:42 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Jan 2006 09:06:04 +0100
MIME-Version: 1.0
Subject: Clock resolution (2.6.15.1)
Message-ID: <43D9E27B.32448.55EA249@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=114621@20060127.075925Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please-CC-Replies-To: (original sender)

Hi,

with 2.6.15.1 and my implementation of the PPS API I made an experiment: I had 
connected my Meinberg GPS167 (GPS what else) receiver to the serial port ttyS1, 
measuring the PPS (Pulse Per Second) pulses with the kernel clock (Pentium III at 
700MHz, PC133 RAM, Shuttle AV11 board; Kernel configured for 100Hz interrupts).

Here are some results (heavily truncated):

First, the uncorrected clock (after warmup of the board, and little warm-up of the 
GPS):

clear 7 time 1138314899.902913000 delta 0.999883000 jitter 0
clear 8 time 1138314900.902796000 delta 0.999883000 jitter 0
clear 9 time 1138314901.902680000 delta 0.999884000 jitter 1000
clear 10 time 1138314902.902563000 delta 0.999883000 jitter -1000
clear 11 time 1138314903.902448000 delta 0.999885000 jitter 2000
clear 12 time 1138314904.902329000 delta 0.999881000 jitter -4000
clear 13 time 1138314905.902212000 delta 0.999883000 jitter 2000
clear 14 time 1138314906.902096000 delta 0.999884000 jitter 1000
clear 15 time 1138314907.901980000 delta 0.999884000 jitter 0
clear 16 time 1138314908.901864000 delta 0.999884000 jitter 0
clear 17 time 1138314909.901746000 delta 0.999882000 jitter -2000
clear 18 time 1138314910.901629000 delta 0.999883000 jitter 1000
clear 19 time 1138314911.901512000 delta 0.999883000 jitter 0

Legend: "clear #" is the numbered "clear event" (pulse counter)
        "time #.#" is the time of the event in seconds and nanoseconds
        "delta #" is the time between pulses (as measured by the kernel clock)
        "jitter #" is the time difference between the last deltas (in nanoseconds)

As you can see there are perfect jitters (which cannot be true), so a higher 
resolution of the kernel clock even on my moderate hardware can make sense. I 
guess it would not just add random bits.

The next test was to check the NTP frequency correction (the board's clock is too 
slow by about 100 PPM (Parts Per Million)), so I used "ntptime -f100 -s1" to 
enable the frequency correction in the kernel (to see whether it will add more 
jitter). The results (truncated):

clear 67 time 1138316000.787886000 delta 1.000004000 jitter 0
clear 68 time 1138316001.787889000 delta 1.000003000 jitter -1000
clear 69 time 1138316002.787892000 delta 1.000003000 jitter 0
clear 70 time 1138316003.787896000 delta 1.000004000 jitter 1000
clear 71 time 1138316004.787899000 delta 1.000003000 jitter -1000
clear 72 time 1138316005.787904000 delta 1.000005000 jitter 2000
clear 73 time 1138316006.787906000 delta 1.000002000 jitter -3000
clear 74 time 1138316007.787910000 delta 1.000004000 jitter 2000
clear 75 time 1138316008.787913000 delta 1.000003000 jitter -1000
clear 76 time 1138316009.787917000 delta 1.000004000 jitter 1000
clear 77 time 1138316010.787920000 delta 1.000003000 jitter -1000
clear 78 time 1138316011.787923000 delta 1.000003000 jitter 0
clear 79 time 1138316012.787927000 delta 1.000004000 jitter 1000
clear 80 time 1138316013.787931000 delta 1.000004000 jitter 0
clear 81 time 1138316014.787934000 delta 1.000003000 jitter -1000
clear 82 time 1138316015.787938000 delta 1.000004000 jitter 1000
clear 83 time 1138316016.787941000 delta 1.000003000 jitter -1000

Finally I used the same method to make the clock much worse (ideally I wanted to 
watch the crossing of the full second, but that was still to slow for me to wait 
for):

clear 51 time 1138316329.749725000 delta 0.999440000 jitter -1000
clear 52 time 1138316330.749165000 delta 0.999440000 jitter 0
clear 53 time 1138316331.748606000 delta 0.999441000 jitter 1000
clear 54 time 1138316332.748046000 delta 0.999440000 jitter -1000
clear 55 time 1138316333.747487000 delta 0.999441000 jitter 1000
clear 56 time 1138316334.746927000 delta 0.999440000 jitter -1000
clear 57 time 1138316335.746367000 delta 0.999440000 jitter 0
clear 58 time 1138316336.745808000 delta 0.999441000 jitter 1000
clear 59 time 1138316337.745248000 delta 0.999440000 jitter -1000
clear 60 time 1138316338.744688000 delta 0.999440000 jitter 0
clear 61 time 1138316339.744128000 delta 0.999440000 jitter 0
clear 62 time 1138316340.743568000 delta 0.999440000 jitter 0
clear 63 time 1138316341.743009000 delta 0.999441000 jitter 1000
clear 64 time 1138316342.742450000 delta 0.999441000 jitter 0
clear 65 time 1138316343.741890000 delta 0.999440000 jitter -1000
clear 66 time 1138316344.741330000 delta 0.999440000 jitter 0
clear 67 time 1138316345.740770000 delta 0.999440000 jitter 0

(I'm trying to work on a patch for revised kernel NTP algorithms, but that is a 
terrible amount of work, especially as some NTP code bits had been spread allover 
the architectures. So if anybody wants to do the same, maybe drop me a note)

Regards,
Ulrich

