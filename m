Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVJJURA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVJJURA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJJUQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:16:59 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:52890 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751191AbVJJUQ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:16:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XGPcYWN/pc2n9oA9A3mb86boVxffUo2YMl5VeQ+ahibTGBWuKmVje1MUpjU5gkTHKW+qSCW7TnLvQriywXFcN+5tWDRFzVZEn1K345PXn0mAa/biM6w+MdYQB/HW0EN8yYBDr0f0oMHhHFIjRKleGchlauSOsIG/EZlvjO7RbCg=
Message-ID: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
Date: Mon, 10 Oct 2005 13:16:58 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Latency data - 2.6.14-rc3-rt13
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I'm still suffering the occasional xrun using Jack so I'm trying to
understand what information I can feed back on this. I turned on the
histogram feature for both IRQ-off and preempt-off. From what I can
see so far it seems that something is turning IRQs off for long
periods of time? I think that this is similar to what Lee Revell
showed the other day, but I don't know how to get the same sort of
printout he showed.

This is the Jack data:

nperiods = 2 for capture
nperiods = 2 for playback
08:16:26.401 Server configuration saved to "/home/mark/.jackdrc".
08:16:26.401 Statistics reset.
08:16:26.637 Client activated.
08:16:26.639 Audio connection change.
08:16:26.642 Audio connection graph change.
08:16:28.395 MIDI connection graph change.
08:16:28.472 MIDI connection change.
08:16:29.664 Audio connection graph change.
08:19:50.071 Audio connection graph change.
08:19:50.263 MIDI connection graph change.
08:19:50.273 MIDI connection graph change.
10:04:36.179 Audio connection graph change.
10:04:36.362 Audio connection change.
10:04:38.800 Audio connection graph change.
10:04:38.810 Audio connection graph change.
12:34:09.601 XRUN callback (1).
**** alsa_pcm: xrun of at least 0.133 msecs
13:09:41.344 MIDI connection graph change.
13:09:41.439 MIDI connection change.
13:09:42.427 Audio connection graph change.
13:09:45.919 Audio connection graph change.
13:09:45.941 Audio connection graph change.
13:09:45.960 MIDI connection graph change.

This is what I see for preempt off latency. This looks really good to me:

#Minimum latency: 0 microseconds.
#Average latency: 0 microseconds.
#Maximum latency: 1207040 microseconds.
#Total samples: 196871313
#There are 2 samples greater or equal than 10240 microseconds
#usecs           samples
    0          190504250
    1            5881275
    2             379533
    3              69966
    4              13858
    5               5708
    6               2287
    7               7726
    8               1771
    9                465
   10                649
   11                935
   12                948
   13                720
   14                573
   15                329
   16                139
   17                 71
   18                 46
   19                 27
   20                 21
   21                  7
   22                  3
   23                  2
   24                  1
   25                  0
   26                  0
   27                  0


However, for IRQ off latency I have far larger numbers. I Assume that
it's probably pretty bad that interrupts could be turned off for as
long as 4mS when I'm trying to run sub3mS?

#Minimum latency: 0 microseconds.
#Average latency: 4 microseconds.
#Maximum latency: 3998 microseconds.
#Total samples: 3102665680
#There are 0 samples greater or equal than 10240 microseconds
#usecs           samples
    0         3066905198
    1            3817807
    2           15630448
    3             347330
    4              55362
    5              40098
    6              27080
    7              27740
    8              22484
    9              20298
   10              15727
   11              15346
   12              14870
   13              15258
   14             101559
   15              16152
<SNIP>
 1365              18434
 1366              15529
 1367              12471
 1368              11392
 1369              13927
 1370              21813
 1371              39568
 1372              87654
 1373             250408
 1374             535990
 1375             577197
 1376             370609
 1377             120045
 1378              20431
 1379               5312
 1380               5349
 1381               8203
 1382              14773
 1383              15352
 1384               9515
 1385               5020
 1386               3618
 1387               3738
 1388               5554
 1389               8669
 1390               8244
 1391               6448
 1392               4948
 1393               4151
 1394               5984
 1395              10599
 1396              19058
 1397              41222
 1398             109732
 1399             360362
 1400             354579
 1401             113700
 1402              11014
 1403               1240
 1404                754
 1405                772
 1406                963
 1407                850
 1408                445
 1409                276
<SNIP>
 3976                 62
 3977                 57
 3978                 71
 3979                 70
 3980                 59
 3981                 61
 3982                 69
 3983                 76
 3984                 75
 3985                 72
 3986                 76
 3987                 80
 3988                 65
 3989                 64
 3990                 78
 3991                 70
 3992                 85
 3993                128
 3994                236
 3995                358
 3996                 96
 3997                  0
 3998                  1
 3999                  0
 4000                  0
 4001                  0
 4002                  0


How can I get data that would be more useful in terms of real debug?

Thanks,
Mark
