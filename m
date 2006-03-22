Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWCVNIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWCVNIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCVNIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:08:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7957 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750999AbWCVNIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:08:30 -0500
Date: Wed, 22 Mar 2006 14:08:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: [dm-devel] Re: dm: bio split bvec fix
Message-ID: <20060322130823.GH4285@suse.de>
References: <20060320192155.GU4724@agk.surrey.redhat.com> <20060322113235.GC4285@suse.de> <20060322121941.GS26428@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322121941.GS26428@agk.surrey.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22 2006, Alasdair G Kergon wrote:
> On Wed, Mar 22, 2006 at 12:32:35PM +0100, Jens Axboe wrote:
> > Why isn't this just handled in the merge callback? Can a single page bio
> > span > 2 targets?
>  
> Yes.  (Unit of size if the sector - and things don't have to
> be aligned nicely, just aligned to sector.)
> 
> IIRC the merge function assumes the number of bytes that can
> be added is only a function of the offset: but in our case
> it's also a function of time.  To make this work it should
> reserve those bytes with device-mapper, and guarantee either to 
> supply them to us subsequently (and preferably quickly) or to 
> cancel that reservation.  Device-mapper for its part would
> guarantee to accept the bio without needing to split it.
> Or dm could have a rejection mechanism that refuses bios
> that are too big (because the max number of bytes we accept
> got reduced between the initial call and the bio actually being 
> presented) and they go back and get processed again.
> 
> Alasdair
> -- 
> agk@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Jens Axboe

