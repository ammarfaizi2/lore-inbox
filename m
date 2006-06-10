Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWFJFnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWFJFnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWFJFnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:43:47 -0400
Received: from fmr18.intel.com ([134.134.136.17]:16872 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932389AbWFJFnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:43:46 -0400
Date: Fri, 9 Jun 2006 22:41:12 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Matthew Wilcox <matthew@wil.cx>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Continuation Inodes Explained! (was Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3)
Message-ID: <20060610054111.GN10524@goober>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net> <20060609153116.GM1651@parisc-linux.org> <20060610032623.GG10524@goober> <20060610052502.GY5964@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610052502.GY5964@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:25:02PM -0600, Andreas Dilger wrote:
> 
> The 48-bit support was acutally only a small of the originalreason for
> extents, while it seems to be the most popular right now.

*nod*

> This needs some extra data in the directory entry, which I've already
> been thinking about for ext3, so if you are looking at implementing
> this for ext3 I'd be happy to share some ideas.

Actually, it seems vaguely possible this could be implemented as a
layer on top of any normal file system - just use files to store
continuation inodes and the like.  Then you could use the file system
that best suits your workload underneath. (Suparna has a paper in the
next OLS talking about something related but not identical, check it
out.) Most likely it would be criminally wasteful of space and really
slow, but it's something to think about.

> > One interesting possibility would be to combine this with the ext2
> > dirty bit patches.
> 
> Put on your asbestos vest before suggesting any changes to ext2 :-).

*laugh* What about ext2.5? :) Seriously, ext2 needs to be left alone,
but I'm open to the possibility that any of the existing file system
code bases could be forked off into a development file system.  Some
ideas would be more compatible with some code bases than others, and
forking might get rid of some constraints - e.g., an XFS fork could
get rid of a lot of crufty compat code.

-VAL
