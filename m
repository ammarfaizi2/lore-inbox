Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTJXAHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTJXAHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:07:53 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:45747 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261905AbTJXAHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:07:50 -0400
Date: Thu, 23 Oct 2003 20:10:58 -0400
To: piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031024001035.GA13840@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Randy can reproduce regressions, so I'll work on his first.

Below is test8 and test8 with the test5 as-iosched.c (2.6.0-test8-as).
Jobs/minute is way up, and total runtime is way down with the test5
as-iosched.c.   

The machine (quad P3 xeon) locked up during a bonnie++ run.  I can't
compare that to vanilla test8 because I stopped the test8 to run the
test5 as-iosched.   Both of these were compiled with gcc-3.3.1 because
of the RedHat gcc-2.96 bug in test8.  (In case the compiler was part
of the instability).

Earlier I ran 2.6.0-test3-mm2 compiled with gcc-3.3.1, and it
was stable on this box.

AIM7 dbase workload
kernel                   Tasks   Jobs/Min       Real    CPU
2.6.0-test8-as           32	601.0	       316.3	134.0
2.6.0-test8              32	299.8	       634.0	128.6

2.6.0-test8-as           64	782.6	       485.8	259.2
2.6.0-test8              64	450.5	       843.9	246.5

2.6.0-test8-as           96	869.1	       656.1	387.6
2.6.0-test8              96	549.7	       1037.4	366.0

2.6.0-test8-as           128	919.3	       827.0	522.8
2.6.0-test8              128	558.7	       1360.8	497.6

2.6.0-test8-as           160	955.0	       995.2	650.3
2.6.0-test8              160	522.1	       1820.2	612.2

2.6.0-test8-as           192	981.9	       1161.5	790.9
2.6.0-test8              192	515.5	       2212.4	742.7

2.6.0-test8-as           224	1002.3	       1327.5	910.2
2.6.0-test8              224	529.9	       2510.8	859.5

2.6.0-test8-as           256	1009.9	       1505.7	1027.7
2.6.0-test8              256	552.4	       2753.0	980.4


AIM7 fserver workload
kernel                   Tasks   Jobs/Min       Real    CPU
2.6.0-test8-as           4	80.5	       301.0	37.0
2.6.0-test8              4	42.3	       573.6	40.9

2.6.0-test8-as           8	133.0	       364.6	64.0
2.6.0-test8              8	63.3	       765.7	71.6

2.6.0-test8-as           12	166.7	       436.3	93.4
2.6.0-test8              12	83.2	       874.2	95.0

2.6.0-test8-as           16	175.9	       551.2	111.5
2.6.0-test8              16	87.5	       1108.4	102.5

2.6.0-test8-as           20	186.3	       650.7	133.8
2.6.0-test8              20	105.0	       1154.6	136.7

2.6.0-test8-as           24	202.8	       717.3	161.2
2.6.0-test8              24	111.2	       1308.1	162.2

2.6.0-test8-as           28	207.1	       819.3	200.0
2.6.0-test8              28	130.7	       1297.9	185.8

2.6.0-test8-as           32	210.6	       920.7	226.5
2.6.0-test8              32	134.2	       1444.5	212.9


AIM7 shared workload
kernel                   Tasks   Jobs/Min       Real    CPU
2.6.0-test8-as           64	1949.6	       191.1	170.8
2.6.0-test8              64	829.1	       449.3	167.8

2.6.0-test8-as           128	2148.3	       346.8	339.2
2.6.0-test8              128	1105.2	       674.1	330.5

2.6.0-test8-as           192	2265.7	       493.2	507.1
2.6.0-test8              192	1320.0	       846.6	504.7

2.6.0-test8-as           256	2382.9	       625.3	678.0
2.6.0-test8              256	1462.1	       1019.0	672.7

2.6.0-test8-as           320	2450.5	       760.0	853.7
2.6.0-test8              320	1573.0	       1184.0	845.2

2.6.0-test8-as           384	2517.4	       887.8	1030.6
2.6.0-test8              384	1601.1	       1395.9	1028.7

2.6.0-test8-as           448	2547.5	       1023.5	1214.4
2.6.0-test8              448	1659.7	       1571.0	1205.2

2.6.0-test8-as           512	2594.6	       1148.5	1389.7
2.6.0-test8              512	1614.4	       1845.8	1381.5

I'm running Nick's patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=106688130229337&w=2
on test8 at the moment.  I should have some comparison numbers 
within 24 hours.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

