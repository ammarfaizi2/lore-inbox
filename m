Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUBJTbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUBJTbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:31:46 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:21658 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266076AbUBJT22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:28:28 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Date: Wed, 11 Feb 2004 03:38:10 +0800
User-Agent: KMail/1.5.4
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200402050941.34155.mhf@linuxmail.org> <200402100625.41288.mhf@linuxmail.org> <20040210185137.GD4478@dualathlon.random>
In-Reply-To: <20040210185137.GD4478@dualathlon.random>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402110338.10258.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 February 2004 02:51, Andrea Arcangeli wrote:
> On Tue, Feb 10, 2004 at 11:24:01PM +0800, Michael Frank wrote:
> > 
> > diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.24-Vanilla/arch/i386/mm/init.c linux-2.4.24-mhf179/arch/i386/mm/init.c
> > --- linux-2.4.24-Vanilla/arch/i386/mm/init.c	2004-01-21 15:53:01.000000000 +0800
> > +++ linux-2.4.24-mhf179/arch/i386/mm/init.c	2004-02-10 06:15:31.000000000 +0800
> > @@ -451,15 +451,18 @@
> >  {
> >  	if (!page_is_ram(pfn)) {
> >  		SetPageReserved(page);
> > +		SetPageNosave(page);
> >  		return;
> >  	}
> >  	
> >  	if (bad_ppro && page_kills_ppro(pfn)) {
> >  		SetPageReserved(page);
> > +		SetPageNosave(page);
> >  		return;
> >  	}
> >  	
> >  	ClearPageReserved(page);
> > +	ClearPageNosave(page);
> 
> why this clearpagenosave? looks superflous, you're not doing it in the
> normal zone anyways.

I'll sleep on it and get back to you with my arguments.

> 
> > +#if defined(__nosave_begin)
> 
> this won't work right, __nosave_begin isn't a preprocessor thing so it
> will be ignored when you uncomment it. You probably can use #if 0
> instead and a comment near __nosave_begin to turn it to 1 when enabling
> the suspend code.

Oh sh*t, this is what one gets for fixing things up for a demo after
a long night... Will bite my lower rear portion after the nap.

> 
> > What is your opinion of this approach?
> 
> except for the above two nitpicks, the patch is correct and needed for
> safe suspend IMHO. 2.6 seems to miss this thing too, why not add it to
> 2.6 first?

Swsusp won't be in 2.4 anyway, if Nigel accepts the patch, it will become part 
of his next releases for 2.4 and 2.6.

Anyway, I'll fix the patch up for 2.6, test it and post the patch in a few days.

Regards
Michael

