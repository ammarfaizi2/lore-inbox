Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSJVQEM>; Tue, 22 Oct 2002 12:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSJVQEM>; Tue, 22 Oct 2002 12:04:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1722 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261504AbSJVQEL>; Tue, 22 Oct 2002 12:04:11 -0400
Date: Tue, 22 Oct 2002 14:09:47 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
In-Reply-To: <2629464880.1035240956@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Martin J. Bligh wrote:

> > I will agree with that if everything works so the sharing happens,
> > this is a nice feature.
>
> I think it will for most of the situations we run aground with now
> (normally 5000 oracle tasks sharing a 2Gb shared segment, or some
> such monster).

10 GB pagetable overhead, for 2 GB of data.  No customer I
know would accept that much OS overhead.

To reduce the overhead we could either reclaim the page
tables and reconstruct them when needed (lots of work) or
we could share the page tables (less runtime overhead).

> >> The ultimate solution is per-object reverse mappings, rather than per
> >> page, but that's a 2.7 thingy now.
> > ???
> >
> > Last I checked we already had those in 2.4.x, and still in 2.5.x.  The
> > list of place the address space is mapped.
>
> It's more complicated than that ... I'll let Rik or one of the K42
> guys who understand it better than I do explain it (yeah, I'm
> wimping out on you ;-))

Actually, per-object reverse mappings are nowhere near as good
a solution as shared page tables.  At least, not from the points
of view of space consumption and the overhead of tearing down
the mappings at pageout time.

Per-object reverse mappings are better for fork+exec+exit speed,
though.

It's a tradeoff: do we care more for a linear speedup of fork(),
exec() and exit() than we care about a possibly exponential
slowdown of the pageout code ?

(note that William Irwin and myself have a trick to turn the
possible exponential slowdown of the pageout code into something
better ... just a few details left)

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

