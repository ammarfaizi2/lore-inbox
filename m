Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317863AbSFNBDk>; Thu, 13 Jun 2002 21:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSFNBDj>; Thu, 13 Jun 2002 21:03:39 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:8442 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317863AbSFNBDi>; Thu, 13 Jun 2002 21:03:38 -0400
Date: Thu, 13 Jun 2002 21:03:39 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Richard Brunner <richard.brunner@amd.com>,
        mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020613210339.B21542@redhat.com>
In-Reply-To: <20020613221533.A2544@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 10:15:33PM +0200, Andi Kleen wrote:
> Thanks to Ben LaHaise who found some problems in the original version.
> 
> I will probably submit this version for 2.4 unless someone finds a grave
> problem in this version.

This version is missing a few of the fixes included in my version: 
it doesn't properly flush global tlb entries, or update the page 
tables of processes which have copied 4MB page table entries into 
their page tables.  Also, the revert_page function must be called 
before the tlb flush and free the page after the tlb flush, or 
else tlb prefetching on the P4 can cache stale pmd pointers.  I'd 
suggest using the -C0 version which already has those fixes.

		-ben
