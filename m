Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWIAQ3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWIAQ3d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWIAQ3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:29:33 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42719 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030193AbWIAQ3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:29:32 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157126640.21733.43.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 09:29:17 -0700
Message-Id: <1157128157.28577.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 18:04 +0200, Martin Schwidefsky wrote:
> 3) The page-has-a-writable-mapping (PG_writable) bit is set when the
> first writable pte for a page is established. The page needs to have a
> different state if a writable pte exists compared to a read-only page.
> The alternative without the page bit would be to do the state change
> every time a writable pte is established or to search all ptes of a
> given page. Both have performance implications.  

What are the performance implications?  Do they completely erase any
performance gains that these patches might have given in the first
place?  Has there been any evaluation of these other two alternatives?
As I understand it, carrying out this performance analysis would be very
difficult for most of the kernel community to perform.

Keeping a nice count of the number of writable PTEs sounds like
something that might be generally useful.  Could we split
page->_mapcount to keep track of r/o and r/w ptes separately?  Or,
perhaps a single bit in it can be utilized to replace PG_writable,
instead.

-- Dave

