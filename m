Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267669AbSLGAOL>; Fri, 6 Dec 2002 19:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbSLGAOL>; Fri, 6 Dec 2002 19:14:11 -0500
Received: from holomorphy.com ([66.224.33.161]:11409 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267669AbSLGAOK>;
	Fri, 6 Dec 2002 19:14:10 -0500
Date: Fri, 6 Dec 2002 16:21:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021207002133.GT9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF13A54.927C04C1@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> William Lee Irwin III wrote:
> > 
> > ...
> > A 16KB or 64KB kernel allocation unit would then annihilate
> 
On Fri, Dec 06, 2002 at 04:01:24PM -0800, Andrew Morton wrote:
> You want to be careful about this:
> 	CPU: L1 I cache: 16K, L1 D cache: 16K
> Because instantiating a 16k page into user pagetables in
> one hit means that it must all be zeroed.  With these large
> pagesizes that means that the application is likely to get
> 100% L1 misses against the new page, whereas it currently
> gets 100% hits.

16K is reasonable; after that one might as well go all the way.
About the only way to cope is amortizing it by cacheing zeroed pages,
and that has other downsides.


Bill
