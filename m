Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319161AbSIJQLH>; Tue, 10 Sep 2002 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319163AbSIJQLH>; Tue, 10 Sep 2002 12:11:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45834 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319161AbSIJQLG>;
	Tue, 10 Sep 2002 12:11:06 -0400
Date: Tue, 10 Sep 2002 09:16:05 -0700
From: Dave Olien <dmo@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020910091605.A23706@acpi.pdx.osdl.net>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020910062030.GL8719@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910062030.GL8719@suse.de>; from axboe@suse.de on Tue, Sep 10, 2002 at 08:20:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've also been mucking about with the DAC960 driver.  
We've got several DAC960 devices in our lab, of
two different versions, I believe.

I've fixed a few minor typos in the version that's in
the kernel.org source.  For example, the way the
code references the controller lock doesn't quite work.
The driver uses that lock before the request queue for the
controller has been allocated.  So, the controller locking
functions can't reference that lock through the request queue.
I've changed it to reference the lock through the controller
structure directly.

I've been working on the DMA mapping changes.   I've been
doing a pretty straight-forward set of changes.  As a second
pass, I'm thinking there might be some better ways to manage
the DMA mappings.

I'll post some initial changes at the endof the week, and perhaps
you can give it some review?


On Tue, Sep 10, 2002 at 09:30:28AM +0400, Samium Gromoff wrote:
>       Hello folks, i`m looking at the DAC960 driver and i have
> realised its implemented at the block layer, bypassing SCSI.
> 
>    So given i have some motivation to have a working 2.5 DAC960
> driver (i have one, being my only controller)
> i`m kinda pondering the matter.
> 
>    Questions:
>        1. Whether we need the thing to be ported to SCSI
> layer, as opposed to leaving it being a generic block device? (i suppose yes)
>        2. Which 2.5 SCSI driver should i use as a start of learning?
>        3. Whether the SCSI driver API would change during 2.5?
> 
> ---
> regards,
>    Samium Gromoff
> ____________
> ________________________________
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



On Tue, Sep 10, 2002 at 08:20:30AM +0200, Jens Axboe wrote:
> On Tue, Sep 10 2002, Samium Gromoff wrote:
> >       Hello folks, i`m looking at the DAC960 driver and i have
> > realised its implemented at the block layer, bypassing SCSI.
> > 
> >    So given i have some motivation to have a working 2.5 DAC960
> > driver (i have one, being my only controller)
> > i`m kinda pondering the matter.
> > 
> >    Questions:
> >        1. Whether we need the thing to be ported to SCSI
> > layer, as opposed to leaving it being a generic block device? (i suppose yes)
> 
> No
> 
> >        2. Which 2.5 SCSI driver should i use as a start of learning?
> 
> Don't bother
> 
> >        3. Whether the SCSI driver API would change during 2.5?
> 
> Possibly
> 
> The DAC960 mainly needs updating to the pci dma api, and to be adjusted
> for the bio changes. Please coordinate with Daniel Philips (and check
> the list archives, we had a talk about this very driver some weeks ago),
> since he's working on making it work in 2.5 again as well.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
