Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbUCNOip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 09:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUCNOip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 09:38:45 -0500
Received: from nils.bezeqint.net ([192.115.104.5]:745 "EHLO nils.bezeqint.net")
	by vger.kernel.org with ESMTP id S263369AbUCNOin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 09:38:43 -0500
Date: Sun, 14 Mar 2004 16:37:52 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040314143752.GE3829@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <20040313221418.GF5960@luna.mooo.com> <1079217159.4915.0.camel@laptop.fenrus.com> <20040314010508.GL5960@luna.mooo.com> <20040313174929.32b6d259.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313174929.32b6d259.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 05:49:29PM -0800, Andrew Morton wrote:
> Micha Feigin <michf@post.tau.ac.il> wrote:
> >
> >  > Wrong. Any such interface is supposed to convert automatically. Any
> >  > interface you can find that doesn't should be reported as a serious bug!
> >  > 
> > 
> >  Like I said, look at bdflush in 2.4 (this was fixed with the changed 2.6
> >  interface) and xfs proc interface in both 2.4 and 2.6.
> >  In light of your post then there is a serious bug.
> > 
> >  For example for bdflush age_buffer field (true for the other used fields
> >  also), no conversion:
> >  	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;
> 
> I doubt if there's any motivation to fix these things in 2.4.  If you change
> HZ in 2.4 you own both pieces.  (alpha has HZ=1024 in 2.4, so presumably
> bdflush tuning doesn't work right).
> 

There is for laptop mode which is now in the kernel so a generic startup
script can be written.

I will right a patch and post it in a new thread and see how it takes.

> In 2.6, the bdflush parameters do not exist.  They were replaced by
> /proc/sys/vm/*_centisecs, which are HZ-independent.
> 
> There are, I think, still some /proc tunables in 2.6 which do depend upon
> HZ and they should be found and fixed.  If the same tunables are present in
> 2.4 kernels then they should be converted to take centiseconds in 2.6, so
> 2.4-based tools continue to work correctly.
> 
> We have similar problems where /proc tunables are expressed in terms of
> "number of pages".  As PAGE_SIZE varies from 4096 to 65536 this is
> sometimes wrong.  Fixing this is more subtle.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
