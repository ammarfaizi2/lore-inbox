Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVDZIXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVDZIXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDZIXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:23:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45498 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261387AbVDZIXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:23:04 -0400
Date: Tue, 26 Apr 2005 10:22:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 7/7] uml ubd: handle readonly status
Message-ID: <20050426082247.GB1851@suse.de>
References: <20050424181924.EAFCB55D06@zion> <20050425101625.GD1671@suse.de> <200504252120.15493.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504252120.15493.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2005, Blaisorblade wrote:
> On Monday 25 April 2005 12:16, Jens Axboe wrote:
> > On Sun, Apr 24 2005, blaisorblade@yahoo.it wrote:
> > > @@ -1099,6 +1104,7 @@ static int prepare_request(struct reques
> > >  	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
> > >  		printk("Write attempted on readonly ubd device %s\n",
> > >  		       disk->disk_name);
> > > +		WARN_ON(1); /* This should be impossible now */
> > >  		end_request(req, 0);
> > >  		return(1);
> > >  	}
> >
> > I don't think that's a sound change. The WARN_ON() is strictly only
> > really useful for when you need the stack trace for something
> > interesting. As the io happens async, you will get a boring trace that
> > doesn't contain any valuable information.
> Ok, removed, and resending the patch, is the rest ok? I.e. is that
> supposed to work? I gave a walk around and it seemed that the code
> handles set_{disk,device}_ro() even during the open, but I'm no block
> layer expert.

I'd keep the checks for sanity. Although the set_disk/device_ro prevents
regular fs write mounts, a buggy layered drive could still send down a
write by accident.

-- 
Jens Axboe

