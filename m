Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268846AbUIBVFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268846AbUIBVFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269078AbUIBVEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:04:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61582 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268846AbUIBVDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:03:10 -0400
Date: Thu, 2 Sep 2004 14:02:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "David S. Miller" <davem@davemloft.net>
cc: benh@kernel.crashing.org, akpm@osdl.org, wli@holomorphy.com,
       davem@redhat.com, raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support
 added
In-Reply-To: <20040902131057.0341e337.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
 <1094012689.6538.330.camel@gaston> <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
 <1094080164.4025.17.camel@gaston> <Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com>
 <20040901215741.3538bbf4.davem@davemloft.net>
 <Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
 <20040902131057.0341e337.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, David S. Miller wrote:

> On Thu, 2 Sep 2004 09:24:47 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
>
> > Why was it done that way? Would it not be better to add the new
> > functionality by giving the function another name?
> >
> > Like f.e. set_pte_mm()
> >
> > then one could add the following in asm-generic/pgtable.h
> >
> > #ifndef __HAVE_ARCH_SET_PTE_MM
> > #define set_pte_mm(mm, address, ptep, pte) set_pte(ptep, pte)
> > #endif
> >
> > which would avoid having to update the other platforms and woud allow a
> > gradual transition.
>
> In order for it to be useful, every set_pte() call has to get the
> new args.  If there are exceptions, then it doesn't work out cleanly.

Yes. The mechanism that I proposed allows one to provide the info at each
call of set_pte_mm(). set_pte() would only be used for the arch specific
stuff and would become a legacy thing.

> I did all of the generic code, it's just each platform's code that
> needs updating.
>
> And BTW it's not just set_pte(), it's also pte_clear() and some of
> the other routines that need the added mm and address args.

Would not the generic code if done the way I suggested make the updating
of each platforms code unnecessary?

I have the similar issues with the page scalability patch. Should I not do
the legacy thing for platforms that do not have atomic pte operations?
'
