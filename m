Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTGBUGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGBUGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:06:12 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:19899 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264147AbTGBUGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:06:11 -0400
Date: Wed, 02 Jul 2003 13:05:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>
cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <542640000.1057176301@flay>
In-Reply-To: <Pine.LNX.4.44.0307021401570.31191-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0307021401570.31191-100000@chimarrao.boston.redhat.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So ether we declare 32bit archs obsolete in production with 2.6, or we
>> drop rmap behind remap_file_pages.
> 
>> Something has to change since IMHO in the current 2.5.73 remap_file_pages
>> is nearly useless.
> 
> Agreed.  What we did for a certain unspecified kernel tree
> at Red Hat was the following:
> 
> 1) limit sys_remap_file_pages functionality to shared memory
>    segments on ramfs (unswappable) and tmpfs (mostly unswappable;))
> 
> 2) have the VMAs with remapped pages in them marked VM_LOCKED
> 
> 3) do not set up pte chains for the pages that get mapped with
>    install_page
> 
> 4) remove said pages from the LRU list, in the ramfs case, they're
>    unswappable anyway so we shouldn't have the VM scan them
> 
> The only known user of sys_remap_file_pages was more than happy
> to have the functionality limited to just what they actually need, 
> in order to get simpler code with less overhead.
> 
> Lets face it, nobody is going to use sys_remap_file_pages for
> anything but a database shared memory segment anyway. You don't
> need to care about truncate or the other corner cases.

Well if RH have done this internally, and they invented the thing,
then I see no reason not do that in 2.5 ... 

>> Maybe I'm just taking this out of context, and it's twisting my brain,
>> but as far as I know, the nonlinear vma's *are* backed by pte_chains.
>
> Rik:
>
> They are, but IMHO they shouldn't be.  The nonlinear vmas are used
> only for database shared memory segments and other "bypass the VM"
> applications, so I don't see any reason why we need to complicate
> things hopelessly in order to deal with corner cases like truncate.

Agreed. Oddly, most of us seem to agree on this ... ;-)

M.

