Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317860AbSGVWDk>; Mon, 22 Jul 2002 18:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSGVWDk>; Mon, 22 Jul 2002 18:03:40 -0400
Received: from dsl-213-023-038-020.arcor-ip.net ([213.23.38.20]:5811 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317860AbSGVWDj>;
	Mon, 22 Jul 2002 18:03:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: DAC960 Bitrot
Date: Tue, 23 Jul 2002 00:02:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17Sai1-0002T7-00@starship> <20020711100828.GE808@suse.de>
In-Reply-To: <20020711100828.GE808@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17WlGV-00052g-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 12:08, Jens Axboe wrote:
> On Thu, Jul 11 2002, Daniel Phillips wrote:
> > On Thursday 11 July 2002 08:47, Jens Axboe wrote:
> > > Leonard has promised me to convert DAC960 to the "new" pci dma api for
> > > years (or so it seems, actual date may vary, no purchase necessary). I
> > > do have a Mylex controller here myself these days, so it's not
> > > completely impossible that I may do it on a rainy day.
> > 
> > Well, tell me what the new api is and I'll dive in there.  For the record,
> 
> Documentation/DMA-mapping.txt. Also, DAC960 initial bio conversion
> happened before the interface was finalized, so it may need changes in
> that regard as well. Documentation/block/biodoc.txt is your friend there
> :-)
> 
> a quick make drivers/block/DAC960.o shows the following stuff needs
> changing immediately:
> 
> 1) q->queue_lock is a pointer to a lock, not the lock itself. Probably
> add a per-controller spinlock to DAC960_Controller_T, and pass that to
> blk_init_queue(). Then change DAC960_AcquireControllerLock and friends
> in DAC960.h accordingly.

The big change here appears to be the move to per-device request queues.  
Somebody apparently already started to update this driver (you?) but 
obviously didn't try to compile it.  This is new territory for me, so I'll be 
moving gingerly in here for a while.

For those locks, I just removed the &'s, which seems like the right thing to 
do.   The "Controller" lock really seems to be a request queue lock.  Now I 
think I need to allocate and initialize a request queue, possibly in 
DAC960_CreateAuxiliaryStructures.  Am I getting warm?

-- 
Daniel
