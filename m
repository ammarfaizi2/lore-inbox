Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVJaU7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVJaU7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVJaU7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:59:05 -0500
Received: from xenotime.net ([66.160.160.81]:16580 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932494AbVJaU7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:59:04 -0500
Date: Mon, 31 Oct 2005 12:59:01 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alexandre Oliva <aoliva@redhat.com>
cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: amd64 bitops fix for -Os
In-Reply-To: <or4q6xv39r.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0510311255230.21927@shark.he.net>
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
 <4366533C.1010809@linux.intel.com> <or4q6xv39r.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Alexandre Oliva wrote:

> On Oct 31, 2005, Randy Dunlap <randy_d_dunlap@linux.intel.com> wrote:
>
> >> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
>
> > Possibly Andrew or Andi have already merged this into their trees.
> > However, I have a few comments on the patch re Linux style.
> > They are meant to help inform you and others -- that's all.
>
> Thanks, I didn't realized I'd deviated from the recommended style.  In
> this updated version of the patch, I've removed the ifdefs that could
> sanity-check arguments to the exported entry points and adjusted the
> comments to follow the guidelines.
>
> >> --- arch/x86_64/lib/bitops.c~	2005-10-27 22:02:08.000000000 -0200
> >> +++ arch/x86_64/lib/bitops.c	2005-10-29 18:24:27.000000000 -0200
>
> > Diffs should start with a top-level names (even if it's entirely
> > phony), so that they can be applied with many scripts that are around
> > and expect that.
>
> I hope you mean -p1 vs -p0.  I tend to prefer -p0 myself, but quilt
> makes it easy enough to handle either :-)  Fixed in the revised
> version.

Yes, that's all that I meant.

> >> -inline long find_first_zero_bit(const unsigned long * addr, unsigned long size)
> >> +static inline long
> >> +__find_first_zero_bit(const unsigned long * addr, unsigned long size)
>
> > The only good reason for splitting a function header is if it would
> > otherwise be > 80 columns, not just to put the function name at the
> > beginning of the line.
>
> In this case, it would, because I'm adding static and two leading
> underscores.  But I'll keep that in mind, since this is quite
> different from the GCC style.
>
> >> +		 /* Any register here would do, but GCC tends to
> >> +		    prefer rbx over rsi, even though rsi is readily
> >> +		    available and doesn't have to be saved.  */
> >> +		 [addr] "S" (addr) : "memory");
>
> > Comment in the middle of the difficult-to-read asm instruction in
> > undesirable (IMO).
>
> I hope it is as useful after the statement.  Moving it before it would
> move it too far apart from what it refers to IMHO.
>
> Thanks again for the style feedback, it's really appreciated.

and thanks for the changes too.

> Should I have retained the problem description in the patch file, or
> is the Signed-off-by: line enough?

There should be a short problem description in the patch
(before the SOB: line).

See Documentation/SubmittingPatches
or <http://linux.yyz.us/patch-format.html>
or <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt> .

-- 
~Randy
