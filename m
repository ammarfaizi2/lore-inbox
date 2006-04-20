Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWDTMyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWDTMyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDTMyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:54:24 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:53952 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750883AbWDTMyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:54:23 -0400
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: erich <erich@areca.com.tw>, dax@gurulabs.com, billion.wu@areca.com.tw,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       Chris Caputo <ccaputo@alt.net>
In-Reply-To: <20060420082357.GU614@suse.de>
References: <004a01c65470$412daaa0$b100a8c0@erich2003>
	 <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de>
	 <002901c65e33$ceac9e00$b100a8c0@erich2003> <20060419104009.GB614@suse.de>
	 <003301c663b3$6bfcc020$b100a8c0@erich2003> <20060419131916.GH614@suse.de>
	 <001401c6641d$586bd950$b100a8c0@erich2003> <20060420064249.GO614@suse.de>
	 <001e01c66451$f9a470f0$b100a8c0@erich2003>  <20060420082357.GU614@suse.de>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 08:53:37 -0400
Message-Id: <1145537618.3446.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 10:23 +0200, Jens Axboe wrote:
> It was just a suggestion, the bug might very well be just the size of
> the transfer itself and nothing SG related. All I can say for sure is
> that I'd be very surprised if this fs corruption isn't due to the
> hardware mangling the data for large transfers.

It sounds like this to me as well.  The other problem might be some type
of segment boundary issue which are not uncommon on less capable DMA
engines.  Either way, there's no question that large transfers work on
other hardware (SGI and IBM have extensively tested raising the current
128SG entries limit just so they could squeeze megabytes of data per
single command), so as Jens says, this is some type of issue within the
Areca hardware which you need to understand before the driver can be
made safe.

James


