Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319330AbSIKUZc>; Wed, 11 Sep 2002 16:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319329AbSIKUZc>; Wed, 11 Sep 2002 16:25:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49504 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S319327AbSIKUZa>; Wed, 11 Sep 2002 16:25:30 -0400
Date: Wed, 11 Sep 2002 16:30:13 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Lars Marowsky-Bree <lmb@suse.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020911163013.B26367@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <patmans@us.ibm.com> <200209111420.g8BEKdx01979@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209111420.g8BEKdx01979@localhost.localdomain>; from James.Bottomley@steeleye.com on Wed, Sep 11, 2002 at 09:20:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 09:20:38AM -0500, James Bottomley wrote:
> patmans@us.ibm.com said:
> > The scsi multi-path code is not in 2.5.x, and I doubt it will be
> > accepted without the support of James and others. 
> 
> I haven't said "no" yet (and Doug and Jens haven't said anything).

Well, I for one was gone on vacation, and I'm allowed to ignore linux-scsi
in such times, so, as Bill de Cat would say, thptptptppt! :-)

>  I did say 
> when the patches first surfaced that I didn't like the idea of replacing 
> Scsi_Device with Scsi_Path at the bottom and the concomitant changes to all 
> the Low Level Drivers which want to support multi-pathing.  If this is to go 
> in the SCSI subsystem it has to be self contained, transparent and easily 
> isolated.  That means the LLDs shouldn't have to be multipath aware.

I agree with this.

> I think we all agree:
> 
> 1) that multi-path in SCSI isn't the way to go in the long term because other 
> devices may have a use for the infrastructure.

I'm not so sure about this.  I think in the long run this is going to end 
up blurring the line between SCSI layer and block layer IMHO.

> 2) that the scsi-error handler is the big problem

Aye, it is, and for more than just this issue.

> 3) that errors (both medium and transport) may need to be propagated 
> immediately up the block layer in order for multi-path to be handled 
> efficiently.

This is why I'm not sure I agree with 1.  If we are doing this, then we
are sending up SCSI errors at which point the block layer now needs to
know SCSI specifics in order to properly decide what to do with the error.  
That, or we are building specific "is this error multipath relevant" logic
into the SCSI layer and then passing the result up to the block layer.  
I'm the kind of person that my preference would be that either A) the SCSI
layer doesn't know jack about multipath and the block layer handles it all
or B) the block layer doesn't know about our multipath and the SCSI layer
handles it all.  I don't like the idea of mixing them at this current
point in time (there really isn't much of a reason to mix them yet, and
people can only speculate that there might be reason to do so later).

> Although I outlined my ideas for a rework of the error handler, they got lost 
> in the noise of the abort vs reset debate.  These are some of the salient 
> features that will help in this case

[ snipped eh features ]

I'll have to respond to these items separately.  They cross over some with 
these issues, but really they aren't tired directly together and deserve 
separate consideration.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
