Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTEGR1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbTEGR0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:26:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264134AbTEGR00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:26:26 -0400
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
From: Mark Haverkamp <markh@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Mark Wong <markw@osdl.org>, akpm@digeo.com,
       linux-kernel <linux-kernel@vger.kernel.org>, wli@holomorphy.com
In-Reply-To: <20030507173637.GQ823@suse.de>
References: <20030507164728.GO823@suse.de>
	 <200305071659.h47GxmW22250@mail.osdl.org>  <20030507173637.GQ823@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1052329151.25135.14.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 May 2003 10:39:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 10:36, Jens Axboe wrote:
> On Wed, May 07 2003, markw@osdl.org wrote:
> > On  7 May, Jens Axboe wrote:
> > > On Wed, May 07 2003, markw@osdl.org wrote:
> > >> I've collected some data from STP to see if it's useful or if there's
> > >> anything else that would be useful to collect. I've got some tests
> > >> queued up for the newer patches, but I wanted to put out what I had so
> > >> far.
> > >> 
> > >> 
> > >> METRICS OVER LAST 20 MINUTES:
> > >> --------------- -------- ----- ---- -------- -----------------------------------
> > >> Kernel          Elevator NOTPM CPU% Blocks/s URL                                
> > >> --------------- -------- ----- ---- -------- -----------------------------------
> > >> 2.5.68-mm2      as        1155 94.3   8940.2 http://khack.osdl.org/stp/271356/  
> > >> 2.5.68-mm2      deadline  1255 94.9   9598.7 http://khack.osdl.org/stp/271359/  
> > >> 
> > >> FUNCTIONS SORTED BY TICKS:
> > >> -- ------------------------- ------- ------------------------- -------
> > >>  # as 2.5.68-mm2             ticks   deadline 2.5.68-mm2       ticks  
> > >> -- ------------------------- ------- ------------------------- -------
> > >>  1 default_idle              6103428 default_idle              5359025
> > >>  2 bounce_copy_vec             86272 bounce_copy_vec             97696
> > >>  3 schedule                    63819 schedule                    70114
> > >>  4 __make_request              30397 __blk_queue_bounce          31167
> > >>  5 __blk_queue_bounce          26962 scsi_request_fn             26623
> > >>  6 scsi_request_fn             24845 __make_request              25012
> > > 
> > > uhh nasty, you are spending a lot of time bouncing. How much RAM is in
> > > the machine, and what is the scsi hba?
> > 
> > The system has 4GB of memory and has a DECchip 21554 (aacraid) that the
> > external drives are connected to.  Mark Haverkamp is currently trying to
> > address those bounce buffers.
> 
> aacraid actually looks sane enough. so you should just be able to set
> host->highmem_io and it should work.

That is what I thought, but I wanted to get a machine with lots of
memory to try it out on.

Mark.
-- 
Mark Haverkamp <markh@osdl.org>

