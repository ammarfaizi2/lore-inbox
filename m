Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUEXBDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUEXBDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUEXBDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:03:46 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:41058 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263784AbUEXBDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:03:44 -0400
Date: Mon, 24 May 2004 11:00:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: hch@infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
       Leonardo Macchia <leo@bononia.it>, 250477@bugs.debian.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#250477: kernel-source-2.4.26: Lots of debug in RAID5
Message-ID: <20040524110059.B751892@wobbly.melbourne.sgi.com>
References: <20040523085801.2878013C002@nomade.ciram.unibo.it> <20040523105351.GB19402@gondor.apana.org.au> <20040523111622.GA24817@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040523111622.GA24817@infradead.org>; from hch@infradead.org on Sun, May 23, 2004 at 07:16:22AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 07:16:22AM -0400, hch@infradead.org wrote:
> On Sun, May 23, 2004 at 08:53:51PM +1000, Herbert Xu wrote:
> > > --- kernel-source-2.4.26/drivers/md/raid5.c	2003-08-30 06:01:38.000000000 +0000
> > > +++ kernel-source-2.4.26-nodebug/drivers/md/raid5.c	2004-05-23 08:54:36.000000000 +0000
> > > @@ -282,7 +282,7 @@
> > >  				}
> > >  
> > >  				if (conf->buffer_size != size) {
> > > -					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> > > +					PRINTK("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> > >  					shrink_stripe_cache(conf);
> > >  					if (size==0) BUG();
> > >  					conf->buffer_size = size;
> > 
> > Thanks for the patch.  This does indeed look like a typo.
> > 
> > Hi Neil, does this patch look OK to you?
> 
> No, this was rejected a few times already.  The problem is that XFS
> uses differen I/O sizes for the log and other I/O which makes raid
> performance suck really badly.  The real fix is to use the v2 XFS log
> format when using software raid5.

What is really wanted is the -ssize=4096 option to mkfs.xfs.
This does the 4k aligned log IO Christoph is talking about
here, and also sizes a few other XFS ondisk structures such
that there is no I/O to the device that is not 4K aligned.

Neil, I wonder if we could make the message more informative?
Maybe some words about a suboptimal filesystem configuration,
or something to that effect.

cheers.

-- 
Nathan
