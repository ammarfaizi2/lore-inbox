Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTLPTfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTLPTfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:35:17 -0500
Received: from fep02.swip.net ([130.244.199.130]:10914 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S262153AbTLPTfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:35:09 -0500
Message-ID: <3FDF5E6A.7010201@free.fr>
Date: Tue, 16 Dec 2003 20:35:06 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/partitions statistics question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to make sense of the units used in the 
/proc/partitions statistics.
I thought read and write I/O were in kilobytes, but not according to the 
following test on my 2.4.3 kernel machine:

# /proc/partitions columns:
# major minor #blocks name rio rmerge rsect ruse wio wmerge wsect wuse 
running use aveq

$ fgrep hdb1 /proc/partitions
$ dd if=/dev/zero of=ttt bs=1M count=1024 2>/dev/null
$ sync; sync; sync
$ fgrep hdb1 /proc/partitions
    3    65   40209088 hdb1 7107 18180 202278 384530 7925 19005 215616 
215330 0 46240 599860
    3    65   40209088 hdb1 7134 18218 202798 386510 24566 265384 
2319776 2977060 0 102000 3363570
$ ls -lk ttt
-rw-r--r--    1 root     root      1048576 Dec 13 15:56 ttt
$ fgrep hdb1 /proc/partitions
$ dd if=ttt of=/dev/null 2>/dev/null
$ sync; sync; sync
$ fgrep hdb1 /proc/partitions
    3    65   40209088 hdb1 7152 18222 202974 386650 24581 265397 
2320000 2977060 0 102140 3363710
    3    65   40209088 hdb1 23567 263977 2300334 555980 24668 265441 
2321048 2978280 0 171380 3534260

(24566 - 7925) = 16641 were written, whereas
(23567 - 7152) = 16415 were read
I would have expected something near 1048576 (kilobytes),
but the results seem to be roughly 64 times less...

I would really appreciate an explanation, as I use those statistics
in a monitoring program and for filesystems performance tests.

Many thanks for your help!

-- 
Jean-Luc Fontaine  mailto:jfontain@free.fr  http://jfontain.free.fr/
