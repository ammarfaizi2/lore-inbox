Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSGZQoh>; Fri, 26 Jul 2002 12:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSGZQog>; Fri, 26 Jul 2002 12:44:36 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:5818 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317851AbSGZQof>; Fri, 26 Jul 2002 12:44:35 -0400
Subject: 2.5.28, dbench results with ext3 significantly lower than with ext2.
From: Steven Cole <elenstev@mesatop.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       Steven Cole <scole@lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 26 Jul 2002 10:45:23 -0600
Message-Id: <1027701923.3148.10.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that dbench gives significantly lower numbers when
the partition on which it is run is mounted as ext3.

Here are some results, using the 2.5.28 kernel.
The hardware is dual p3, 1Ghz, 1GB memory, SCSI disks.

1st column is dbench clients.
2nd column is throughput with /home as ext2.
3rd column is throughput with /home as ext3 and data=writeback.
4th column is throughput with /home as ext3 and data=ordered.

The first set of data is from the test run right after boot.
The second set of data is from the test repeated immediately after
the first run. I used time -v dbench x, and ran vmstat after
each dbench run, so that output is available if needed.  I can
rerun these tests looking at any specific vm stats which might be
of interest.

The short answer may be that dbench is not a reliable benchmark
for comparing filesystems.  Or there may be something else more 
interesting happening.

Steven

		Ext2		writeback  	ordered
1		97.4729		66.8692		80.6777
2		173.776		115.785		78.4331
3		169.716		131.403		55.9812
4		182.292		137.741		54.0658
6		182.9		140.096		51.7433
8		185.994		136.422		45.8054
10		185.835		139.128		39.9597
12		190.126		136.411		47.4232
16		188.184		108.701		40.6673
20		154.191		99.8339		37.2275
24		143.686		59.2361		33.4655
28		153.039		56.741		43.1158
32		128.06		43.6015		41.6765
36		100.212		38.4583		35.9686
40		99.3539		39.8462		36.7342
44		93.8014		38.1305		30.2785
48		95.3078		33.0158		32.7519
52		83.2341		29.6972		34.3698
56		86.8121		31.4319		35.6022
64		86.2708		28.6704		35.851
80		61.82		23.4508		29.9819
96		55.1902		20.3729		25.9
112		49.4728		18.9149		25.9441
128		45.5107		17.8682		25.5909
			
		Ext2		writeback  	ordered
1		112.486		90.063		88.4505
2		180.415		137.191		64.5044
3		187.655		142.127		66.5859
4		187.532		143.339		87.0815
6		192.05		142.317		50.8091
8		194.123		145.15		58.4781
10		193.88		107.345		52.4863
12		196.477		145.3		75.8064
16		196.05		119.826		38.7418
20		194.808		105.656		37.2839
24		194.146		80.4529		42.4934
28		159.703		56.2274		36.4412
32		141.214		47.6162		31.9981
36		126.962		45.0119		39.2894
40		95.749		34.4893		34.5664
44		90.348		30.5858		31.1847
48		94.087		34.1891		37.1048
52		87.3876		31.4304		34.8207
56		86.7181		30.9259		35.7337
64		86.682		26.9397		30.3703
80		54.4207		22.8923		31.7975
96		53.1359		20.1692		28.6667
112		52.1108		18.8062		24.6706
128		45.2542		   * 		22.2984

* unexpected power outage during 128 clients 2nd run with data=writeback.




