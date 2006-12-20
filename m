Return-Path: <linux-kernel-owner+w=401wt.eu-S1030226AbWLTSJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWLTSJ5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWLTSJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:09:57 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:12851 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030226AbWLTSJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:09:56 -0500
Date: Wed, 20 Dec 2006 20:09:53 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
Message-ID: <20061220180953.GM30145@rhun.ibm.com>
References: <20061220102846.GA17139@elte.hu> <20061220113052.GA30145@rhun.ibm.com> <20061220162338.GC11804@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220162338.GC11804@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 05:23:38PM +0100, Ingo Molnar wrote:

> > I think that it makes sense to have it default y for the mainline 
> > kernel and default n for the distro kernels, which is why I added the 
> > option to make it possible to compile Calgary in but only enable it if 
> > you want to use it. Previously if you compiled it in it would be used, 
> > period. You may disagree, but fundamentally I think the mainline 
> > kernel should be fairly experimental, which means enabling new code by 
> > default.
> 
> that's a totally wrong attitude - the mainline kernel is /not/
> experimental. A distro might or might not enable the new option, but
> we just dont enable experimental platform support code via "default
> y"...

I disagree, it seems to me most "experimental platform support code"
is simply enabled because it doesn't even have a CONFIG option (c.f.,
recent genirq and IO-APIC breakage on x86-64). With regards to this
specific option, you might even say that not defaulting to 'y' here
would be a regression in behaviour against previous released kernels,
which used Calgary if it was compiled in, no questions asked. So at
least in that sense, instructing the user to select y if unsure and
default y are appropriate.

> The other problem is that the changelog entry says that it's off by
> default, while in reality the new option switched this code on for
> my box, and broke it.

Sorry about that (both the wrong changelog entry and the fact that it
broke your box).

> > As to what actually happened, I'm betting your machine has both 
> > Calgary and CalIOC2, the PCI-e version of Calgary, which is not yet 
> > supported by pci-calgary.c. [...]
> 
> no, what happened is what i described in my second patch. That 'new 
> code' which was default-enabled had a bug which locked up my box.

Yes, I realized that once I've read your other mail.

Cheers,
Muli
