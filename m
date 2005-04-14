Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVDNQXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVDNQXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 12:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVDNQXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 12:23:54 -0400
Received: from smtp2.netcologne.de ([194.8.194.218]:33253 "EHLO
	smtp2.netcologne.de") by vger.kernel.org with ESMTP id S261537AbVDNQXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 12:23:37 -0400
Message-ID: <425E9902.8000804@interia.pl>
Date: Thu, 14 Apr 2005 18:23:30 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Silicon Image SIL3112A SATA PCI controller + 2x 200GB, 8MB
Barracuda drives.

The performance under 2.6 kernels is *very* poor (Timing buffered disk
reads never more than 20 MB/sec); under 2.4 it runs quite fine (Timing
buffered disk reads around 60 MB/sec).



Below three hdparm reads on three different liveCDs (kernels 2.6.11.6,
2.4.28, 2.6.11).


Kernel 2.6.11.6, Slax 5.0.1

root@slax:~# hdparm -Tt /dev/sda /dev/sdb

/dev/sda:
  Timing cached reads:   1124 MB in  2.00 seconds = 560.68 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
  Timing buffered disk reads:   60 MB in  3.10 seconds =  19.38 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device

/dev/sdb:
  Timing cached reads:   1128 MB in  2.00 seconds = 563.80 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
  Timing buffered disk reads:   60 MB in  3.09 seconds =  19.39 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device


Kernel 2.4.28, Slax 4.1.4

root@slax:~# hdparm -Tt /dev/sda /dev/sdb

/dev/sda:
  Timing buffer-cache reads:   1152 MB in  2.00 seconds = 576.00 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Operation not
supported
  Timing buffered disk reads:  180 MB in  3.01 seconds =  59.80 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Operation not
supported

/dev/sdb:
  Timing buffer-cache reads:   1124 MB in  2.00 seconds = 562.00 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Operation not
supported
  Timing buffered disk reads:  180 MB in  3.07 seconds =  58.63 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Operation not
supported


Kernel 2.6.11, Knoppix 3.8.1:

# hdparm -Tt /dev/sda /dev/sdb

/dev/sda:
  Timing cached reads:   1188 MB in  2.00 seconds = 592.61 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
  Timing buffered disk reads:   50 MB in  3.09 seconds =  16.19 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device

/dev/sdb:
  Timing cached reads:   1176 MB in  2.00 seconds = 586.92 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
  Timing buffered disk reads:   54 MB in  3.19 seconds =  16.94 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device



I tested it also with Mandrake 10.2 (it is shipped with 2.6.11 kernel): 
  Timing cached reads was about 100 MB/sec and Timing buffered disk 
reads was about 10 MB/sec.

Another test on Mandrake with 2.6.8.1 kernel - it's the fastest of all 
test:

# hdparm -Tt /dev/sda

/dev/sda:
  Timing cached reads:   1064 MB in  2.00 seconds = 531.81 MB/sec
BLKFLSBUF failed: Operation not supported
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Operation not 
supported
  Timing buffered disk reads:  310 MB in  3.02 seconds = 102.49 MB/sec


So on three distros with 2.6.11.x kernels (Knoppix, Slax, Mandrake), 
SATA performance was extremely bad for me.
Coincidence, or something SATA-related got borked in 2.6.11?


Tomek

