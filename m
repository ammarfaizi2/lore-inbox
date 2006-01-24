Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWAXBUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWAXBUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWAXBUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:20:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:62635 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030280AbWAXBUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:20:43 -0500
From: Andi Kleen <ak@suse.de>
To: "Ray Bryant" <raybry@mpdtxmail.amd.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Tue, 24 Jan 2006 02:10:03 +0100
User-Agent: KMail/1.8.2
Cc: "Dave McCracken" <dmccr@us.ibm.com>, "Robin Holt" <holt@sgi.com>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601240139.46751.ak@suse.de> <200601231853.54948.raybry@mpdtxmail.amd.com>
In-Reply-To: <200601231853.54948.raybry@mpdtxmail.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240210.04337.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 01:53, Ray Bryant wrote:
> On Monday 23 January 2006 18:39, Andi Kleen wrote:
> > On Tuesday 24 January 2006 01:16, Ray Bryant wrote:
> > > On Monday 23 January 2006 17:58, Ray Bryant wrote:
> > > <snip>
> > >
> > > > ... And what kind of alignment constraints do we end up
> > > > under in order to make the sharing happen?   (My guess would be that
> > > > there aren't any such constraints (well, page alignment.. :-)  if we
> > > > are just sharing pte's.)
> > >
> > > Oh, obviously that is not right as you have to share full pte pages.   So
> > > on x86_64 I'm guessing one needs 2MB alignment in order to get the
> > > sharing to kick in, since a pte page maps 512 pages of 4 KB each.
> >
> > The new randomized mmaps will likely actively sabotate such alignment. I
> > just added them for x86-64.
> >
> > -Andi
> 
> Hmmm, does that mean there is a fundamental conflict between the desire to 
> share pte's and getting good cache coloring behavior?

The randomization is not for cache coloring, but for security purposes
(except for the old very small stack randomization that was used
to avoid conflicts on HyperThreaded CPUs). I would be surprised if the
mmap made much difference because it's page aligned and at least
on x86 the L2 and larger caches are usually PI.

> Isn't it the case that if the region is large enough (say >> 2MB), that 
> randomized mmaps will just cause the first partial page of pte's to not be 
> shareable, and as soon as we have a full pte page mapped into the file that 
> the full pte pages will be shareable, etc, until the last (partial) pte page 
> is not shareable?

They need the same alignment and with the random bits in there it's unlikely
to be ever the same.

-Andi
