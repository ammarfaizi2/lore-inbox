Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSGUEeN>; Sun, 21 Jul 2002 00:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSGUEeN>; Sun, 21 Jul 2002 00:34:13 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:17827 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317636AbSGUEeL>; Sun, 21 Jul 2002 00:34:11 -0400
User-Agent: Pan/0.11.2 (Unix)
From: "David Caplan" <david@polycode.net>
To: linux-kernel@vger.kernel.org
Subject: Asus-a7v/Via-Vt8233 data corruption
Date: Sun, 21 Jul 2002 00:45:43 -0400
Message-Id: <20020721043653.NLID8251.tomts6-srv.bellnexxia.net@david>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is an email copy of a Usenet post to "linux.kernel"]

Hello,

I am having many problems with the asus a7v266 motherboard, and its IDE
controller. It seems to be corrupting data transfers to and from my
single 40 gb Quantum Fireball hd. 

I ran Robin Miller's Data Test Program (dt) from
http://www.bit-net.com/~rmiller/dt.html. It reported errors after a few
tests.

I had DMA enabled via hdparm,
I was running kernel 2.4.18.

These occurrences seem to be common with my chipset, or others by 
VIA.
I have been running the same motherboard for about 3/4 of a year, 
with none of these problems until last week, why would that be?

Is this a bug in the motherboard? or is it the way Linux handles it?

Anyways,here is the output of dt:

# ./dt of=../test limit=1g min=500k max=2000k procs=2 log=dtlog runtime=1h 

	--> Date: June 2nd, Version: 14.10, Author: Robin T. Miller <--

Write Statistics (260):
    Current Process Reported: 1/2
     Total records processed: 1280 with min=512000, max=2048000, incr=512
     Total bytes transferred: 1073741824 (1048576.000 Kbytes, 1024.000 Mbytes)
      Average transfer rates: 12420380 bytes/sec, 12129.277 Kbytes/sec
     Number I/O's per second: 14.806
      Total passes completed: 0
       Total errors detected: 0/1
          Total elapsed time: 01m26.45s
           Total system time: 00m05.95s
             Total user time: 00m08.59s

Write Statistics (261):
    Current Process Reported: 2/2
     Total records processed: 1280 with min=512000, max=2048000, incr=512
     Total bytes transferred: 1073741824 (1048576.000 Kbytes, 1024.000 Mbytes)
      Average transfer rates: 12423254 bytes/sec, 12132.084 Kbytes/sec
     Number I/O's per second: 14.810
      Total passes completed: 0
       Total errors detected: 0/1
          Total elapsed time: 01m26.43s
           Total system time: 00m06.71s
             Total user time: 00m08.73s

dt (261): Error number 1 occurred on Sat Jul 20 17:52:18 2002
dt (261): Data compare error at byte 237670 in record number 1
dt (261): Relative block number where the error occcured is 464 (offset 102)
dt (261): Data expected = 0xff, data found = 0, byte count = 512000
dt (261): The incorrect data starts at address 0x80bf962 (marked by asterisk '*')
dt (261): Dumping Pattern Buffer (base = 0x80bf960, offset = 2, limit = 4 bytes):

0x80bf960  ff 00*ff 00

dt (261): The incorrect data starts at address 0x4003c066 (marked by asterisk '*')
dt (261): Dumping Data Buffer (base = 0x40002000, offset = 237670, limit = 64 bytes):

0x4003c046  ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
0x4003c056  ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
0x4003c066 *00 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
0x4003c076  ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00

Read Statistics (261):
    Current Process Reported: 2/2
     Total records processed: 1 with min=512000, max=2048000, incr=512
     Total bytes transferred: 512000 (500.000 Kbytes, 0.488 Mbytes)
      Average transfer rates: 4266667 bytes/sec, 4166.667 Kbytes/sec
     Number I/O's per second: 8.333
      Total passes completed: 1
       Total errors detected: 1/1
          Total elapsed time: 00m00.12s
           Total system time: 00m00.00s
             Total user time: 00m00.01s

Total Statistics (261):
     Output device/file name: ../test-261 (device type=regular)
     Type of I/O's performed: sequential (forward)
    Current Process Reported: 2/2
   Data pattern read/written: 0x00ff00ff
     Total records processed: 1281 with min=512000, max=2048000, incr=512
     Total bytes transferred: 1074253824 (1049076.000 Kbytes, 1024.488 Mbytes)
      Average transfer rates: 12409077 bytes/sec, 12118.240 Kbytes/sec
     Number I/O's per second: 14.797
      Total passes completed: 1
       Total errors detected: 1/1
          Total elapsed time: 01m26.57s
           Total system time: 00m06.71s
             Total user time: 00m08.74s
               Starting time: Sat Jul 20 17:50:52 2002
                 Ending time: Sat Jul 20 17:52:18 2002


dt (260): Error number 1 occurred on Sat Jul 20 17:52:18 2002
dt (260): Data compare error at byte 12294 in record number 2
dt (260): Relative block number where the error occcured is 1024 (offset 6)
dt (260): Data expected = 0xc3, data found = 0xff, byte count = 512512
dt (260): The incorrect data starts at address 0x80bf962 (marked by asterisk '*')
dt (260): Dumping Pattern Buffer (base = 0x80bf960, offset = 2, limit = 4 bytes):

0x80bf960  39 9c*c3 39

dt (260): The incorrect data starts at address 0x40005006 (marked by asterisk '*')
dt (260): Dumping Data Buffer (base = 0x40002000, offset = 12294, limit = 64 bytes):

0x40004fe6  c3 39 39 9c c3 39 39 9c c3 39 39 9c c3 39 39 9c
0x40004ff6  c3 39 39 9c c3 39 39 9c c3 39 39 9c c3 39 39 9c
0x40005006 *ff 39 39 9c c3 39 39 9c c3 39 39 9c c3 39 39 9c
0x40005016  c3 39 39 9c c3 39 39 9c c3 39 39 9c c3 39 39 9c

Read Statistics (260):
    Current Process Reported: 1/2
     Total records processed: 2 with min=512000, max=2048000, incr=512
     Total bytes transferred: 1024512 (1000.500 Kbytes, 0.977 Mbytes)
      Average transfer rates: 5392168 bytes/sec, 5265.789 Kbytes/sec
     Number I/O's per second: 10.526
      Total passes completed: 1
       Total errors detected: 1/1
          Total elapsed time: 00m00.19s
           Total system time: 00m00.00s
             Total user time: 00m00.01s

Total Statistics (260):
     Output device/file name: ../test-260 (device type=regular)
     Type of I/O's performed: sequential (forward)
    Current Process Reported: 1/2
   Data pattern read/written: 0x39c39c39
     Total records processed: 1282 with min=512000, max=2048000, incr=512
     Total bytes transferred: 1074766336 (1049576.500 Kbytes, 1024.977 Mbytes)
      Average transfer rates: 12399242 bytes/sec, 12108.635 Kbytes/sec
     Number I/O's per second: 14.790
      Total passes completed: 1
       Total errors detected: 1/1
          Total elapsed time: 01m26.68s
           Total system time: 00m05.95s
             Total user time: 00m08.60s
               Starting time: Sat Jul 20 17:50:52 2002
                 Ending time: Sat Jul 20 17:52:18 2002



--END OF OUTPUT--

Sometimes, when I altered the run-time parameters I would get complete
kernel crashes, leaving a message similar to the following:
Assersion Failure in __journal_file_buffer() transaction.c:1937
..

I don't really know how one may be related to the other, as I did not log
the complete output of the crash...

Thanks for your help,
	-David
