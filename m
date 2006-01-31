Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWAaXjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWAaXjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWAaXjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:39:41 -0500
Received: from tim.rpsys.net ([194.106.48.114]:43439 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932151AbWAaXjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:39:40 -0500
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <1138745323.4934.17.camel@localhost.localdomain>
References: <1138714918.6869.139.camel@localhost.localdomain>
	 <58cb370e0601310646y263acb96h62c422435e7016e@mail.gmail.com>
	 <1138724479.6869.201.camel@localhost.localdomain>
	 <58cb370e0601310944l421174f8j1802d94f1ae93a01@mail.gmail.com>
	 <1138745323.4934.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 23:39:17 +0000
Message-Id: <1138750757.6869.324.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 09:08 +1100, Benjamin Herrenschmidt wrote:
> > Isn't ->end_request hook in ide_driver_t enough?
> > 
> > I see no reason why the custom ->end_request function cannot
> > be added to ide-disk.  All needed infrastructure is there.
> 
> I'm not sure ide-disk is the right spot ... what if one wants LEDs for
> CD-ROMs or other IDE devices like flash cards ?

Flash cards mainly go through ide-cs which uses ide-disk.

There are several options:

1. Have the trigger on ide-disk activity (confined to ide-disk.c).

2. Have the trigger on ide-io activity (confined to ide-io.c).

3. Do something else.

4. Don't add disk activity (or any?) triggers in mainline.

Thanks to a generic API, adding triggers anywhere is fairly trivial but
probably not without controversy so they need to be carefully placed, if
at all.

We could always wait and see which of the above there is demand for. I
suspect options 1 or 2 would cover most people's needs. We're never
going to satisfy everyone (but anyone is free to apply simple patches to
get their desired trigger).

I'd rather go with option 4 than block all the led class/driver code
over any controversial triggers.

Richard

