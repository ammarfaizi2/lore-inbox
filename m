Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTEBQbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTEBQbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:31:52 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:51165 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S262984AbTEBQbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:31:49 -0400
Message-ID: <20030502164342.21909.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org
Date: Sat, 03 May 2003 00:43:42 +0800
Subject: [benchmark] dbench regression in 2.5.68
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I know that dbench is not good benchmark, but I noticed
a clear throughput regression in the last kernel.
FS is Reiserfs.
The "best" kernel version is 2.5.54 but a lot of
version are missing.

The results are extracted using a script that runs dbench N
three times and evalueates the average.
No reboot between each run, so the script perform something
like the following

dbench 2; dbench 2; dbench 2; parse the log
dbench 8; dbench 8; dbench 8; parse the log
dbench 16; dbench 16; dbench 16; parse the log
dbench 24; dbench 24; dbench 24; parse the log
dbench 32; dbench 32; dbench 32; parse the log

Following the results:

Kernel		N	Average		Baseline	Ratio
2.4.19		2	46.6689		46.6689		1.000
2.5.34		2	28.675		46.6689		0.614
2.5.41		2	31.0127		46.6689		0.665
2.5.42		2	29.8424		46.6689		0.639
2.5.44		2	66.2467		46.6689		1.420
2.5.45		2	44.8421		46.6689		0.961
2.5.46		2	50.5605		46.6689		1.083
2.5.53		2	50.4847		46.6689		1.082
2.5.54bk4	2	46.7899		46.6689		1.003
2.5.59		2	49.3527		46.6689		1.058
2.5.61		2	47.9871		46.6689		1.028
2.5.62		2	62.2361		46.6689		1.334
2.5.63		2	61.2223		46.6689		1.312
2.5.63-mjb2	2	59.8553		46.6689		1.283
2.5.64		2	51.5036		46.6689		1.104
2.5.68		2	41.0586		46.6689		0.880

Kernel		N	Average		Baseline	Ratio
2.4.19		8	25.5343		25.5343		1.000
2.5.34		8	26.7106		25.5343		1.046
2.5.41		8	32.0934		25.5343		1.257
2.5.42		8	33.2596		25.5343		1.303
2.5.44		8	32.0691		25.5343		1.256
2.5.45		8	30.7749		25.5343		1.205
2.5.46		8	32.2306		25.5343		1.262
2.5.53		8	50.3427		25.5343		1.972
2.5.54bk4	8	49.8274		25.5343		1.951
2.5.59		8	47.5257		25.5343		1.861
2.5.61		8	44.9921		25.5343		1.762
2.5.62		8	37.5537		25.5343		1.471
2.5.63		8	42.0958		25.5343		1.649
2.5.63-mjb2	8	44.3926		25.5343		1.739
2.5.64		8	42.5724		25.5343		1.667
2.5.68		8	35.5809		25.5343		1.393

Kernel		N	Average		Baseline	Ratio
2.4.19		16	20.7133		20.7133		1.000
2.5.34		16	21.0888		20.7133		1.018
2.5.41		16	29.3058		20.7133		1.415
2.5.42		16	27.0958		20.7133		1.308
2.5.44		16	28.6565		20.7133		1.383
2.5.45		16	26.6394		20.7133		1.286
2.5.46		16	27.0133		20.7133		1.304
2.5.53		16	36.5902		20.7133		1.767
2.5.54bk4	16	41.2771		20.7133		1.993
2.5.59		16	39.307		20.7133		1.898
2.5.61		16	32.549		20.7133		1.571
2.5.62		16	30.384		20.7133		1.467
2.5.63		16	30.3052		20.7133		1.463
2.5.63-mjb2	16	32.0374		20.7133		1.547
2.5.64		16	36.3572		20.7133		1.755
2.5.68		16	27.416		20.7133		1.324

Kernel		N	Average		Baseline	Ratio
2.4.19		24	16.2473		16.2473		1.000
2.5.34		24	13.9644		16.2473		0.859
2.5.41		24	20.291		16.2473		1.249
2.5.42		24	23.7237		16.2473		1.460
2.5.44		24	20.3913		16.2473		1.255
2.5.45		24	22.0835		16.2473		1.359
2.5.46		24	22.4922		16.2473		1.384
2.5.53		24	40.0419		16.2473		2.465
2.5.54bk4	24	41.6313		16.2473		2.562
2.5.59		24	41.0944		16.2473		2.529
2.5.61		24	27.1713		16.2473		1.672
2.5.62		24	22.9646		16.2473		1.413
2.5.63		24	24.9342		16.2473		1.535
2.5.63-mjb2	24	26.5789		16.2473		1.636
2.5.64		24	25.983		16.2473		1.599
2.5.68		24	18.4423		16.2473		1.135

Kernel		N	Average		Baseline	Ratio
2.4.19		32	14.2351		14.2351		1.000
2.5.34		32	12.6921		14.2351		0.892
2.5.41		32	19.157		14.2351		1.346
2.5.42		32	20.4011		14.2351		1.433
2.5.44		32	17.6516		14.2351		1.240
2.5.45		32	17.3273		14.2351		1.217
2.5.46		32	21.5183		14.2351		1.512
2.5.53		32	35.5747		14.2351		2.499
2.5.54bk4	32	39.2595		14.2351		2.758
2.5.59		32	35.264		14.2351		2.477
2.5.61		32	24.1933		14.2351		1.700
2.5.62		32	20.2702		14.2351		1.424
2.5.63		32	19.6176		14.2351		1.378
2.5.63-mjb2	32	23.7801		14.2351		1.671
2.5.64		32	21.5357		14.2351		1.513
2.5.68		32	14.2182		14.2351		0.999

Hope it helps.

Ciao,
         Paolo
         
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
