Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbTGDQN0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 12:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbTGDQN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 12:13:26 -0400
Received: from [66.212.224.118] ([66.212.224.118]:31501 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S266066AbTGDQNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 12:13:25 -0400
Date: Fri, 4 Jul 2003 12:16:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
In-Reply-To: <13170000.1057335490@[10.10.2.4]>
Message-ID: <Pine.LNX.4.53.0307041214540.24383@montezuma.mastecende.com>
References: <20030703023714.55d13934.akpm@osdl.org>
 <3F054109.2050100@aitel.hist.no><20030704093531.GA26348@holomorphy.com>
 <20030704095004.GB26348@holomorphy.com><7910000.1057333295@[10.10.2.4]>
 <Pine.LNX.4.53.0307041139150.24383@montezuma.mastecende.com>
 <13170000.1057335490@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, Martin J. Bligh wrote:

> > No, the problem is no space for physical ids in cpumask bitmaps, this 
> > could manifest itself later on unless we fix it now.
> 
> Ugh, are you saying the cpumask stuff shrinks masks to < 32 bits if
> NR_CPUS is low enough? If so, I can see more point to the patch, but
> it still seems like violent overkill. Stopping it doing that would
> probably fix it ... I can't imagine it buys you much.

Hmm i hope not, Bill can you verify that? Looking at the source it doesn't 
appear to be so;

#define BITS_TO_LONGS(bits) \
	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
#define DECLARE_BITMAP(name,bits) \
	unsigned long name[BITS_TO_LONGS(bits)]

> phys_cpu_present_map started off as an unsigned long, and I reused it
> in a fairly twisted way for NUMA-Q. As it's an array that's bounded
> by apic space, using the bios_cpu_apicid method that summit uses
> would be a much cleaner fix, and just leave the old one as a long
> bitmask like it used to be - which is fine for non- clustered apic
> systems, and saves inventing a whole new data type. See the
> cpu_present_to_apicid abstraction.

Thanks i'll have a look.

-- 
function.linuxpower.ca
