Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423242AbWJYKlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423242AbWJYKlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423233AbWJYKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:41:07 -0400
Received: from brick.kernel.dk ([62.242.22.158]:6919 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1423229AbWJYKlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:41:04 -0400
Date: Wed, 25 Oct 2006 12:42:17 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061025104217.GB4281@kernel.dk>
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E9C18.70803@de.ibm.com> <20061025051238.GO4281@kernel.dk> <453F3D4E.4020608@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453F3D4E.4020608@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25 2006, Martin Peschke wrote:
> Jens Axboe wrote:
> >>>Thanks! Also note that you do not need to log every event, just register
> >>>a mask of interesting ones to decrease the output logging rate. We could
> >>>so with some better setup for that though, but at least you should be
> >>>able to filter out some unwanted events.
> >>...and consequently try to scale down relay buffers, reducing the risk of
> >>memory constraints caused by blktrace activation.
> >
> >Pretty pointless, unless you are tracing lots of disks. 4x128kb gone
> >wont be a showstopper for anyone.
> 
> per (online) CPU and device?

Yes, per device and per CPU. It does add up of course, but even some
megabytes of buffers should be ok for most uses. You can shrink them, if
you don't need that much. It is advised to have at least two sub-buffers
though, so shrinking the size is probably better.

> >>>>However, a fast network connection plus a second system for blktrace
> >>>>data processing are serious requirements. Think of servers secured
> >>>>by firewalls. Reading some counters in debugfs, sysfs or whatever
> >>>>might be more appropriate for some one who has noticed an unexpected
> >>>>I/O slowdown and needs directions for further investigation.
> >>>It's hard to make something that will suit everybody. Maintaining some
> >>>counters in sysfs is of course less expensive when your POV is cpu
> >>>cycles.
> >>Counters are also cheaper with regard to memory consumption. Counters
> >>are probably cause less side effects, but are less flexible than
> >>full-blown traces.
> >
> >And the counters are special cases and extremely inflexible.
> 
> Well, I disagree with "extremely".

Fairly inflexible, then :-)

> These statistics have attributes that allow users to adjust data
> aggregation, e.g. to retain more detail in a histogram by adding
> buckets.

I'm not saying they aren't useful, just saying that their are mainly
useful for dasd apparently.

Lets let this go until we know more about how to proceed.

-- 
Jens Axboe

