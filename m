Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbULNViH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbULNViH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULNViH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:38:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54478 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261660AbULNViA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:38:00 -0500
Date: Tue, 14 Dec 2004 12:08:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>
cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <19030000.1103054924@flay>
In-Reply-To: <20041214191348.GA27225@wotan.suse.de>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com> <9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, December 14, 2004 20:13:48 +0100 Andi Kleen <ak@suse.de> wrote:

> On Tue, Dec 14, 2004 at 10:59:50AM -0800, Martin J. Bligh wrote:
>> > NUMA systems running current Linux kernels suffer from substantial
>> > inequities in the amount of memory allocated from each NUMA node
>> > during boot.  In particular, several large hashes are allocated
>> > using alloc_bootmem, and as such are allocated contiguously from
>> > a single node each.
>> 
>> Yup, makes a lot of sense to me to stripe these, for the caches that
> 
> I originally was a bit worried about the TLB usage, but it doesn't
> seem to be a too big issue (hopefully the benchmarks weren't too
> micro though)

Well, as long as we stripe on large page boundaries, it should be fine,
I'd think. On PPC64, it'll screw the SLB, but ... tough ;-) We can either
turn it off, or only do it on things larger than the segment size, and
just round-robin the rest, or allocate from node with most free.
 
>> didn't Manfred or someone (Andi?) do this before? Or did that never
>> get accepted? I know we talked about it a while back.
> 
> I talked about it, but never implemented it. I am not aware of any
> other implementation of this before Brent's.

Cool, must have been my imagination ;-)

M.

