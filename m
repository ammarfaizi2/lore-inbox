Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUEGJfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUEGJfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUEGJfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:35:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23238 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262956AbUEGJfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 05:35:10 -0400
Date: Fri, 7 May 2004 11:35:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040507093503.GC21109@suse.de>
References: <20040506064301.GC10069@suse.de> <200405062030.i46KUuF13625@unix-os.sc.intel.com> <20040506200210.44b04c38.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506200210.44b04c38.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06 2004, Andrew Morton wrote:
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >
> > >>>> Jens Axboe wrote on Wed, May 05, 2004 11:43 PM
> > > On Wed, May 05 2004, Andrew Morton wrote:
> > > > Jens Axboe <axboe@suse.de> wrote:
> > > > >
> > > > > Do you have any numbers at all for this? I'd say these calculations are
> > > > >  severly into the noise area when submitting io.
> > > >
> > > > The difference will not be measurable, but I think the patch makes sense
> > > > regardless of what the numbers say.
> > >
> > > Humm dunno, I'd rather save the sizeof(int) * 2.
> > 
> > Strictly speaking from memory consumption point of view, it probably comes
> > for free since sizeof(struct request_queue) currently is 456 bytes on x86
> > and 816 on 64bit arch.  The structure is being rounded to 512 or 1024 with
> > kmalloc.
> 
> That's a good argument for creating a standalone slab cache for request
> queue structures ;)

Precisely, it's definitely not a good argument to keep loading it. I'll
do that.

-- 
Jens Axboe

