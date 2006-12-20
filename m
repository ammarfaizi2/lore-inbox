Return-Path: <linux-kernel-owner+w=401wt.eu-S1030193AbWLTQ0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWLTQ0F (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 11:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWLTQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 11:26:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53774 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030193AbWLTQ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 11:26:04 -0500
Date: Wed, 20 Dec 2006 17:23:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
Message-ID: <20061220162338.GC11804@elte.hu>
References: <20061220102846.GA17139@elte.hu> <20061220113052.GA30145@rhun.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220113052.GA30145@rhun.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Muli Ben-Yehuda <muli@il.ibm.com> wrote:

> On Wed, Dec 20, 2006 at 11:28:46AM +0100, Ingo Molnar wrote:
> 
> >  config CALGARY_IOMMU_ENABLED_BY_DEFAULT
> >         bool "Should Calgary be enabled by default?"
> >         default y
> >         depends on CALGARY_IOMMU
> >         help
> >           Should Calgary be enabled by default? if you choose 'y', Calgary
> >           will be used (if it exists). If you choose 'n', Calgary will not be
> >           used even if it exists. If you choose 'n' and would like to use
> >           Calgary anyway, pass 'iommu=calgary' on the kernel command line.
> >           If unsure, say Y.
> > 
> > it's both 'default y', and says "If unsure, say Y". Clearly not a
> > typo.
> 
> I think that it makes sense to have it default y for the mainline 
> kernel and default n for the distro kernels, which is why I added the 
> option to make it possible to compile Calgary in but only enable it if 
> you want to use it. Previously if you compiled it in it would be used, 
> period. You may disagree, but fundamentally I think the mainline 
> kernel should be fairly experimental, which means enabling new code by 
> default.

that's a totally wrong attitude - the mainline kernel is /not/ 
experimental. A distro might or might not enable the new option, but we 
just dont enable experimental platform support code via "default y"...

The other problem is that the changelog entry says that it's off by 
default, while in reality the new option switched this code on for my 
box, and broke it.

> As to what actually happened, I'm betting your machine has both 
> Calgary and CalIOC2, the PCI-e version of Calgary, which is not yet 
> supported by pci-calgary.c. [...]

no, what happened is what i described in my second patch. That 'new 
code' which was default-enabled had a bug which locked up my box.

	Ingo
