Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbTIRO4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 10:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTIRO4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 10:56:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16261
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261386AbTIRO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 10:56:45 -0400
Date: Thu, 18 Sep 2003 16:56:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo.tosatti@cyclades.com.br, linux-kernel@vger.kernel.org
Subject: Re: nr_free_buffer_pages 2.4.23pre4
Message-ID: <20030918145642.GF1301@velociraptor.random>
References: <200309181201.h8IC1hue002338@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309181201.h8IC1hue002338@harpo.it.uu.se>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 02:01:43PM +0200, Mikael Pettersson wrote:
> On Thu, 18 Sep 2003 07:06:12 +0200, Andrea Arcangeli <andrea@suse.de> wrote:
> > According to the kernel CVS you didn't merge this yet, so please merge
> > the below too, it will remove a not necessary branch that also generates
> > a gcc false positive (all harmless of course but it's more correct to
> > remove it):
> > 
> > --- 2.4.23pre4/mm/page_alloc.c.~1~	2003-09-13 00:08:04.000000000 +0200
> > +++ 2.4.23pre4/mm/page_alloc.c	2003-09-14 01:05:24.000000000 +0200
> > @@ -258,8 +258,6 @@ static struct page * balance_classzone(z
> >  	struct page * page = NULL;
> >  	int __freed;
> >  
> > -	if (!(gfp_mask & __GFP_WAIT))
> > -		goto out;
> >  	if (in_interrupt())
> >  		BUG();
> 
> Andrea,
> 
> This cleanup leaves the 'out' label unused, triggering
> yet another gcc warning (though less scary than the previous).
> Please apply this cleanup patch on top of the one above.

yes, I recall I also cleaned up that bit in a later patch. And yes, it
was harmless too ;)

> 
> /Mikael
> 
> --- linux-2.4.23-pre4/mm/page_alloc.c.~1~	2003-09-18 13:43:41.753607800 +0200
> +++ linux-2.4.23-pre4/mm/page_alloc.c	2003-09-18 13:55:46.785155159 +0200
> @@ -317,7 +317,6 @@
>  		}
>  		current->nr_local_pages = 0;
>  	}
> - out:
>  	*freed = __freed;
>  	return page;
>  }


Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
