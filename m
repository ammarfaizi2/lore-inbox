Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269700AbSISARe>; Wed, 18 Sep 2002 20:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269713AbSISARe>; Wed, 18 Sep 2002 20:17:34 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:49390 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S269700AbSISARd>; Wed, 18 Sep 2002 20:17:33 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: fsync 50 times slower after 2.5.27
Date: Thu, 19 Sep 2002 02:22:33 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209190222.33276.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a performance degradation in recent kernels:
fsync takes around 50 times longer in kernels 2.5.28 to
2.5.34 when the system is under heavy load, as compared
to kernels <= 2.5.27.  I noticed this because it makes kmail
unusable.  2.5.34 is the most recent kernel I tested.

"Heavy load" is kernel compile (-j 4) at the same time as
another heavy compile.  The following fsyncs come from
strace -T -p <kmail pid>.  kmail does several fsyncs grouped
together, followed by other stuff, followed by more fsyncs.

Here are some typical fsync groups.  The time for each fsync
is the last number (in seconds).

2.5.27 (similar results for 2.5.26 and 2.4.19):

fsync(17)                               = 0 <0.078718>
fsync(18)                               = 0 <0.099900>
fsync(25)                               = 0 <0.004719>
fsync(11)                               = 0 <0.001747>
fsync(12)                               = 0 <0.001726>
fsync(13)                               = 0 <0.014935>
fsync(14)                               = 0 <0.011553>
fsync(15)                               = 0 <0.002506>
fsync(16)                               = 0 <0.002854>

2.5.28 (similar results for kernels up to 2.5.34):

fsync(17)                               = 0 <0.682749>
fsync(18)                               = 0 <2.142922>
fsync(22)                               = 0 <2.269918>
fsync(24)                               = 0 <1.114331>
fsync(11)                               = 0 <4.092790>
fsync(12)                               = 0 <2.309529>
fsync(13)                               = 0 <0.441093>
fsync(14)                               = 0 <1.730422>
fsync(15)                               = 0 <5.444556>
fsync(16)                               = 0 <1.844690>

The filesystem is ext3 but the same occurs with ext2.
This is a UP x86 (400MHz), no preempt.

Any ideas?  I have looked through the changes between
2.5.27 and 2.5.28 but don't see any obvious culprits...

All the best,

Duncan.
