Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266965AbUBMQDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267047AbUBMQDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:03:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27809 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266965AbUBMQDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:03:53 -0500
Date: Fri, 13 Feb 2004 17:03:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Joe Thornber <thornber@redhat.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dm core patches
Message-ID: <20040213160346.GR26397@suse.de>
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti> <20040213151213.GR21298@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213151213.GR21298@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13 2004, Lars Marowsky-Bree wrote:
> > The other thing we need is to try and get the drivers to deferentiate
> > between a media error and a path error, so that media errors get
> > reported up quickly and don't cause false path failures.  This is
> > possibly an area that you could help with ?
> 
> I thought the IO stack in 2.6 provided us with such sense keys already,
> which you'd then need to handle in the DM personality. Of course,
> drivers need to make sure they pass up appropriate sense-keys, but
> that's a hardware vendor issue and not something which should delay the
> DM personality...
> 
> Jens, do you have the pointer on this handy?

The mechanism is in place, but the SCSI stack still needs a few changes
to pass down the correct errors. The easiest would be to pass down
pseudo-sense keys (I'd rather just call them something else as not to
confuse things, io error hints or something) to
end_that_request_first(), changing uptodate from a bool to a hint.

I can help get this done, it's not something that should hold up dm-mp
by any stretch.

-- 
Jens Axboe

