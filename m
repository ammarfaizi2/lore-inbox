Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289318AbSAIKrk>; Wed, 9 Jan 2002 05:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289330AbSAIKr1>; Wed, 9 Jan 2002 05:47:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63495 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289327AbSAIKq7>;
	Wed, 9 Jan 2002 05:46:59 -0500
Date: Wed, 9 Jan 2002 11:46:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: admin@nextframe.net, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/psi240i.c - io_request_lock fix
Message-ID: <20020109114638.S19814@suse.de>
In-Reply-To: <20020108150738.B6168@sexything> <3C3B9853.740E71DA@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3B9853.740E71DA@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08 2002, Douglas Gilbert wrote:
> Morten Helgesen wrote:
> > 
> > Hey Linus and the rest of you.
> > 
> > A simple fix for the io_request_lock issue leftovers in drivers/scsi/psi240i.c.
> > Not tested, but compiles. Diffed against 2.5.2-pre10. Please apply.
> > 
> 
> Morten,
> There is a bit more involved than just switching
> io_request_lock to host_lock. The former is global
> so it could be called from anywhere.
> 
> >From the look of this line in the patch:
> > +       struct Scsi_Host *host = PsiHost[irq - 10];
> 
> It will work if the first controller is allocated irq 10,
> the second one irq 11, etc.   Unlikely ...

Irk yes, that is very ugly! And it's even used currently in the driver
as well. How about passing the scsi host as device_id for the isr
instead?

-- 
Jens Axboe

