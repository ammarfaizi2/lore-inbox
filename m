Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSHGCoA>; Tue, 6 Aug 2002 22:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHGCoA>; Tue, 6 Aug 2002 22:44:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316674AbSHGCoA>;
	Tue, 6 Aug 2002 22:44:00 -0400
Message-ID: <3D508C83.3A78CC58@zip.com.au>
Date: Tue, 06 Aug 2002 19:57:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       riel@surriel.com
Subject: Re: fix CONFIG_HIGHPTE
References: <20020806231522.GJ6256@holomorphy.com> <3D506D43.890EA215@zip.com.au> <20020807010752.GC6343@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> 
> > We're piling more and more crap in there to support these pte_chains.
> > How much is too much?
> >
> > Is it likely that large pages and/or shared pagetables would allow us to
> > place pagetables and pte_chains in the direct-mapped region, avoid all
> > this?
> 
> On ppc64 shared pagetables will require significant changes to the way
> we handle the hardware hashtable. So add that to the "more and more crap
> in there to support these pte_chains"

Last I heard, pagetable sharing wasn't working out too well
because they all get unshared.
 
> Will shared pagetables be a requirement or can we turn it on per arch?

It's doubtful if per-arch would be an option.

How about this?

- We rely on large pages to solve the Oracle problem

- I'll do pte_chain_highmem and keep that and Bill's patch under test
  in my tree on a wait-and-see basis.  Could go ahead and submit it
  but it's all more complexity, and it'd be nice to actually pull
  something out for a change.

- We'll continue to suck for the University workload.
