Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUDRRfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUDRRfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:35:43 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:60024 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262215AbUDRRfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:35:31 -0400
Message-ID: <4082BC85.9010800@sgi.com>
Date: Sun, 18 Apr 2004 12:36:05 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'David Gibson'" <david@gibson.dropbear.id.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, lse-tech@lists.sourceforge.net,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [Lse-tech] Re: hugetlb demand paging patch part [2/3]
References: <20040416032725.GG12735@zax> <200404160413.i3G4DcF13729@unix-os.sc.intel.com> <20040416044917.GB26707@zax> <40802E69.7040506@sgi.com> <20040417120540.GC32444@zax>
In-Reply-To: <20040417120540.GC32444@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



'David Gibson' wrote:

> 
> 
> My main interest in it is as a prerequisite for various methods of
> "automatically" using hugepages for programs where it is difficult to
> manually code them to use hugetlbfs.  In particular, think HPC
> monsters written in FORTRAN.  e.g. automatically putting suitable
> aligned anonymous mmap()s in hugepages under some circumstances (I
> can't say I like that idea much), using an LD_PRELOAD to put
> malloc()ated memory into hugepages, or using a hacked ELF loader to
> put the BSS section (again, think FORTRAN) into hugepages (actually
> easier and less ugly than it sounds).
> 

Well, that certainly is a laudable goal.  At the moment, one usually has to 
resort to such things as POINTER variables and the like to get access to 
hugetlbpage segments.  Unfortunately, some of our experiments with the Intel 
compiler for ia64 have indicated  that the generated code can be significantly 
slower when arrays are referenced off of POINTER variables than when the same 
arrays are referenced out of COMMON, thus eliminating the performance gain of 
HUGETLB pages.

My question was really intended to address applying development effort to 
things that the users of hugetlbpages will likely actually use.  For example, 
it seems pointless to worry too much about demand paging of hugetlbpages out 
to disk.  Anyone who uses hugetlbpages for the performance boost they give 
will also likely have rightsized their problem or machine configuration to 
eliminate any swapping.

> In any of these cases having the memory have different semantics
> (MAP_SHARED) to normal anonymous memory would clearly be a Bad Thing.
> 
> 
> 
> 

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

