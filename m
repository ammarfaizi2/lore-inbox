Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289917AbSAWRNt>; Wed, 23 Jan 2002 12:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSAWRNj>; Wed, 23 Jan 2002 12:13:39 -0500
Received: from dsl-213-023-038-076.arcor-ip.net ([213.23.38.76]:5018 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289917AbSAWRN2>;
	Wed, 23 Jan 2002 12:13:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, Hans Reiser <reiser@namesys.com>
Subject: Re: Possible Idea with filesystem buffering.
Date: Wed, 23 Jan 2002 18:16:58 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com> <3C4DCC49.1080202@namesys.com> <2116720000.1011733708@tiny>
In-Reply-To: <2116720000.1011733708@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16TR18-00020Z-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 22, 2002 10:08 pm, Chris Mason wrote:
> On Tuesday, January 22, 2002 11:32:09 PM +0300 Hans Reiser wrote:
> >> Its not about the cost of a function call, it's what the FS does to make
> >> that call useful.  Pretend for a second the VM tells the FS everything it
> >> needs to know to age a page (whatever scheme the FS wants to use).
> >> 
> >> Then pretend the VM decides there's memory pressure, and tells the FS
> >> subcache to start freeing ram.  So, the FS goes through its list of pages
> >> and finds the most suitable one for flushing, but it has no idea how
> >> suitable that page is in comparison with the pages that don't belong to
> >> that FS (or even other pages from different mount points of the same FS
> >> flavor).
> > 
> > Why does it need to know how suitable it is compared to the other
> > subcaches?  It just ages X pages, and depends on the VM to determine how
> > large X is.  The VM pressures subcaches in proportion to their size, it
> > doesn't need to know  how suitable one page is compared to another, it
> > just has a notion of push on everyone in proportion to their size.
> 
> If subcache A has 1000 pages that are very very active, and subcache B has
> 500 pages that never ever get used, should A get twice as much memory
> pressure?  That's what we want to avoid, and I don't see how subcaches
> allow it.

This question at least is not difficult.  Pressure (for writeout) should be 
applied to each subcache in proportion to its portion of all inactive, dirty 
pages in the system.

--
Daniel
