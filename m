Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKMBJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKMBJm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKMBJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:09:42 -0500
Received: from ns2.suse.de ([195.135.220.15]:17029 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750746AbVKMBJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:09:41 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com> <43722AFC.4040709@pobox.com>
	<Pine.LNX.4.58.0511090904320.4001@shark.he.net>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2005 02:09:35 +0100
In-Reply-To: <Pine.LNX.4.58.0511090904320.4001@shark.he.net>
Message-ID: <p73u0eh4als.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> On Wed, 9 Nov 2005, Jeff Garzik wrote:
> 
> > Jan Beulich wrote:
> > > The following patch set represents the Novell Linux Kernel Debugger,
> > > stripped off of its original low-level exception handling framework.
> >
> >
> > Honestly, just seeing all these code changes makes me think we really
> > don't need it in the kernel.  How many "early" and "alternative" gadgets
> > do we really need just for this thing?
> 
> On the surface I have to agree.  However, if Jan wants feedback
> on the patches, that's a reasonable request IMO.
> (but they need to be readable via email so that someone
> can comment on them)
> 
> At a quick blush, I would guess it has as much chance as
> kdb does (or did) for merging.

I hope we can follow the same strategy as I did for debuggers on x86-64 - 
which imho worked very well. Get all the (sane) hooks in so that everybody
who wants to use their particular flavour of debugger can use it 
by (ideally) either just loading it or alternatively applying a small
core patch and the debugger files elsewhere. The die chains started
from that. 

Making the debugger work modular is a bit more work, but possible (was
done for kdb at least before with some changes). IMHO that's the ideal
state for users - they can just compile it externally and load it when
they need it, but the core kernel doesn't need to carry it. It
conflicts a bit with the usual policy of not exporting stuff that's
not used in the core kernel; but I think making an exception here is
reasonable because

So I guess it's best to concentrate on merging the hooks needed in a sane
way. 

I think the many additions for "early" code in the NLKD patchkit
comes from Jan's desire to make the debugger work in as many weird
corner cases as possible. I must say he found a lot of problems in 
corner cases during that work in x86-64 and i386, fixing generic
bugs and making even the standard oops code and other error handling
code (e.g. double faults on i386) more reliable, which I appreciate. 

The particular early changes have to be weighted of course in
intrusiveness. If it's simple and not too ugly stuff I guess it is
reasonable to consider it. If not the debugger will have
to live without it.

I already merged all the changes that looked good (and where I was cc'ed) 
for x86-64 now. Some patches need changes, and I guess with that
feedback the i386 part can be similarly adjusted.

-Andi
