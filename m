Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWIARCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWIARCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWIARCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:02:33 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:50422 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932457AbWIARCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:02:32 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157128157.28577.129.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157128157.28577.129.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 19:02:30 +0200
Message-Id: <1157130150.21733.70.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 09:29 -0700, Dave Hansen wrote:
> > 3) The page-has-a-writable-mapping (PG_writable) bit is set when the
> > first writable pte for a page is established. The page needs to have a
> > different state if a writable pte exists compared to a read-only page.
> > The alternative without the page bit would be to do the state change
> > every time a writable pte is established or to search all ptes of a
> > given page. Both have performance implications.  
> 
> What are the performance implications?  Do they completely erase any
> performance gains that these patches might have given in the first
> place?  Has there been any evaluation of these other two alternatives?
> As I understand it, carrying out this performance analysis would be very
> difficult for most of the kernel community to perform.

It seemed obvious to me that anything else than checking a bit is way to
expensive. I never implemented nor measured any of the alternatives. The
alternative to do the state change every time a writable pte is
established can be implemented without too much trouble. Perhaps I will
give it a try next week.

> Keeping a nice count of the number of writable PTEs sounds like
> something that might be generally useful.  Could we split
> page->_mapcount to keep track of r/o and r/w ptes separately?  Or,
> perhaps a single bit in it can be utilized to replace PG_writable,
> instead.

Yes, that would be really useful for the writable ptes. But I have the
feeling that the actual implementation of it will be tricky.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


