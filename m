Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbSJIU3o>; Wed, 9 Oct 2002 16:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbSJIU3o>; Wed, 9 Oct 2002 16:29:44 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:54430 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261942AbSJIU3h>; Wed, 9 Oct 2002 16:29:37 -0400
Message-ID: <20021009203410.25807.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2002 04:34:10 +0800
Subject: [BENCHMARK] dbench based
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
here the results of a simple dbench test.
The "core" of script is the following:

for value in 2 8 16 24 32;
do 
	log=${kern}$1.dbench${value}.$date.log
	echo $log
		> ./log/$log
		for i in `seq 1 1 3`;
		do 
			echo $i ":" $value
			sync;
			sync;
			sync;
			./dbench $value |grep Th >> ./log/$log
		done;
	
	 awk '{tot+=$2}; END {print "Average: " tot/NR " MB/sec"}' ./log/$log >>./log/$log

The scripts evaluates the average of 3 runs of dbench N.
The missing part of the script is just "logging".
If someone is interested I can send or post to lkml the whole script.




--- 2.4.19 ---
Istances Throughput
2 	 46.6689
8 	 25.5343
16 	 20.7133
24 	 16.2473
32 	 14.2351

--- 2.5.34 ---
Istances Throughput
2 	 28.675
8 	 26.7106
16 	 21.0888
24 	 13.9644
32 	 12.6921

--- 2.5.41 ---
Istances Throughput
2 	 31.0127
8 	 32.0934
16 	 29.3058
24 	 20.291
32 	 19.157


Ok, dbench is not the best benchmark but, finally, 2.5.41 is faster then 2.4.19 (from the "dbench" point of view ;-)


HW PIII@800, 256 MiB RAM
FS ext3


Comments ?

Ciao,
		Paolo

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
