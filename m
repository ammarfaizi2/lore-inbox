Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVKXJ7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVKXJ7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVKXJ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:59:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26716 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932618AbVKXJ7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:59:34 -0500
Date: Thu, 24 Nov 2005 11:00:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [Q] is queue->hardsect_size respected?
Message-ID: <20051124100050.GD15804@suse.de>
References: <58cb370e0511230824j2585d755vdd9b6b780ed0fed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511230824j2585d755vdd9b6b780ed0fed3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23 2005, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> I'm hacking on ide-cd.c and I've noticed that some old code
> (PIO handing for read fs requests) still supports unaligned access:

I think that can safely die, that code even predates me maintaining it.
It's a bug to receive a request that's not hardsector aligned. It used
to be a problem with eg hfs cds, since they use 512b sectors. But the
caching should take care of it for us, it's definitely not driver
business.

So rip it!

-- 
Jens Axboe

