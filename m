Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271239AbRHOPkH>; Wed, 15 Aug 2001 11:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271236AbRHOPj6>; Wed, 15 Aug 2001 11:39:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40466 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271232AbRHOPjj>; Wed, 15 Aug 2001 11:39:39 -0400
Date: Wed, 15 Aug 2001 11:10:48 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Comparison between 2.4.8-ac4-new-zoned and 2.4.9pre3 VM perf 
Message-ID: <Pine.LNX.4.21.0108150723000.26179-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I've compared 2.4.8-ac4 performance with 2.4.9pre3 using postmark. I used
this specific benchmark because it allows me to set read/write ratio of IO
transactions.

Note: I've not used stock 2.4.8-ac4. Its a modified version of it which
updates the zoned approach code (btw, I'm going to send those changes to
Alan soon for inclusion).

The tests have shown that the 2.4.9pre is a bit slower than
2.4.8ac4+newzone.

Configuration:
8way machine limited to 512MB RAM
The base number of files is 500
Transactions: 9000
Files are 5.00 megabytes in size
Block sizes are: read=512 bytes, write=512 bytes

2.4.8-ac4-newzoned

bias read 10 (approx 10/1 read/write ratio)

Time:
        2265 seconds total
        2216 seconds of transactions (4 per second)

Files:
        5046 created (2 per second)
                Creation alone: 500 files (10 per second)
                Mixed with transactions: 4546 files (2 per second)
        9000 read (4 per second)
        0 appended (0 per second)
        5046 deleted (2 per second)
                Deletion alone: 592 files (592 per second)
                Mixed with transactions: 4454 files (2 per second)

Data:
        45000.00 megabytes read (19.87 megabytes per second)
        25230.00 megabytes written (11.14 megabytes per second)

bias read 1 (approx 1/10 read/write ratio)

Time:
        649 seconds total
        601 seconds of transactions (14 per second)

Files:
        5046 created (7 per second)
                Creation alone: 500 files (10 per second)
                Mixed with transactions: 4546 files (7 per second)
        876 read (1 per second)
        0 appended (0 per second)
        5046 deleted (7 per second)
                Deletion alone: 592 files (592 per second)
                Mixed with transactions: 4454 files (7 per second)
Data:
        4380.00 megabytes read (6.75 megabytes per second)
        25230.00 megabytes written (38.88 megabytes per second)

2.9.4-pre3

bias read 10

Time:
        2264 seconds total
        2214 seconds of transactions (4 per second)

Files:
        5046 created (2 per second)
                Creation alone: 500 files (10 per second)
                Mixed with transactions: 4546 files (2 per second)
        9000 read (4 per second)
        0 appended (0 per second)
        5046 deleted (2 per second)
                Deletion alone: 592 files (296 per second)
                Mixed with transactions: 4454 files (2 per second)

Data:
        45000.00 megabytes read (19.88 megabytes per second)
        25230.00 megabytes written (11.14 megabytes per second)


bias read 1

Time:
        690 seconds total
        643 seconds of transactions (13 per second)
block
    703 seconds total
        656 seconds of transactions (13 per second)



Files:
        5046 created (7 per second)
                Creation alone: 500 files (10 per second)
                Mixed with transactions: 4546 files (7 per second)
        876 read (1 per second)
        0 appended (0 per second)
        5046 deleted (7 per second)
                Deletion alone: 592 files (592 per second)
                Mixed with transactions: 4454 files (6 per second)

Data:
        4380.00 megabytes read (6.35 megabytes per second)
        25230.00 megabytes written (36.57 megabytes per second)







