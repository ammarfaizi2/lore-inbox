Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUAGXlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUAGXlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:41:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41484 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263593AbUAGXkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:40:51 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Date: 7 Jan 2004 23:28:44 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bti4nc$7qj$1@gatekeeper.tmr.com>
References: <20031228213535.GA21459@mail-infomine.ucr.edu> <Pine.LNX.4.44.0312281516060.21070-100000@twin.uoregon.edu>
X-Trace: gatekeeper.tmr.com 1073518124 8019 192.168.12.62 (7 Jan 2004 23:28:44 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0312281516060.21070-100000@twin.uoregon.edu>,
Joel Jaeggli  <joelja@darkwing.uoregon.edu> wrote:

| on the low-end promise controllers (ie everything but the sx4000 and
| sx6000) it's not hardware raid, it's the driver doing raid in this case
| the promise fastrack driver. among other things their driver doesn't do
| raid 5, just 0 1 or 0+1. so software raid does raid 5 and more.
| 
| to quote the config_blk_dev_ataraid:
| 
|  CONFIG_BLK_DEV_ATARAID:                                                 
| âSay Y or M if you have an IDE Raid controller and want linux            
| âto use its softwareraid feature.  You must also select an               
|  appropriate for your board low-level driver below.                      
| 
| âNote, that Linux does not use the Raid implementation in BIOS, and      
| âthe main purpose for this feature is to retain compatibility and        
| âdata integrity with other OS-es, using the same disk array. Linux       
| âhas its own Raid drivers, which you should use if you need better       
| âperformance.          
| 
| I've also had two if the higher-end promise sx6000's and the suffering I 
| incurred making them work with the i2o drivers particularly when promise 
| revised the bioses on those cards means I can't recomend them for much.
|  
| > raid instead, what would be the CPU overhead?
| 
| The linux software raid layer is actually faster under most circumstances
| the hardware raid controllers, doing raid5. but since the promise can't
| actually do that (raid 5) anyway it's hard to compare them directly. the
| 3ware cards in my experience result in lower cpu utilization for i/o but
| there hardware tops out at 80-145MB/s depending on model and we have
| software raid subsystems that go faster than that at the expense of some 
| of the rather bountiful cpu we have in those boxes.

The problem with the Linux software RAID is that's in the kernel. So if
the boot disk dies you don't get to boot and use the kernel. With the
controller RAID you do use the the RAID-1 copy, and boot, and sometimes
that's the feature which counts more than all the rest.

Now if you run LinuxBIOS you CAN do this all yourself, but unless you do
there are still some reliability issues.

Also note that if you do mirroring you use twice as much disk buffer
space to queue two writes, which could impact the performance in a low
memory system. That's theory, I haven't benchmarked.

Promise used to make a little adaptor which did RAID-1 on two drives and
made them look like one. This was not at the controller as I recall, but
in the cable, where the data was split. That would give boot reliability
without losing a device pair, but I have no idea how well it worked
other than in a demonstration.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
