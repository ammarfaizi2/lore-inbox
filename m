Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290379AbSAPHNI>; Wed, 16 Jan 2002 02:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290382AbSAPHM6>; Wed, 16 Jan 2002 02:12:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27408 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290383AbSAPHMr>;
	Wed, 16 Jan 2002 02:12:47 -0500
Date: Wed, 16 Jan 2002 08:12:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5 and ppa.c
Message-ID: <20020116081241.H3805@suse.de>
In-Reply-To: <3C4505C4.37EBD193@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C4505C4.37EBD193@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15 2002, Douglas Gilbert wrote:
> John Weber <weber@nyc.rr.com> wrote:
> 
> > This is one of those drivers still broken due to 
> > the BIO changes (it still calls io_request_lock()).
> >
> > Unfortunately, I only know enough to
> > s/io_request_lock/host->host_lock/g.
> > 
> > I am afraid this requires a little more than this.
> 
> John,
> The ppa_detect() must _not_ take the host_lock semaphore
> as it is already taken by the mid level before it calls
> ppa_detect(). [This will cause a lock up on an SMP
> machine.]

Not true in 2.5, detect is called without any locks held.

> The ppa_interrupt() should take the host_lock semaphore
> before it calls scsi_done() (which calls up the scsi
> driver stack).

True

-- 
Jens Axboe

