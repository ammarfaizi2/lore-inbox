Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWDTIXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWDTIXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 04:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDTIXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 04:23:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:824 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750774AbWDTIXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 04:23:35 -0400
Date: Thu, 20 Apr 2006 10:23:58 +0200
From: Jens Axboe <axboe@suse.de>
To: erich <erich@areca.com.tw>
Cc: dax@gurulabs.com, billion.wu@areca.com.tw, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Chris Caputo <ccaputo@alt.net>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Message-ID: <20060420082357.GU614@suse.de>
References: <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de> <002901c65e33$ceac9e00$b100a8c0@erich2003> <20060419104009.GB614@suse.de> <003301c663b3$6bfcc020$b100a8c0@erich2003> <20060419131916.GH614@suse.de> <001401c6641d$586bd950$b100a8c0@erich2003> <20060420064249.GO614@suse.de> <001e01c66451$f9a470f0$b100a8c0@erich2003>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001e01c66451$f9a470f0$b100a8c0@erich2003>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't top post!)

On Thu, Apr 20 2006, erich wrote:
> Dear Dear Jens Axboe,
> 
> Thanks for your notification and advice.
> Areca's firmware has max sg entries of 38 limit.
> In my debug driver I had add this condition check.
> But no one request more than 38 sg.
> Both transfer length all have a lot of requests equal with 38 sg.
> But why it ocur only at 4096 sectors?
> If the /sys/block/sda/queue/max_sectors_kb equal 256 all operation running 
> well.
> But if I modify it more than 256, the bug appeared.
> I  will do more research about why there were a lot of requests equal with 
> 38 sg in all file system.

It was just a suggestion, the bug might very well be just the size of
the transfer itself and nothing SG related. All I can say for sure is
that I'd be very surprised if this fs corruption isn't due to the
hardware mangling the data for large transfers.

> And only it ocur at the volume that format with mkfs.ext2.

Most likely a coincidence, try running eg dbench or other stress tests
on the fs with larger xfer size and I'm sure it'll corrupt eventually as
well.


-- 
Jens Axboe

