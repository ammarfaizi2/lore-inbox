Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWDYQAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWDYQAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWDYQAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:00:30 -0400
Received: from xenotime.net ([66.160.160.81]:44424 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932139AbWDYQA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:00:29 -0400
Date: Tue, 25 Apr 2006 09:02:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "erich" <erich@areca.com.tw>
Cc: dax@gurulabs.com, billion.wu@areca.com.tw, viro@ftp.linux.org.uk,
       akpm@osdl.org, matti.aarnio@zmailer.org, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, ccaputo@alt.net
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Message-Id: <20060425090248.96add14d.rdunlap@xenotime.net>
In-Reply-To: <01fe01c66844$96c16780$b100a8c0@erich2003>
References: <007701c653d7$8b8ee670$b100a8c0@erich2003>
	<Pine.LNX.4.64.0603301542590.19680@nacho.alt.net>
	<004a01c65470$412daaa0$b100a8c0@erich2003>
	<20060330192057.4bd8c568.akpm@osdl.org>
	<20060331074237.GH14022@suse.de>
	<002901c65e33$ceac9e00$b100a8c0@erich2003>
	<20060419104009.GB614@suse.de>
	<003301c663b3$6bfcc020$b100a8c0@erich2003>
	<20060419131916.GH614@suse.de>
	<001401c6641d$586bd950$b100a8c0@erich2003>
	<20060420064249.GO614@suse.de>
	<001e01c66451$f9a470f0$b100a8c0@erich2003>
	<20060420083812.d47a74bb.rdunlap@xenotime.net>
	<01fe01c66844$96c16780$b100a8c0@erich2003>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 16:45:18 +0800 erich wrote:

> Dear Randy.Dunlap,
> 
> If it is true, I will add sg count check in arcmsr.
> Driver report : host->sg_tablesize=ARCMSR_MAX_SG_ENTRIES to linux scsi host 
> layer.
> But got an incorrect request of sg list count from .queuecommand.
> Could you tell me which value of ARCMSR_MAX_XFER_SECTORS (4096/512)?

Hi Erich,
I didn't see 70 sg pieces while using the arcmsr driver, it was
while testing another driver.  Sorry if that wasn't clear.

Driver setting host->sg_tablesize should be good enough according
to Documentation/scsi/scsi_mid_low_api.txt .  Are you seeing problems
with that?  and I don't understand your last question about
ARCMSR_MAX_XFER_SECTORS.


> Best Regards
> Erich chen
> 
> ----- Original Message ----- 
> From: "Randy.Dunlap" <rdunlap@xenotime.net>
> To: "erich" <erich@areca.com.tw>
> Cc: <axboe@suse.de>; <dax@gurulabs.com>; <billion.wu@areca.com.tw>; 
> <viro@ftp.linux.org.uk>; <akpm@osdl.org>; <matti.aarnio@zmailer.org>; 
> <linux-kernel@vger.kernel.org>; <James.Bottomley@steeleye.com>; 
> <ccaputo@alt.net>
> Sent: Thursday, April 20, 2006 11:38 PM
> Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
> 
> 
> > On Thu, 20 Apr 2006 16:11:04 +0800 erich wrote:
> >
> >> Dear Dear Jens Axboe,
> >>
> >> Thanks for your notification and advice.
> >> Areca's firmware has max sg entries of 38 limit.
> >> In my debug driver I had add this condition check.
> >> But no one request more than 38 sg.
> >
> > Yesterday I saw a request with 70 sg pieces.  It was while
> > running mkfs.ext3 .
> >
> >> Both transfer length all have a lot of requests equal with 38 sg.
> >> But why it ocur only at 4096 sectors?
> >> If the /sys/block/sda/queue/max_sectors_kb equal 256 all operation 
> >> running
> >> well.
> >> But if I modify it more than 256, the bug appeared.
> >> I  will do more research about why there were a lot of requests equal 
> >> with
> >> 38 sg in all file system.
> >> And only it ocur at the volume that format with mkfs.ext2.
> >> Thanks again.
> >>
> >> Best Regards
> >> Erich Chen
> >>
> >> ----- Original Message ----- 
> >> From: "Jens Axboe" <axboe@suse.de>
> >> To: "erich" <erich@areca.com.tw>
> >> Cc: <dax@gurulabs.com>; <billion.wu@areca.com.tw>; "Al Viro"
> >> <viro@ftp.linux.org.uk>; "Andrew Morton" <akpm@osdl.org>; "Randy.Dunlap"
> >> <rdunlap@xenotime.net>; "Matti Aarnio" <matti.aarnio@zmailer.org>;
> >> <linux-kernel@vger.kernel.org>; "James Bottomley"
> >> <James.Bottomley@steeleye.com>; "Chris Caputo" <ccaputo@alt.net>
> >> Sent: Thursday, April 20, 2006 2:42 PM
> >> Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
> >>
> >>
> >> > On Thu, Apr 20 2006, erich wrote:
> >> >> Dear Jens Axboe,
> >> >>
> >> >> I  do "fsck -fy /dev/sda1" on driver MAX_XFER_SECTORS 512.
> >> >> The file system was not clean.
> >> >> I attach mesg.txt for you refer to.
> >> >>
> >> >> =====================================
> >> >> == boot with driver MAX_XFER_SECTORS 4096
> >> >> =====================================
> >> >> #mkfs.ext2 /dev/sda1
> >> >> #reboot
> >> >> =====================================
> >> >> == boot with driver MAX_XFER_SECTORS 512
> >> >> =====================================
> >> >> #fsck -fy /dev/sda1
> >> >> /dev/sda1:clean,.............
> >> >> #reboot
> >> >> =====================================
> >> >> == boot with driver MAX_XFER_SECTORS 4096
> >> >> =====================================
> >> >> #mount /dev/sda1 /mnt/sda1
> >> >> #cp /root/aa /mnt/sda1
> >> >> #reboot
> >> >> =====================================
> >> >> == boot with driver MAX_XFER_SECTORS 512
> >> >> =====================================
> >> >> #fsck -fy /dev/sda1
> >> >> /dev/sda1: no clean,........and dump message such as the attach file
> >> >> mesg.txt.
> >> >
> >> > So the conclusion is that your driver and/or hardware corrupts data 
> >> > when
> >> > you set MAX_XFER_SECTORS too high. I can't help you anymore with this,
> >> > you should be in the best position to debug the driver and/or hardware
> >> > :-)
> >> >
> >> > It could be that the higher setting just exposes another transfer
> >> > setting bug, like maximum number of segments or segment size, etc.
> >> >
> >> > -- 
> >> > Jens Axboe
> >> >
> >>
> >>
> >
> >
> > ---
> > ~Randy 
> 
> 


---
~Randy
