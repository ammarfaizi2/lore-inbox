Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSKLLDk>; Tue, 12 Nov 2002 06:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266516AbSKLLDk>; Tue, 12 Nov 2002 06:03:40 -0500
Received: from 205-158-62-133.outblaze.com ([205.158.62.133]:30393 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266514AbSKLLDi>; Tue, 12 Nov 2002 06:03:38 -0500
Message-ID: <20021112111022.3501.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2002 19:10:22 +0800
Subject: [BENCHMARK] dbench based
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws5-3.us4.outblaze.com
X-Habeas-Swe-1: winter into spring
X-Habeas-Swe-2: brightly anticipated
X-Habeas-Swe-3: like Habeas SWE (tm)
X-Habeas-Swe-4: Copyright 2002 Habeas (tm)
X-Habeas-Swe-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-Swe-6: email in exchange for a license for this Habeas
X-Habeas-Swe-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-Swe-8: Message (HCM) and not spam. Please report use of this
X-Habeas-Swe-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran a dbech based script.
The "core" of the script is:
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

It runs dbench N 3 times and then it evaluates the average.


And here the results:
Kernel		N	Average		Baseline	Ratio
2.4.19		2	46.6689		46.6689		1.000
2.5.34		2	28.675		46.6689		0.614
2.5.41		2	31.0127		46.6689		0.665
2.5.42		2	29.8424		46.6689		0.639
2.5.44		2	66.2467		46.6689		1.420
2.5.45		2	44.8421		46.6689		0.961
2.5.46		2	50.5605		46.6689		1.083

2.4.19		8	25.5343		25.5343		1.000
2.5.34		8	26.7106		25.5343		1.046
2.5.41		8	32.0934		25.5343		1.257
2.5.42		8	33.2596		25.5343		1.303
2.5.44		8	32.0691		25.5343		1.256
2.5.45		8	30.7749		25.5343		1.205
2.5.46		8	32.2306		25.5343		1.262

2.4.19		16	20.7133		20.7133		1.000
2.5.34		16	21.0888		20.7133		1.018
2.5.41		16	29.3058		20.7133		1.415
2.5.42		16	27.0958		20.7133		1.308
2.5.44		16	28.6565		20.7133		1.383
2.5.45		16	26.6394		20.7133		1.286
2.5.46		16	27.0133		20.7133		1.304

2.4.19		24	16.2473		16.2473		1.000
2.5.34		24	13.9644		16.2473		0.859
2.5.41		24	20.291		16.2473		1.249
2.5.42		24	23.7237		16.2473		1.460
2.5.44		24	20.3913		16.2473		1.255
2.5.45		24	22.0835		16.2473		1.359
2.5.46		24	22.4922		16.2473		1.384

2.4.19		32	14.2351		14.2351		1.000
2.5.34		32	12.6921		14.2351		0.892
2.5.41		32	19.157		14.2351		1.346
2.5.42		32	20.4011		14.2351		1.433
2.5.44		32	17.6516		14.2351		1.240
2.5.45		32	17.3273		14.2351		1.217
2.5.46		32	21.5183		14.2351		1.512

I hope they are usefull for you.

Ciao,
          Paolo
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
