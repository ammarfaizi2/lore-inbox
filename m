Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRAMStu>; Sat, 13 Jan 2001 13:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130229AbRAMStk>; Sat, 13 Jan 2001 13:49:40 -0500
Received: from gear.torque.net ([204.138.244.1]:43026 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129735AbRAMSta>;
	Sat, 13 Jan 2001 13:49:30 -0500
Message-ID: <3A609F8C.DD30BBCF@torque.net>
Date: Sat, 13 Jan 2001 13:33:48 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Meino Christian Cramer <mccramer@s.netic.de>
Subject: Re: 2.4.0: Raw devices ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meino Cramer wrote:
> short question: How cabn I activate/where can I find the raw devices
> often described as /dev/raw[12]* in/with kernel linux-2.4.0.

There doesn't seem to be any config option for raw
devices in lk 2.4.0 , they are just there. However
the raw (8) utility expects them in a different place
from where Documentation/devices.txt currently says 
they are. You may have to set up these char devices:

$ ls -l /dev/rawctl 
crw-r--r--    1 root     root     162,   0 Jan 13 05:12 /dev/rawctl

$ ls -l /dev/raw/*  
crw-r--r--    1 root     root     162,   1 Jan 13 05:12 /dev/raw/raw1
crw-r--r--    1 root     root     162,   2 Jan 13 05:12 /dev/raw/raw2
crw-r--r--    1 root     root     162,   3 Jan 13 05:12 /dev/raw/raw3
crw-r--r--    1 root     root     162,   4 Jan 13 05:12 /dev/raw/raw4
etc.

Recent versions of dd meet the alignment requirements
of raw devices as does lmdd (from the lmbench package).
I have done some timings of disk to disk copies using
raw devices compared to other devices. See:
http://www.torque.net/sg/fst_copy.html

> And where can I find the "raw" utility...

In both RH 6.2 and 7.0 the raw (8) utility is in the 
util-linux package (RH have applied a "raw" patch for 
those two lk 2.2 versions). Read man (8) raw to find 
out how to bind a raw device to an existing block device.
Example:
$ raw /dev/raw/raw1 /dev/sda3

Doug Gilbert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
