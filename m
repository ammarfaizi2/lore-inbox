Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWIUWSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWIUWSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWIUWSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:18:34 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:3762 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751687AbWIUWSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:18:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 3/6] swsusp: Use block device offsets to identify swap locations
Date: Fri, 22 Sep 2006 00:21:29 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200609202120.58082.rjw@sisk.pl> <200609202141.58043.rjw@sisk.pl> <20060921213021.GD2245@elf.ucw.cz>
In-Reply-To: <20060921213021.GD2245@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220021.29603.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 September 2006 23:30, Pavel Machek wrote:
> Hi!
> 
> > Make swsusp use block device offsets instead of swap offsets to identify swap
> > locations and make it use the same code paths for writing as well as for
> > reading data.
> > 
> > This allows us to use the same code for handling swap files and swap
> > partitions and to simplify the code, eg. by dropping rw_swap_page_sync().
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK. You may want to fix the comments, but that's probably separate
> patch.
> 
> 
> > Index: linux-2.6.18-rc7-mm1/mm/swapfile.c
> > ===================================================================
> > --- linux-2.6.18-rc7-mm1.orig/mm/swapfile.c
> > +++ linux-2.6.18-rc7-mm1/mm/swapfile.c
> > @@ -945,6 +945,23 @@ sector_t map_swap_page(struct swap_info_
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +/*
> > + * Get the (PAGE_SIZE) block corrsponding to given offset on the swapdev
> 
> corresponding?
> 
> > + * corrsponding to given index in swap_info (swap type).
> 
> here too...

Ouch, thanks.

I think I'll repost the whole series if Andrew doesn't pick it up, because
I made a typo in the name of the first patch (shame, shame).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
