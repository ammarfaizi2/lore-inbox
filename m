Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbRGKUSI>; Wed, 11 Jul 2001 16:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbRGKUR4>; Wed, 11 Jul 2001 16:17:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12299 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266081AbRGKURp>;
	Wed, 11 Jul 2001 16:17:45 -0400
Date: Wed, 11 Jul 2001 22:17:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Dipankar Sarma <dipankar@sequent.com>
Cc: mike.anderson@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711221719.P712@suse.de>
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com> <20010711090257.B27097@us.ibm.com> <20010711212022.H712@suse.de> <20010712014328.A14094@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010712014328.A14094@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12 2001, Dipankar Sarma wrote:
> On Wed, Jul 11, 2001 at 09:20:22PM +0200, Jens Axboe wrote:
> > True. In theory it would be possible to do request slot stealing from
> > idle queues, in fact it's doable without adding any additional overhead
> > to struct request. I did discuss this with [someone, forgot who] last
> > year, when the per-queue slots where introduced.
> > 
> > I'm not sure I want to do this though. If you have lots of disks, then
> > yes there will be some wastage if they are idle. IMO that's ok. What's
> > not ok and what I do want to fix is that slower devices get just as many
> > slots as a 15K disk for instance. For, say, floppy or CDROM devices we
> > really don't need to waste that much RAM. This will change for 2.5, not
> > before.
> 
> Unless there is some serious evidence substantiating the need for
> stealing request slots from other devices to avoid starvation, it
> makes sense to avoid it and go for a simpler scheme. I suspect that device
> type based slot allocation should just suffice.

My point exactly. And typically, if you have lots of queues you have
lots of RAM. A standard 128meg desktop machine does not waste a whole
lot.

-- 
Jens Axboe

