Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVLBTTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVLBTTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVLBTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:19:14 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:45147 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750936AbVLBTTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:19:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=LkwBMfuINlcvTsVsy+n2+2L+8fGKHU4r2UV9NKFlH5yZcmrRJjeW/v7xmrgBLz6e/K+iasEou8uAMRO4LF53bfHHrhA4PdaPpCmnxPITVjL4LK8yRMxhxPkmWKU8hi0qarD8+YNHWs3oPgegiXCkLPdHTd+N1uNMVaa5yaEjsQc=
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Badari Pulavarty <pbadari@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Dirk Henning Gerdes <mail@dirk-gerdes.de>,
       axboe@suse.de, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051202013408.GA4225@havoc.gtf.org>
References: <1133443051.6110.32.camel@noti>
	 <20051201172520.7095e524.akpm@osdl.org>
	 <20051202013408.GA4225@havoc.gtf.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 11:19:21 -0800
Message-Id: <1133551161.21429.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 20:34 -0500, Jeff Garzik wrote:
> On Thu, Dec 01, 2005 at 05:25:20PM -0800, Andrew Morton wrote:
> > Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:
> > >
> > >  For doing benchmarks on the I/O-Schedulers, I thought it would be very
> > >  useful to disable the pagecache.
> > 
> > That's an FAQ.   Something like this?
> > 
> > 
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> > to discard as much pagecache and reclaimable slab objects as it can.
> > 
> > It won't drop dirty data, so the user should run `sync' first.
> > 
> > Caveats:
> > 
> > a) Holds inode_lock for exorbitant amounts of time.
> > 
> > b) Needs to be taught about NUMA nodes: propagate these all the way through
> >    so the discarding can be controlled on a per-node basis.
> > 
> > c) The pagecache shrinking and slab shrinking should probably have separate
> >    controls.
> > 
> > 
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> ACK, I've wanted something like this for a while.
> 
> I really think it should be a config option, though, to discourage
> people from building with it :)

Why ? Since its controlled through /proc, if some one "echo" stuff into
it, they might get crappy performance (like other /proc tunables). 
Isn't it expected ?

Thanks,
Badari

