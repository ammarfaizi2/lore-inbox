Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317465AbSGJFlR>; Wed, 10 Jul 2002 01:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317474AbSGJFlQ>; Wed, 10 Jul 2002 01:41:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6051 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317465AbSGJFlP>;
	Wed, 10 Jul 2002 01:41:15 -0400
Date: Wed, 10 Jul 2002 07:43:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020710054356.GE3185@suse.de>
References: <20020709102249.GA20870@suse.de> <20020709200711.GA13401@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020709200711.GA13401@win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09 2002, Andries Brouwer wrote:
> On Tue, Jul 09, 2002 at 12:22:49PM +0200, Jens Axboe wrote:
> 
> > I've forward ported the 2.4 IDE core to 2.5.25.
> 
> Very good!
> 
> There are two kinds of objections.
> The minor one is political - you can imagine.

Naturally.

> The major one is technical. You did not port the 2.4 good PIO
> behaviour to 2.5. Bartlomiej already warned about this, so I
> need only confirm:
> 
> This afternoon I booted 2.5.25 with your patches and two more,
> one to prevent an oops when shutting down, the other to fix
> ethernet cards detection. Started torturing two disks on
> HPT366. After 3 minutes
> 
> 	hde: status error: status=0x50 { DriveReady SeekComplete }
> 	hde: no DRQ after issuing WRITE
> 
> and seven minutes later
> 
> 	hde: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
> 	hde: task_out_intr: error=0x04 { DriveStatusError }
> 
> Soon lots of processes were hanging in D. Reboot. e2fsck.

The above seems to be plain pio, you didn't use multi mode did you? I
think my current tree has the multi-page multi mode bio issue resolved,
however I'll test for some hours before sending out the next patch set.

> Then booted vanilla 2.4.17. Tortured disks in the same way.
> After several hours all is still perfect. I'll leave this
> for a night, but so far I have never seen these errors on 2.4
> and very often in recent 2.5.

Good to know.

Thanks for your report, it'll probably take a day or two before the
kinks of the 2.5 conversion have been ironed out and the ide core is as
stable as 2.4.

-- 
Jens Axboe

