Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSJVRNX>; Tue, 22 Oct 2002 13:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264787AbSJVRNX>; Tue, 22 Oct 2002 13:13:23 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:1520 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264786AbSJVRNV>; Tue, 22 Oct 2002 13:13:21 -0400
Date: Tue, 22 Oct 2002 13:19:30 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <20021022131930.A20957@redhat.com>
References: <2629464880.1035240956@[10.10.2.3]> <Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 22, 2002 at 02:09:47PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 02:09:47PM -0200, Rik van Riel wrote:
> On Mon, 21 Oct 2002, Martin J. Bligh wrote:
> 
> > I think it will for most of the situations we run aground with now
> > (normally 5000 oracle tasks sharing a 2Gb shared segment, or some
> > such monster).
> 
> 10 GB pagetable overhead, for 2 GB of data.  No customer I
> know would accept that much OS overhead.
> 
> To reduce the overhead we could either reclaim the page
> tables and reconstruct them when needed (lots of work) or
> we could share the page tables (less runtime overhead).

Or you use 4MB pages.  That tends to work much better and has less 
complexity.  Shared page tables don't work well on x86 when you have 
a database trying to access an SGA larger than the virtual address 
space, as each process tends to map its own window into the buffer 
pool.  Highmem with 32 bit va just plain sucks.  The right answer is 
to change the architecture of the application to not run with 5000 
unique processes.

		-ben
