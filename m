Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUEWLQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUEWLQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 07:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUEWLQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 07:16:36 -0400
Received: from canuck.infradead.org ([205.233.217.7]:15876 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262547AbUEWLQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 07:16:35 -0400
Date: Sun, 23 May 2004 07:16:22 -0400
From: hch@infradead.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leonardo Macchia <leo@bononia.it>, 250477@bugs.debian.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#250477: kernel-source-2.4.26: Lots of debug in RAID5
Message-ID: <20040523111622.GA24817@infradead.org>
Mail-Followup-To: hch@infradead.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Leonardo Macchia <leo@bononia.it>, 250477@bugs.debian.org,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040523085801.2878013C002@nomade.ciram.unibo.it> <20040523105351.GB19402@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523105351.GB19402@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 08:53:51PM +1000, Herbert Xu wrote:
> > --- kernel-source-2.4.26/drivers/md/raid5.c	2003-08-30 06:01:38.000000000 +0000
> > +++ kernel-source-2.4.26-nodebug/drivers/md/raid5.c	2004-05-23 08:54:36.000000000 +0000
> > @@ -282,7 +282,7 @@
> >  				}
> >  
> >  				if (conf->buffer_size != size) {
> > -					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> > +					PRINTK("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> >  					shrink_stripe_cache(conf);
> >  					if (size==0) BUG();
> >  					conf->buffer_size = size;
> 
> Thanks for the patch.  This does indeed look like a typo.
> 
> Hi Neil, does this patch look OK to you?

No, this was rejected a few times already.  The problem is that XFS
uses differen I/O sizes for the log and other I/O which makes raid
performance suck really badly.  The real fix is to use the v2 XFS log
format when using software raid5.

