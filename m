Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267745AbSLGKsP>; Sat, 7 Dec 2002 05:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbSLGKsP>; Sat, 7 Dec 2002 05:48:15 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:25838 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267745AbSLGKsO>; Sat, 7 Dec 2002 05:48:14 -0500
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DF13A54.927C04C1@digeo.com>
References: <20021206111326.B7232@turing.une.edu.au>
	<3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random>
	<3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random>
	<20021206021559.GK9882@holomorphy.com>
	<20021206022853.GJ1567@dualathlon.random>
	<20021206024140.GL9882@holomorphy.com>
	<20021206222852.GF4335@dualathlon.random>
	<20021206232125.GR9882@holomorphy.com>  <3DF13A54.927C04C1@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Dec 2002 11:55:46 +0100
Message-Id: <1039258546.1702.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 01:01, Andrew Morton wrote:
> William Lee Irwin III wrote:
> > 
> > ...
> > A 16KB or 64KB kernel allocation unit would then annihilate
> 
> You want to be careful about this:
> 
> 	CPU: L1 I cache: 16K, L1 D cache: 16K
> 
> Because instantiating a 16k page into user pagetables in
> one hit means that it must all be zeroed.  With these large
> pagesizes that means that the application is likely to get
> 100% L1 misses against the new page, whereas it currently
> gets 100% hits.

If you really want you can cheat that 100% statistic into something much
lower by zeroing the page from back to front (based on the exact
faulting address even, because you know THAT one will get used) and/or
zeroing the second half while bypassing the cache. At least it's 50%
hits then ;)

Still not 100% and I still agree that the 8Kb number is much nicer for
16Kb L1 cache machines....
