Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTE1F6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTE1F6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:58:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65418 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264542AbTE1F6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:58:37 -0400
Date: Wed, 28 May 2003 08:11:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Ivan Gyurdiev <ivg2@cornell.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/blkdev (2.5.70)
Message-ID: <20030528061136.GH845@suse.de>
References: <200305272323.29063.ivg2@cornell.edu> <20030528052934.GS8978@holomorphy.com> <Pine.LNX.4.50.0305280130160.15323-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305280130160.15323-100000@montezuma.mastecende.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Zwane Mwaikambo wrote:
> On Tue, 27 May 2003, William Lee Irwin III wrote:
> 
> > On Tue, May 27, 2003 at 11:23:29PM -0400, Ivan Gyurdiev wrote:
> > > Out of nowhere on mozilla open (after it worked fine all afternoon):
> > > ------------[ cut here ]------------
> > > kernel BUG at include/linux/blkdev.h:408!
> > > invalid operand: 0000 [#1]
> > > CPU:    0
> > > EIP:    0060:[<c02322be>]    Tainted: P  
> > > EFLAGS: 00010046
> > > EIP is at blk_queue_start_tag+0x8e/0x100
> > 
> > This appears to be tainted by a proprietary module. Please reproduce
> > without it or forward the bugreport to the originator of the module.
> 
> Looks valid;
> 
> We tried to remove the previous request.. but there was none. The BUG 
> check looks odd (what happens to the first tag?)

Previous request, what are you talking about?

do_ide_request()
ide_do_request()
start_request(drive, rq);	/* this rq is _never_ off the list */
__ide_do_rw_disk(drive, rq);
idedisk_start_tag(drive, rq);
	blkdev_dequeue_request(rq);	/* boom */

It does _not_ look valid.

-- 
Jens Axboe

