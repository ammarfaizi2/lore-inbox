Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265422AbUFOLgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUFOLgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 07:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbUFOLgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 07:36:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41609 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265422AbUFOLgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 07:36:50 -0400
Date: Tue, 15 Jun 2004 13:36:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@Lacote.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIO ordering and NativeCommandQueueing
Message-ID: <20040615113647.GJ25903@suse.de>
References: <200406151202.12884.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200406151202.12884.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15 2004, Guillaume Lacôte wrote:
> Hello,
> (I hope this is the right place for this - sorry if it is not).
> 
> Native Command Queueing (and Tagged Command Queueing) is a feature
> provided by the hardware of newer IDE (and old SCSI) disk drives which
> basically consists in reordering the commands issued on the ATA bus to
> improve speed.
> 
> I assume however that the fastest way to read sectors 101 to 110 is to
> ask for them in that order: 101,102,...,110 . This is a basic
> assumption made by most OSes and apps I presume (otherwise for example
> DMA performance would be catastrophic).
> 
> Here is my point: since a bvec consists of _ordered_ requests only,
> what is the use of NCQ ? Requests will arrive to the drive in
> increasing order, which is the best possible ordering
> performance-wise; thus NCQ will do never do anything.

I think you are confusing scatter-gather with request ordering. And your
terminology is off base - a bvec doesn't consist of ordered requests, it
consist of (max) a single page. A bio consists of bvec's. A request
consits of ordered bio's. The drive queue consist of (fairly well)
ordered requests.

I won't go on about merrits of queueing and depths, search the archives
for that.

-- 
Jens Axboe

