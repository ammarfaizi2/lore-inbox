Return-Path: <linux-kernel-owner+w=401wt.eu-S932209AbXADSF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbXADSF5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbXADSF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:05:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45555 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbXADSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:05:56 -0500
Date: Thu, 4 Jan 2007 19:02:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/33] KVM: MMU: Cache shadow page tables
Message-ID: <20070104180223.GA11460@elte.hu>
References: <459D21DD.5090506@qumranet.com> <20070104092226.91fa2dfe.akpm@osdl.org> <459D3C65.2090703@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459D3C65.2090703@qumranet.com>
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


* Avi Kivity <avi@qumranet.com> wrote:

> Andrew Morton wrote:
> >Is this intended for 2.6.20, or would you prefer that we release what we
> >have now and hold this off for 2.6.21?
> >  
> 
> Even though these patches are potentially destabilazing, I'd like them 
> (and a few other patches) to go into 2.6.20:
> 
> - kvm did not exist in 2.6.19, hence we cannot regress from that
> - this patchset is the difference between a working proof of concept and 
> a generally usable system
> - from my testing, it's quite stable

seconded - i have tested the new MMU changes quite extensively and they 
are converging nicely. It brings down context-switch costs by a factor 
of 10 and more, even for microbenchmarks: instead of throwing away the 
full shadow pagetable hiearchy we have worked so hard to construct this 
patchset allows the intelligent caching of shadow pagetables. The effect 
is human-visible as well - the system got visibly snappier.

(I'd increase the shadow cache pool from the current 256 pages to at 
least 1024 pages, but that's a detail.)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
