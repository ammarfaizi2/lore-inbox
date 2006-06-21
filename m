Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWFUWZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWFUWZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWFUWZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:25:10 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:58718 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030345AbWFUWZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:25:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kaFxna40uY71FDiVBs8zz+YQ3KYqoso3B1WsF5mYjKHUdebgAMDQPcUp7EBWEepBRVO17VclMCsGwEnWpWx2Lfu3y2hYRFuHzCTs4UHUZWTc/5yjQtMHqzksYEo1DBXiEOXiASZimLC2WRWDV+D8pbGtmuexz/AG7xJBj4e5JKg=
Message-ID: <5c49b0ed0606211525i57628af5yaef46ee4e1820339@mail.gmail.com>
Date: Wed, 21 Jun 2006 15:25:05 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Nick Piggin" <npiggin@suse.de>
Subject: Re: [PATCH] mm/tracking dirty pages: update get_dirty_limits for mmap tracking
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, "Hugh Dickins" <hugh@veritas.com>,
       "Andrew Morton" <akpm@osdl.org>, "David Howells" <dhowells@redhat.com>,
       "Christoph Lameter" <christoph@lameter.com>,
       "Martin Bligh" <mbligh@google.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Hans Reiser" <reiser@namesys.com>, "E. Gryaznova" <grev@namesys.com>
In-Reply-To: <20060621180857.GA6948@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5c49b0ed0606211001s452c080cu3f55103a130b78f1@mail.gmail.com>
	 <20060621180857.GA6948@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/06, Nick Piggin <npiggin@suse.de> wrote:
> On Wed, Jun 21, 2006 at 10:01:17AM -0700, Nate Diller wrote:
> > Update write throttling calculations now that we can track and
> > throttle dirty mmap'd pages.  A version of this patch has been tested
> > with iozone:
>
> Your changelog doesn't tell much about the "why" side of things,
> and omits the fact that you have upped the dirty ratio to 80.

hmm, you are right, documenting it in the code comment is not really
enough here, because there are going to be performance corner cases
and such for this patch (as well as the whole tracking dirty patchset)

> >
> > http://namesys.com/intbenchmarks/iozone/06.06.19.tracking.dirty.page-noatime_-B/e3-2.6.16-tr.drt.pgs-rt.40_vs_rt.80.html
> > http://namesys.com/intbenchmarks/iozone/06.06.19.tracking.dirty.page-noatime_-B/r4-2.6.16-tr.drt.pgs-rt.40_vs_rt.80.html
>
> I'm guessing the reason you get all those red numbers when
> iozone files are larger than RAM is because writeout and reclaim
> tend to get worse when there are large amounts of dirty pages
> floating around in memory?

actually, there is a great deal of variation in the test results once
you get into the large I/O part of the test.  also, the fact that we
are tracking mmap'd pages at all changes the preformance.  here are
links which compare the old and new configurations, but with
dirty_pages set to 40 on both:

http://namesys.com/intbenchmarks/iozone/06.06.19.tracking.dirty.page-noatime_-B/e3-2.6.16_vs_tr.drt.pgs-rt.40.html
http://namesys.com/intbenchmarks/iozone/06.06.19.tracking.dirty.page-noatime_-B/r4-2.6.16_vs_tr.drt.pgs-rt.40.html

grev posted the variance as well, but for some reason the link doesn't work.

NATE
