Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTJXXkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 19:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJXXkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 19:40:22 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:63703 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262092AbTJXXkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 19:40:11 -0400
Date: Fri, 24 Oct 2003 19:43:49 -0400
To: piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031024234349.GA22294@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quad P3 Xeon.  Only the as-iosched.c from test5
really fixes the regression.

2.6.0-test8 = vanilla
2.6.0-test8-as = vanilla + as-iosched.c from test5
2.6.0-test8-as2 = vanilla + first as-fix patch
2.6.0-test8-as = vanilla + second as-fix patch

AIM7 dbase workload
kernel                   Tasks   Jobs/Min        Real    CPU
2.6.0-test8-as           32	601.0		316.3	134.0
2.6.0-test8-as3          32	320.7		592.7	128.3
2.6.0-test8-as2          32	304.3		624.6	128.8
2.6.0-test8              32	299.8		634.0	128.6

2.6.0-test8-as           64	782.6		485.8	259.2
2.6.0-test8-as3          64	470.1		808.7	247.0
2.6.0-test8-as2          64	458.2		829.8	245.7
2.6.0-test8              64	450.5		843.9	246.5

2.6.0-test8-as           96	869.1		656.1	387.6
2.6.0-test8              96	549.7		1037.4	366.0
2.6.0-test8-as2          96	543.4		1049.4	370.0
2.6.0-test8-as3          96	521.4		1093.6	372.5

2.6.0-test8-as           128	919.3		827.0	522.8
2.6.0-test8-as2          128	564.1		1348.0	496.6
2.6.0-test8              128	558.7		1360.8	497.6
2.6.0-test8-as3          128	551.9		1377.6	499.9

2.6.0-test8-as           160	955.0		995.2	650.3
2.6.0-test8-as2          160	534.2		1779.2	618.2
2.6.0-test8              160	522.1		1820.2	612.2
2.6.0-test8-as3          160	517.0		1838.4	611.9

2.6.0-test8-as           192	981.9		1161.5	790.9
2.6.0-test8-as2          192	535.6		2129.3	746.5
2.6.0-test8-as3          192	530.1		2151.3	744.8
2.6.0-test8              192	515.5		2212.4	742.7

2.6.0-test8-as           224	1002.3		1327.5	910.2
2.6.0-test8-as3          224	531.7		2502.3	850.2
2.6.0-test8              224	529.9		2510.8	859.5
2.6.0-test8-as2          224	526.4		2527.5	852.9

2.6.0-test8-as           256	1009.9		1505.7	1027.7
2.6.0-test8-as3          256	555.3		2738.2	976.5
2.6.0-test8              256	552.4		2753.0	980.4
2.6.0-test8-as2          256	548.9		2770.4	975.3


AIM7 fserver workload
kernel                   Tasks   Jobs/Min        Real    CPU
2.6.0-test8-as           4	80.5		301.0	37.0
2.6.0-test8-as2          4	46.4		521.9	42.5
2.6.0-test8-as3          4	43.8		553.0	44.5
2.6.0-test8              4	42.3		573.6	40.9

2.6.0-test8-as           8	133.0		364.6	64.0
2.6.0-test8-as3          8	65.5		740.3	71.1
2.6.0-test8              8	63.3		765.7	71.6
2.6.0-test8-as2          8	59.9		809.1	74.4

2.6.0-test8-as           12	166.7		436.3	93.4
2.6.0-test8              12	83.2		874.2	95.0
2.6.0-test8-as3          12	67.2		1081.6	99.8
2.6.0-test8-as2          12	62.6		1161.5	99.5

2.6.0-test8-as           16	175.9		551.2	111.5
2.6.0-test8              16	87.5		1108.4	102.5
2.6.0-test8-as2          16	84.1		1152.9	109.6
2.6.0-test8-as3          16	82.0		1182.4	112.0

2.6.0-test8-as           20	186.3		650.7	133.8
2.6.0-test8              20	105.0		1154.6	136.7
2.6.0-test8-as2          20	101.3		1196.4	135.8
2.6.0-test8-as3          20	100.5		1206.3	128.8

2.6.0-test8-as           24	202.8		717.3	161.2
2.6.0-test8-as2          24	121.4		1198.0	164.1
2.6.0-test8              24	111.2		1308.1	162.2
2.6.0-test8-as3          24	104.8		1387.9	163.9

2.6.0-test8-as           28	207.1		819.3	200.0
2.6.0-test8              28	130.7		1297.9	185.8
2.6.0-test8-as2          28	128.0		1326.1	190.3
2.6.0-test8-as3          28	123.4		1374.5	186.9

2.6.0-test8-as           32	210.6		920.7	226.5
2.6.0-test8              32	134.2		1444.5	212.9
2.6.0-test8-as3          32	130.4		1487.1	217.7
2.6.0-test8-as2          32	122.4		1583.7	217.5


AIM7 shared workload
kernel                   Tasks   Jobs/Min        Real    CPU
2.6.0-test8-as           64	1949.6		191.1	170.8
2.6.0-test8-as2          64	880.0		423.3	166.6
2.6.0-test8-as3          64	878.8		423.9	166.3
2.6.0-test8              64	829.1		449.3	167.8

2.6.0-test8-as           128	2148.3		346.8	339.2
2.6.0-test8-as3          128	1176.2		633.4	331.1
2.6.0-test8-as2          128	1128.7		660.0	331.4
2.6.0-test8              128	1105.2		674.1	330.5

2.6.0-test8-as           192	2265.7		493.2	507.1
2.6.0-test8-as3          192	1330.7		839.7	505.0
2.6.0-test8              192	1320.0		846.6	504.7
2.6.0-test8-as2          192	1317.8		848.0	503.3

2.6.0-test8-as           256	2382.9		625.3	678.0
2.6.0-test8-as3          256	1490.3		999.7	673.6
2.6.0-test8              256	1462.1		1019.0	672.7
2.6.0-test8-as2          256	1453.3		1025.2	670.9

2.6.0-test8-as           320	2450.5		760.0	853.7
2.6.0-test8-as3          320	1579.7		1178.9	849.0
2.6.0-test8              320	1573.0		1184.0	845.2
2.6.0-test8-as2          320	1564.0		1190.8	848.2

2.6.0-test8-as           384	2517.4		887.8	1030.6
2.6.0-test8-as3          384	1633.0		1368.6	1020.7
2.6.0-test8-as2          384	1609.8		1388.3	1026.2
2.6.0-test8              384	1601.1		1395.9	1028.7

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

