Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTDEPAm (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 10:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTDEPAm (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 10:00:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:51384 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262426AbTDEPAl (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 10:00:41 -0500
Date: Sat, 05 Apr 2003 07:11:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, andrea@suse.de, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <69120000.1049555511@[10.10.2.4]>
In-Reply-To: <20030405040614.66511e1e.akpm@digeo.com>
References: <20030404163154.77f19d9e.akpm@digeo.com><12880000.1049508832@flay><20030405024414.GP16293@dualathlon.random><20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It sets up N MAP_SHARED VMA's and N tasks touching them in various access
> patterns.

Can you clarify ... are these VMAs all mapping the same address space,
or different ones? If the same, are you mapping the whole thing each time?

>> I don't think we have an app that has 1000 processes mapping the whole
>> file 1000 times per process. If we do, shooting the author seems like
>> the best course of action to me.
> 
> Rik:
>
> Please, don't shoot akpm ;)

If mapping the *whole* address space hundreds of times, why would anyone 
ever actually want to do that? It kills some important optimisations that 
Dave has made, and seems to be an unrealistic test case. I don't understand
what you're trying to simulate with that (if that's what you are doing).
Mapping 1000 subsegments I can understand, but not the whole thing.

Is excellent to actually have a tool to do real testing on this stuff
with though ... thanks ;-)

> 2.5.66-mm4:
> 2.5.66-mm4+objrmap:

So mm4 has what? No partial objrmap at all (you dropped it?)? 
Or partial but non anon?

> These are not ridiculous workloads, especially the third one.  And 10k VMA's
> is by no means inconceivable.
> 
> The objrmap code will be show-stoppingly expensive at 100k vmas per file.
> 
> And as expected, the full rmap implementation gives the most stable,
> predictable and highest performance result under heavy load.  That's why
> we're using it.

Well, it also consumes the most space. How about adding a test that has
1000s of processes mapping one large (2GB say) VMA, and seeing what that 
does? That's the workload of lots of database type things.

> When it comes to the VM, there is a lot of value in sturdiness under 
> unusual and heavy loads.

Indeed. Which includes not locking up the whole box in a solid hang
from ZONE_NORMAL consumption though ...
 
> Tomorrow I'll change the test app to do nonlinear mappings too.

Cool, thanks ... I'll try to have a play with your tools later this evening.

M.
