Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVJEW0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVJEW0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbVJEW0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:26:44 -0400
Received: from [203.171.93.254] ([203.171.93.254]:21379 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030400AbVJEW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:26:43 -0400
Subject: Re: [PATCH] Free swap suspend from dependency on PageReserved
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1128549812.18249.8.camel@localhost>
References: <1128546263.10363.14.camel@localhost>
	 <1128549812.18249.8.camel@localhost>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128551062.10363.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 06 Oct 2005 08:24:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave.

On Thu, 2005-10-06 at 08:03, Dave Hansen wrote:
> On Thu, 2005-10-06 at 07:04 +1000, Nigel Cunningham wrote:
> > 
> > +       for (tmp = 0; tmp < max_low_pfn; tmp++, addr += PAGE_SIZE) {
> > +               if (page_is_ram(tmp)) {
> > +                       /*
> > +                        * Only count reserved RAM pages
> > +                        */
> > +                       if (PageReserved(mem_map+tmp))
> > +                               reservedpages++;
> 
> Please don't reference mem_map[] directly outside of #ifdef
> CONFIG_FLATMEM areas.  It is not defined for all config cases.  Please
> use pfn_to_page(), instead.  It should work in all cases where the page
> is valid.
> 
> Also, instead of keeping addr defined like you do, and comparing it
> during each run of the loop, why not just use pfn_is_nosave(), which is
> already defined?  Then, you won't even need the variable.

Thanks for the comments. Will revise and resend.

Regards,

Nigel

> -- Dave
-- 


