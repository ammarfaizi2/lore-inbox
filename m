Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289114AbSBLI1w>; Tue, 12 Feb 2002 03:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290828AbSBLI1n>; Tue, 12 Feb 2002 03:27:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43019 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289114AbSBLI1Y>;
	Tue, 12 Feb 2002 03:27:24 -0500
Date: Tue, 12 Feb 2002 09:26:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-ac1
Message-ID: <20020212092658.Z729@suse.de>
In-Reply-To: <20020212001547.GA22586@codepoet.org> <E16aQu1-00008C-00@the-village.bc.nu> <20020212092109.Y729@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212092109.Y729@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Jens Axboe wrote:
> On Tue, Feb 12 2002, Alan Cox wrote:
> > > I notice that in linux/drivers/scsi/scsi_merge.c you seem to
> > > be reverting the MO drive clustering fix from Jens:
> > >     http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.0/1321.html
> > > 
> > > Was this intentional?  If so, why?
> > 
> > I want to find out why it was done first and then test it. Leaving it out
> > will ensure it bugs me until I test it
> 
> If you leave it out, you surely want to make sure that the other request
> init and re-init paths agree on the clustering for MO devices. Because
> they don't.
> 
> As far as I'm concerned, removing the MO conditional wrt clustering is
> the right fix.

BTW, if you are concerned with the write/read vs seek latencies of MO
drives, then the disable clustering hack was definitely the wrong way to
try and limit request sizes. In fact it achieved absolutely _nothing_.
Clustering at this level is completely device independent, too.

In short, the old code made no sense whatsoever.

Now, disabling request merging for MO devices might make a whole lot
more sense. That might be worth while trying, and I'd be happy to give
you a patch to try that out instead.

-- 
Jens Axboe

