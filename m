Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbTKNSvg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbTKNSvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:51:36 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:42961 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S264571AbTKNSvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:51:22 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 13:51:18 -0500
User-Agent: KMail/1.5.1
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
References: <20031114113224.GR21265@home.bofhlet.net> <200311140945.36537.gene.heskett@verizon.net> <87u156rghz.fsf@devron.myhome.or.jp>
In-Reply-To: <87u156rghz.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141351.18944.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.12.17] at Fri, 14 Nov 2003 12:51:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 12:45, OGAWA Hirofumi wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> On Friday 14 November 2003 08:46, Patrick Beard wrote:
>> >>> FAT: Bogus number of reserved sectors
>> >>> VFS: Can't find a valid FAT filesystem on dev sda
>>
>> Nov 14 09:20:34 coyote kernel: FAT: Filesystem panic (dev sda1)
>> Nov 14 09:20:34 coyote kernel:     fat_free: deleting beyond EOF
>> (i_pos 0) Nov 14 09:20:34 coyote kernel:     File system has been
>> set read-only
>
>Is this reproduced easy?  Looks like reading the zeroed block.
>In order to know details, could you try to read the data without
> mount?
>
>For example, what happen by the following repetitions?
>
>	dd if=/dev/sda | md5sum
>	unload driver(reset device) or unplug device

dd if=/dev/sda1|md5sum <--note use of the same device as to read pix.
has been running for 3 or so minutes now, steadily reading the camera.  
I shoulda put a time in front of it!  Ok got it, heres the sum:
127945+0 records in
127945+0 records out
f6c568dd1f35bb37f3d667a2ab228e2f

its a 64 meg card.  I'll have to unplug the camera (and cycle its 
power too) as all this is compiled into the kernel.
Ok, repeat run, with time this time:
Mmm, didn't get the md5sum, just the time, which was 
real    2m39.807s
user    0m1.052s
sys     0m1.984s
So I'll do another run, without the reset and without the time:
[root@coyote root]# dd if=/dev/sda1 | md5sum
127945+0 records in
127945+0 records out
f6c568dd1f35bb37f3d667a2ab228e2f

so the sums are the same, one more repeat, this time from powerdown 
reset and unplugged.
Purrfect repeat of the above.  Now lets see if /dev/sda will read 
it...  Yes it does.  Am I to understand that the non-numbered version 
of the device is the raw read from LSN0 of the device?
Ahh, that of course gets a different sum, and number of records read:
This is without the reset:
[root@coyote root]# dd if=/dev/sda | md5sum
128000+0 records in
128000+0 records out
b074ba314ac23f234b6d27da78e1e093

reset and restart, replug etc and again:
[root@coyote root]# dd if=/dev/sda | md5sum
128000+0 records in
128000+0 records out
b074ba314ac23f234b6d27da78e1e093

Looks like another flawless repeat here, and I'm probably making a 
serious dent in the batteries by now, that thing is positively 
ravenous when it comes to eating batteries.

What does this tell us?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

