Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVE3Lb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVE3Lb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVE3Lb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:31:26 -0400
Received: from brick.kernel.dk ([62.242.22.158]:46280 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261464AbVE3Lao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:30:44 -0400
Date: Mon, 30 May 2005 13:31:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, bzolnier@gmail.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 00/06] blk: barrier flushing reimplementation
Message-ID: <20050530113133.GP7054@suse.de>
References: <20050529042034.5FF4CF1C@htj.dyndns.org> <20050529191437.GA30586@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529191437.GA30586@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29 2005, Jens Axboe wrote:
> On Sun, May 29 2005, Tejun Heo wrote:
> >  Hello, guys.
> > 
> >  This patchset is reimplementation of QUEUE_ORDERED_FLUSH feature.  It
> > doens't update API docs yet.  If it's determined that this patchset
> > can go in, I'll regenerate this patchset with doc updates (sans the
> > last debug message patch of course).
> 
> Awesome work, that's really the last step in getting the barrier code
> fully unified and working with tags. I'll review your patchset tomorrow.

Patches look nice, this is a good step forward. If you feel like doing a
little more work in this area, I would very much like to add
QUEUE_ORDERED_FUA as a third method for implementing barriers. Basically
it would use the FUA commands to put data safely on disk, instead of
using the post flushes.

For NCQ, we have a FUA bit in the FPDMA commands. For non-ncq, we have
the various WRITE_DMA_EXT_FUA (and similar). It would be identical to
ORDERED_FLUSH in that we let the queue drain, issue a pre-flush, and
then a write with FUA set. It would eliminate the need to issue an extra
flush at the end, cutting down the required commands for writing a
barrier from 3 to 2.

-- 
Jens Axboe

