Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVJFI1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVJFI1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVJFI1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:27:04 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:63631 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750737AbVJFI1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:27:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org, ncunningham@cyclades.com
Subject: Re: [PATCH] Free swap suspend from dependency on PageReserved
Date: Thu, 6 Oct 2005 10:28:09 +0200
User-Agent: KMail/1.8.2
Cc: Dave Hansen <haveblue@us.ibm.com>, Pavel Machek <pavel@ucw.cz>
References: <1128546263.10363.14.camel@localhost> <1128549812.18249.8.camel@localhost> <1128551062.10363.41.camel@localhost>
In-Reply-To: <1128551062.10363.41.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061028.10237.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On Thursday, 6 of October 2005 00:24, Nigel Cunningham wrote:
> Hi Dave.
> 
> On Thu, 2005-10-06 at 08:03, Dave Hansen wrote:
> > On Thu, 2005-10-06 at 07:04 +1000, Nigel Cunningham wrote:
> > > 
> > > +       for (tmp = 0; tmp < max_low_pfn; tmp++, addr += PAGE_SIZE) {
> > > +               if (page_is_ram(tmp)) {
> > > +                       /*
> > > +                        * Only count reserved RAM pages
> > > +                        */
> > > +                       if (PageReserved(mem_map+tmp))
> > > +                               reservedpages++;
> > 
> > Please don't reference mem_map[] directly outside of #ifdef
> > CONFIG_FLATMEM areas.  It is not defined for all config cases.  Please
> > use pfn_to_page(), instead.  It should work in all cases where the page
> > is valid.
> > 
> > Also, instead of keeping addr defined like you do, and comparing it
> > during each run of the loop, why not just use pfn_is_nosave(), which is
> > already defined?  Then, you won't even need the variable.
> 
> Thanks for the comments. Will revise and resend.

There's one more reference to PageReserved() in swsusp.c, which is
in save_highmem_zone().  You seem to omit this one (or I have missed
it in your patch in which case please ignore this message).  Is that
intentional?

Rafael
