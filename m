Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUDSBBF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 21:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbUDSBBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 21:01:05 -0400
Received: from ozlabs.org ([203.10.76.45]:31466 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264232AbUDSBA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 21:00:56 -0400
Date: Mon, 19 Apr 2004 10:47:36 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: Ray Bryant <raybry@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, lse-tech@lists.sourceforge.net,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [Lse-tech] Re: hugetlb demand paging patch part [2/3]
Message-ID: <20040419004736.GA4697@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	Ray Bryant <raybry@sgi.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, 'Andy Whitcroft' <apw@shadowen.org>,
	'Andrew Morton' <akpm@osdl.org>
References: <20040416032725.GG12735@zax> <200404160413.i3G4DcF13729@unix-os.sc.intel.com> <20040416044917.GB26707@zax> <40802E69.7040506@sgi.com> <20040417120540.GC32444@zax> <4082BC85.9010800@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4082BC85.9010800@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 12:36:05PM -0500, Ray Bryant wrote:
> 
> 
> 'David Gibson' wrote:
> 
> >
> >
> >My main interest in it is as a prerequisite for various methods of
> >"automatically" using hugepages for programs where it is difficult to
> >manually code them to use hugetlbfs.  In particular, think HPC
> >monsters written in FORTRAN.  e.g. automatically putting suitable
> >aligned anonymous mmap()s in hugepages under some circumstances (I
> >can't say I like that idea much), using an LD_PRELOAD to put
> >malloc()ated memory into hugepages, or using a hacked ELF loader to
> >put the BSS section (again, think FORTRAN) into hugepages (actually
> >easier and less ugly than it sounds).
> >
> 
> Well, that certainly is a laudable goal.  At the moment, one usually has to 
> resort to such things as POINTER variables and the like to get access to 
> hugetlbpage segments.  Unfortunately, some of our experiments with the 
> Intel compiler for ia64 have indicated  that the generated code can be 
> significantly slower when arrays are referenced off of POINTER variables 
> than when the same arrays are referenced out of COMMON, thus eliminating 
> the performance gain of HUGETLB pages.

Well, that's one problem with using POINTERs, but I think perhaps the
more serious one is that a lot of HPC code is written by scientists
who aren't programmers, and who still think in FORTRAN77.

> My question was really intended to address applying development effort to 
> things that the users of hugetlbpages will likely actually use.  For 
> example, it seems pointless to worry too much about demand paging of 
> hugetlbpages out to disk.  Anyone who uses hugetlbpages for the performance 
> boost they give will also likely have rightsized their problem or machine 
> configuration to eliminate any swapping.

Well, indeed.  Note that this "demand paging" set of patches don't
actually do paging out to disk - they just do on-demand allocation of
physical hugepages, rather than prefaulting them all.  My only real
interest in it is that part of the mechanism is identical to that
needed for COW (handle_hugetlb_mm_fault(), in particular).

> >In any of these cases having the memory have different semantics
> >(MAP_SHARED) to normal anonymous memory would clearly be a Bad Thing.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
