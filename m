Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293395AbSCEPtA>; Tue, 5 Mar 2002 10:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293396AbSCEPsl>; Tue, 5 Mar 2002 10:48:41 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12908 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293395AbSCEPsT>; Tue, 5 Mar 2002 10:48:19 -0500
Date: Tue, 5 Mar 2002 16:43:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305164343.H20606@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44L.0203050921510.1413-100000@duckman.distro.conecti <830115452.1015313350@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830115452.1015313350@[10.10.2.3]>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 07:29:11AM -0800, Martin J. Bligh wrote:
> --On Tuesday, March 05, 2002 9:22 AM -0300 Rik van Riel 
> <riel@conectiva.com.br> wrote:
> 
> >On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> >>On Mon, Mar 04, 2002 at 10:26:30PM -0300, Rik van Riel wrote:
> >>> On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> >>> > On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
> >>> > > This could be expressed as:
> >>> > >
> >>> > > "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
> >>> > > "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA
> >
> >>the example you made doesn't have highmem at all.
> >>
> >>> has 1 ZONE_NORMAL and 1 ZONE_DMA while it has multiple
> >>> HIGHMEM zones...
> >>
> >>it has multiple zone normal and only one zone dma. I'm not forgetting
> >>that.
> >
> >Your reality doesn't seem to correspond well with NUMA-Q
> >reality.
> 
> I think the difference is that he has a 64 bit vaddr space,
> and I don't ;-) Thus all mem to him is ZONE_NORMAL (not sure
> why he still has a ZONE_DMA, unless he reused it for the 4Gb
> boundary). Andrea, is my assumtpion correct?

correct, but the current code from SGI should be just fine for NUMA-Q
too, if you've highmem, your zonelist will automatically be setup
accordingly, I don't see problems there.

> 
> On a 32 bit arch (eg ia32) everything above 896Mb (by default)
> is ZONE_HIGHMEM. Thus if I have > 896Mb in the first node,
> I will have one ZONE_NORMAL in node 0, and a ZONE_HIGHMEM
> in every node. If I have < 896Mb in the first node, then
> I have a ZONE_NORMAL in every node up to and including the
> 896 breakpoint, and a ZONE_HIGHMEM in every node from the
> breakpoint up (including the breakpoint node). Thus the number
> of zones = number of nodes + 1.
> 
> M.


Andrea
