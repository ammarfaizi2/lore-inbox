Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbTCOIEZ>; Sat, 15 Mar 2003 03:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbTCOIEZ>; Sat, 15 Mar 2003 03:04:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52353 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261317AbTCOIEY>;
	Sat, 15 Mar 2003 03:04:24 -0500
Date: Sat, 15 Mar 2003 09:15:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
Message-ID: <20030315081511.GJ791@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org> <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org> <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org> <20030314203324.GD791@suse.de> <1047680131.1510.0.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047680131.1510.0.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Jeremy Fitzhardinge wrote:
> On Fri, 2003-03-14 at 12:33, Jens Axboe wrote:
> > On Fri, Mar 14 2003, Jeremy Fitzhardinge wrote:
> > > With the version or cdrtools I compiled, I get an instant oops+lockup
> > > with the above command when running with anticipatory scheduler in
> > > 2.5.64-mm6 (hand written):
> > > 
> > > elv_remove_request
> > > ide_end_request
> > > cdrom_end_request
> > > cdrom_decode_status
> > > cdrom_newpc_intr
> > 
> > 
> > --- drivers/block/as-iosched.c~	2003-03-14 21:32:14.000000000 +0100
> > +++ drivers/block/as-iosched.c	2003-03-14 21:32:38.000000000 +0100
> > @@ -1341,6 +1341,8 @@
> >  			insert_here = ad->dispatch->prev;
> >  
> >  		list_add(&rq->queuelist, insert_here);
> > +		if (arq)
> > +			RB_CLEAR(&arq->rb_node);
> >  		
> >  		if (!list_empty(ad->dispatch) && rq_data_dir(rq) == READ
> >  			&& (ad->antic_status == ANTIC_WAIT_REQ
> 
> No joy, I'm afraid.  Same crash.

Too bad, then there are two bugs in there :/

-- 
Jens Axboe

