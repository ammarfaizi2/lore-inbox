Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbTBWQjb>; Sun, 23 Feb 2003 11:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268515AbTBWQjb>; Sun, 23 Feb 2003 11:39:31 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:42128 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S268514AbTBWQj2>; Sun, 23 Feb 2003 11:39:28 -0500
Message-ID: <20030223164924.16952.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, andrea@suse.de, axboe@suse.de
Date: Mon, 24 Feb 2003 00:49:24 +0800
Subject: as vs cfq vs deadline
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've run a 'let's check if it does not skip frames test'.
kernel is 2.5.62-mm2.

** How I performed the test **
startx
I've opened to xterminal

terminal1
[test@frodo test]$ glxgears

terminal2
./dbench 16

Following the results:

** booted with scheduler=as ** 
Throughput 19.8092 MB/sec (NB=24.7615 MB/sec  198.092 MBit/sec)  16 procs

[test@frodo test]$ glxgears
609 frames in 5.0 seconds = 121.800 FPS
673 frames in 5.0 seconds = 134.600 FPS
676 frames in 5.0 seconds = 135.200 FPS
591 frames in 5.0 seconds = 118.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
592 frames in 5.0 seconds = 118.400 FPS
-- Here dbench starts --
591 frames in 7.0 seconds = 84.429 FPS
423 frames in 5.0 seconds = 84.600 FPS
422 frames in 5.0 seconds = 84.400 FPS
507 frames in 5.0 seconds = 101.400 FPS
602 frames in 5.0 seconds = 120.400 FPS
676 frames in 5.0 seconds = 135.200 FPS
591 frames in 5.0 seconds = 118.200 FPS
592 frames in 5.0 seconds = 118.400 FPS
422 frames in 9.0 seconds = 46.889 FPS
423 frames in 5.0 seconds = 84.600 FPS
507 frames in 5.0 seconds = 101.400 FPS
507 frames in 5.0 seconds = 101.400 FPS
507 frames in 5.0 seconds = 101.400 FPS
422 frames in 5.0 seconds = 84.400 FPS
338 frames in 5.0 seconds = 67.600 FPS
254 frames in 7.0 seconds = 36.286 FPS
338 frames in 8.0 seconds = 42.250 FPS
507 frames in 10.0 seconds = 50.700 FPS
84 frames in 5.0 seconds = 16.800 FPS
-- dbench stops here --
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
X connection to :0.0 broken (explicit kill or server shutdown).



** booted with scheduler=cfq **
Throughput 24.3661 MB/sec (NB=30.4577 MB/sec  243.661 MBit/sec)  16 procs

[test@frodo test]$ glxgears
689 frames in 5.0 seconds = 137.800 FPS
675 frames in 5.0 seconds = 135.000 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
591 frames in 5.0 seconds = 118.200 FPS
-- dbench starts here --
507 frames in 5.0 seconds = 101.400 FPS
338 frames in 5.0 seconds = 67.600 FPS
507 frames in 5.0 seconds = 101.400 FPS
616 frames in 5.0 seconds = 123.200 FPS
507 frames in 5.0 seconds = 101.400 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
591 frames in 5.0 seconds = 118.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
423 frames in 6.0 seconds = 70.500 FPS
338 frames in 8.0 seconds = 42.250 FPS
422 frames in 5.0 seconds = 84.400 FPS
169 frames in 7.0 seconds = 24.143 FPS
507 frames in 16.0 seconds = 31.688 FPS
338 frames in 5.0 seconds = 67.600 FPS
-- dbench stops here --
676 frames in 5.0 seconds = 135.200 FPS
592 frames in 5.0 seconds = 118.400 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
X connection to :0.0 broken (explicit kill or server shutdown). 


** booted with scheduler=deadline **
Throughput 28.7021 MB/sec (NB=35.8776 MB/sec  287.021 MBit/sec)  16 procs

[test@frodo test]$ glxgears
687 frames in 5.0 seconds = 137.400 FPS
589 frames in 5.0 seconds = 117.800 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
-- dbench starts here --
423 frames in 5.0 seconds = 84.600 FPS
591 frames in 5.0 seconds = 118.200 FPS
676 frames in 5.0 seconds = 135.200 FPS
338 frames in 5.0 seconds = 67.600 FPS
507 frames in 5.0 seconds = 101.400 FPS
676 frames in 5.0 seconds = 135.200 FPS
592 frames in 5.0 seconds = 118.400 FPS
338 frames in 5.0 seconds = 67.600 FPS
253 frames in 9.0 seconds = 28.111 FPS
169 frames in 7.0 seconds = 24.143 FPS
507 frames in 15.0 seconds = 33.800 FPS
169 frames in 5.0 seconds = 33.800 FPS
-- dbench stops here --
676 frames in 5.0 seconds = 135.200 FPS
676 frames in 5.0 seconds = 135.200 FPS

I can not see any difference in the results above.

I guess the test I've run it is not a good test, isn't it ?

Comments/suggesiontions ?

Ciao,
		Paolo
		
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
