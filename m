Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVDGRKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVDGRKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVDGRKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:10:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33226 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262481AbVDGRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:10:08 -0400
Date: Thu, 7 Apr 2005 18:10:07 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 08:32:04AM -0700, Linus Torvalds wrote:
> Also, there's actually a second reason why I've decided that cherry-
> picking is wrong, and it's non-technical. 
> 
> The thing is, cherry-picking very much implies that the people "up" the 
> foodchain end up editing the work of the people "below" them. The whole 
> reason you want cherry-picking is that you want to fix up somebody elses 
> mistakes, ie something you disagree with.

No.  There's another reason - when you are cherry-picking and reordering
*your* *own* *patches*.  That's what I had been unable to explain to
Larry and that's what made BK unusable for me.

As for the immutable history...  Ever had to read or grade students'
homework?
	* the dumbest kind: "here's an answer <expression>, whaddya
mean 'where's the solution'?".
	* next one: "here's how I've solved the problem: <pages of text
documenting the attempts, with many 'oops, there had been a mistake,
here's how we fix it'>".  
	* what you really want to see: series of steps leading to answer,
with clean logical structure that allows to understand what's being
done and verify correctness.

The first corresponds to "here's a half-meg of patch, it fixes everything".
The second is chronological history (aka "this came from our CVS, all bugs
are fixed by now, including those introduced in the middle of it; see
CVS history for details").  The third is a decent patch series.

And to get from "here's how I came up to solution" to "here's a clean way
to reach the solution" you _have_ to reorder.  There's also "here are
misc notes from today, here are misc notes from yesterday, etc." and to
get that into sane shape you will need to split, reorder and probably
collapse several into combined delta (possibly getting an empty delta
as the result, if later ones negate the prior).

The point being, both history and well, publishable result can be expressed
as series of small steps, but they are not the same thing.  So far all I've
seen in the area (and that includes BK) is heavily biased towards history part
and attempts to use this stuff for manipulating patch series turn into fighting
the tool.

I'd *love* to see something that can handle both - preferably with
history of reordering, etc. being kept.  IOW, not just a tree of changesets
but a lattice - with multiple paths leading to the same node.  So far
I've seen nothing of that kind ;-/
