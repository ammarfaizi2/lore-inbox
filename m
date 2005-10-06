Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVJFIGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVJFIGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVJFIGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:06:41 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:52879 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750724AbVJFIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:06:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH][Fix] swsusp: avoid possible page tables corruption during resume on x86-64
Date: Thu, 6 Oct 2005 10:07:45 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200510011813.54755.rjw@sisk.pl> <200510052344.52198.rjw@sisk.pl> <20051005224959.GB22781@elf.ucw.cz>
In-Reply-To: <20051005224959.GB22781@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061007.45698.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 6 of October 2005 00:49, Pavel Machek wrote:
> Hi!
> 
> > Summary =========
> > The following patch makes swsusp avoid the possible temporary corruption of
> > page translation tables during resume on x86-64.  This is achieved by creating
> > a copy of the relevant page tables that will not be modified by swsusp and can
> > be safely used by it on resume.
> 
> Andi, this means swsusp fails 50% of time on x86-64. I believe we even
> have one report in suse bugzilla by now... Could we get this somehow
> merged?
> 
> 
> > Index: linux-2.6.14-rc3-git5/kernel/power/swsusp.c
> > ===================================================================
> > --- linux-2.6.14-rc3-git5.orig/kernel/power/swsusp.c	2005-10-05 21:12:41.000000000 +0200
> > +++ linux-2.6.14-rc3-git5/kernel/power/swsusp.c	2005-10-05 21:24:50.000000000 +0200
> > @@ -672,7 +672,6 @@
> >  		return 0;
> >  
> >  	page = pfn_to_page(pfn);
> > -	BUG_ON(PageReserved(page) && PageNosave(page));
> >  	if (PageNosave(page))
> >  		return 0;
> >  	if (PageReserved(page) && pfn_is_nosave(pfn)) {
> 
> Rafael, are you sure?

Yes, I am.  The pages allocated in init_memory_mapping() are marked with
PG_reserved by the init code.

> This will clash with snapshot.c split and probably belongs to some other patch.

I am aware of that.  This will conflict with the Nigel's patch, so we probably can
arrange to apply that patch before this one, if you prefer.

As far as the split is concerned, if you recall my doubts wrt it, the "bugfixes
pending" is the first point on the list. :-)

Greetings,
Rafael


