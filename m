Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVLMFXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVLMFXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVLMFXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:23:05 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:45577 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932463AbVLMFXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:23:05 -0500
Date: Tue, 13 Dec 2005 16:23:30 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: anticipatory scheduler and raid rebuild
Message-ID: <20051213052329.GM4212@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be able to play a bit more with this later but for now I thought
I'd toss it into the wilderness. 

I had jsut setup a nice little server with WD 10k drives and s/w raid 1.
The kernel is 2.6.14.3. The CPU is a p4 3Ghz and it's an Intel 82875P
chipset. In order to test that it'll build ok with missing disks I
pulled one out, booted, shutdown, put it back in and rebooted. I then
went on to try and get one of the raids to rebuild with:

mdadm --manage -a /dev/md6 /dev/sdb8

And then the server slowed to a crawl. Well not even that. It slowed to
the point of freezing and occasionally stuttering with activity other
then the rebuild. I got a similar reaction when it was rebuilding it.
Essentially, whilst the rebuild was in progress no disk io or even /sys
and /proc io could be done then a flurry of excitement and then back to
the freeze.

I then remembered that I could change schedulers on the disks and so did
the following (having read cfq is a nice choice):

echo cfq >/sys/block/sda/queue/scheduler
echo cfq >/sys/block/sdb/queue/scheduler

And the system became usable right after the commends were allowed to
pass through. Whilst the load (when I could get a reading) was 8+ before
it now hangs around 0.8-1 and the system is very responsive. The rebuild
speed is slower now; 25k vs 40-50k before.

So, does my hardware suck and AS is pushing it beyond its limits or is
AS unsuitable for the task I am putting it through or is AS buggy and
all should be well with it?

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
