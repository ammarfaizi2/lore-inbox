Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTI0VOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 17:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTI0VOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 17:14:48 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:61710 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id S262196AbTI0VOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 17:14:45 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: Odd floppy disk error
Date: Sun, 28 Sep 2003 00:13:04 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309280013.04028.rabbit80@mbnet.fi>
X-OriginalArrivalTime: 27 Sep 2003 21:14:44.0881 (UTC) FILETIME=[5FD4A810:01C3853C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I was testing old 1.44MB diskettes with badblocks, like "badblocks -sv 
/dev/fd0" and this one particular diskette passed the test twice.  I then 
decided to look into a text file that resided on the diskette.

The floppy drive started reading.  It seemed to take longer than expected, so 
I forgot it and went to do other things.  After some hours had passed, I 
wondered why the load on the machine was 100% in both CPUs all the time.

Running top told me that 
   7   5 -10      0     0    0    0   0  1 SW<  85.1  0.0  12:28 events/1
  218  25   0     38  2244 1388  856   0  0 R    60.0  0.1  35:54 klogd
  215  15   0     70  1420  588  832   0  0 R    36.2  0.0  26:33 syslogd

and I quickly figured out that my /var partition was full.  

Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda7               921748    921732        16 100% /var
	
Looking for explanations, the syslog was 

-rw-r-----    1 root     adm      212582400 Sep 27 22:44 syslog

and the contents of it were mostly

Sep 27 22:44:04 minjami kernel: end_request: I/O error, dev fd0, sector 1327
Sep 27 22:44:04 minjami kernel: Buffer I/O error on device fd0, logical block 
1327
Sep 27 22:44:04 minjami kernel: floppy0: disk absent or changed during 
operation

repeated for sectors from 1327 to 1334 in sequence, over and over again.

What puzzles me is, why is the message there 2050 times in one second?  That 
makes 6150 lines in one second.  It begins around line 850 000, and syslog is 
around 2 245 000 long.  Timespan of 3 minutes, 46 seconds.  Therefore it's 
6150 lines per second throughout.

You sure have made a fast floppy driver, congratulations.  But the actual 
point in writing this is that if there's anything unintentional in this 
behaviour, I just wanted to let you know.

"Linux minjami 2.6.0-test4-mm2 #1 SMP Thu Aug 28 15:08:11 EEST 2003 i686 
GNU/Linux" is a mixed Debian 3.0r1 stable/testing/unstable system.

/var/log/messages had only these two lines repeated (equal amount of times is 
my guess)

Sep 27 22:44:07 minjami kernel: end_request: I/O error, dev fd0, sector 1334
Sep 27 22:44:07 minjami kernel: floppy0: disk absent or changed during 
operation

and the contents of /var/log/kern.log were identical to the contents of 
/var/log/syslog between 22:40:14 and 22:44:07

For more information, mail me, since I'm not subscribed.

-Kimmo Sundqvist

While writing this I gently removed the floppy from the drive, but the busy 
light has been glowing for minutes after it now, and the load is still up.  
The system is 100% responsive though.

