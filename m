Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbUDBP2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbUDBP2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:28:17 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12428
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264079AbUDBP2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:28:13 -0500
Date: Fri, 2 Apr 2004 17:28:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402152812.GB21341@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040401180802.219ece99.akpm@osdl.org> <20040402022233.GQ18585@dualathlon.random> <20040402070525.A31581@infradead.org> <16493.4424.598870.574364@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16493.4424.598870.574364@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 05:07:52PM +1000, Paul Mackerras wrote:
> Christoph Hellwig writes:
> > On Fri, Apr 02, 2004 at 04:22:33AM +0200, Andrea Arcangeli wrote:
> > > Well, I doubt anybody could take advantage of this optimization, since
> > > nobody can ship with hugetlbfs disabled anyways (peraphs with the
> > > exception of the embedded people but then I doubt they want to risk
> > 
> > Common. stop smoking that bad stuff.  Almost non-one except the known
> > oracle whores SuSE and RH need it.  Remeber Linux is used much more widely
> > except the known "Enterprise" vendors.  None of the NAS/networking/media
> > applicances or pdas I've seen has the slightest need for hugetlbfs.
> 
> The HPC types also love hugetlbfs since it reduces their tlb miss
> rate.

the point is not the number of people who needs this, the point is that
any distributor will be forced to turn it on, since the distributor
must allow any user to do HPC or database applications. Shipping with
hugetlbfs=n is like shipping with device-mapper=n or sysfs=n or whatever
like that. And having different alloc_pages API depending on a hugetlbfs
compile option was totally broken, plus hugetlbfs=n was buggy, this is
all fixed now.

If we want to make the API not generate compound pages unless you call
with __GFP_COMP that's fine with me, that'll optimize the whole kernel,
and that's a very simple variation of my code. Still the alloc_pages API
must be indipendent of a hugetlbfs compile option.
