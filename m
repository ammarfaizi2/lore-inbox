Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSHIOCx>; Fri, 9 Aug 2002 10:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHIOCx>; Fri, 9 Aug 2002 10:02:53 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:53387 "EHLO
	starship") by vger.kernel.org with ESMTP id <S293680AbSHIOCw>;
	Fri, 9 Aug 2002 10:02:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>
Subject: Re: fix CONFIG_HIGHPTE
Date: Fri, 9 Aug 2002 16:07:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       riel@surriel.com
References: <20020806231522.GJ6256@holomorphy.com> <20020807010752.GC6343@krispykreme> <3D508C83.3A78CC58@zip.com.au>
In-Reply-To: <3D508C83.3A78CC58@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dAQH-0001Mo-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 August 2002 04:57, Andrew Morton wrote:
> Anton Blanchard wrote:
> > On ppc64 shared pagetables will require significant changes to the way
> > we handle the hardware hashtable. So add that to the "more and more crap
> > in there to support these pte_chains"
> 
> Last I heard, pagetable sharing wasn't working out too well
> because they all get unshared.

That's only when you fork from a process with a minimal amount of VM mapped, 
such as bash, which has 3 page tables allocated to it, all of which get 
unshared.  The situation is entirely different if you fork from a process 
that has malloced more than a few meg, or beaten on a large mmap.  Page table 
sharing turns in a significant win there.

> > Will shared pagetables be a requirement or can we turn it on per arch?
> 
> It's doubtful if per-arch would be an option.

It's currently expressed as a config option.  As it's purely an optimization 
there's no reason to do otherwise.  Disabling it per-arch should be trivial.

> - We'll continue to suck for the University workload.

That seems likely ;-)

-- 
Daniel
