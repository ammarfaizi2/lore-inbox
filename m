Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269711AbTGOVfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269716AbTGOVfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:35:08 -0400
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:28940 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S269711AbTGOVfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:35:01 -0400
Date: Tue, 15 Jul 2003 16:49:50 -0500 (CDT)
From: derek@signalmarketing.com
X-X-Sender: manmower@uberdeity.signalmarketing.com
To: linux-kernel@vger.kernel.org
Subject: IDE performance problems on 2.6.0-pre1
Message-ID: <Pine.LNX.4.56.0307151617430.2932@uberdeity.signalmarketing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My ide performance seems to have dropped noticably from 2.4.x to 
2.6.0-pre1...

the controller is an hpt-366, there's only one drive connected to it.  
It's on an 80 pin cable, and the cable is plugged in the right way.

hdparm reports that the drive is using udma4 (it's udma5 capable, the 
controller is not)

from 2.4.x, hdparm -t
 Timing buffered disk reads:  140 MB in  3.02 seconds =  46.36 MB/sec

and vmstat 1 while it's running shows
 0  0      0 349064   1964   9784    0    0     0     0  101     4  0  0 100  0
 1  0      0 335360   1964  23480    0    0 11648     0  282   356  0  9 90  0
 1  0      0 286976   1964  71864    0    0 48384     0  863  1469  1 38 61  0
 1  0      0 239360   1964 119480    0    0 47616     0  844  1451  1 33 65  0
 0  0      0 349108   1964   9784    0    0 35840     0  664  1095  0 31 69  0

also,

time dd if=/dev/hde1 of=/dev/null bs=4096
768088+0 records in
768088+0 records out

real    1m6.079s
user    0m0.850s
sys     0m16.720s


under 2.6.0-pre1, I get

 Timing buffered disk reads:   88 MB in  3.02 seconds =  29.14 MB/sec

vmstat says
 0  0      0 334748   2172  10816    0    0     0     0 1002     4  0  0 100  0
 1  1      0 329180   5636  12860    0    0  3464     0 1031    64  0  2 93  4
 1  0      0 298140  35692  12860    0    0 30080     0 1244   483  1 20 50 30
 1  0      0 266972  65924  12888    0    0 30208     0 1239   480  0 19 50 30
 1  0      0 334108   2172  10884    0    0 26496     0 1253   426  0 26 48 26
 0  0      0 334180   2172  10884    0    0     0     0 1010    18  0  0 100  0

(this is a dual processor machine, so this looks to me like I'm cpu bound 
where I wasn't before?)

time dd if=/dev/hde1 of=/dev/null bs=4096
dd: reading `/dev/hde1': Input/output error
768088+0 records in
768088+0 records out

real    1m33.977s
user    0m0.967s
sys     0m26.695s

the input/output error is new too...

I also tried with everything in the Kernel Hacking sub-menu disabled, and 
got results from hdparm as high as 31.53MB/sec

Any idea what's wrong?
