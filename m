Return-Path: <linux-kernel-owner+w=401wt.eu-S1030488AbXALFWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbXALFWR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160997AbXALFWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:22:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:24239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030488AbXALFWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:22:16 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f0i3iLv1IJ/Dmk8LAA0jGViOkOz78Xph4RxG4+nHJ564H6WlDrIKBxImsy4cpPXIxk3aQKPZShMcu2164qziauuspAXqcSozpeGHIvsghvra99Ou92YJMWYZulrcPdvnw74kMXCRcPIlJgw46Rin6pcCuGR1Lj+ppRXqcQuGOlI=
Message-ID: <6d6a94c50701112122l66a4866bg548009dddb806434@mail.gmail.com>
Date: Fri, 12 Jan 2007 13:22:03 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: O_DIRECT question
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Bill Davidsen" <davidsen@tmr.com>,
       "Andrew Morton" <akpm@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
In-Reply-To: <45A714F8.6020600@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
	 <20070110225720.7a46e702.akpm@osdl.org>
	 <45A5E1B2.2050908@yahoo.com.au>
	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
	 <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com>
	 <45A70EF9.40408@yahoo.com.au>
	 <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org>
	 <45A714F8.6020600@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Linus Torvalds wrote:
> >
> > On Fri, 12 Jan 2007, Nick Piggin wrote:
> >
> >>We are talking about about fragmentation. And limiting pagecache to try to
> >>avoid fragmentation is a bandaid, especially when the problem can be solved
> >>(not just papered over, but solved) in userspace.
> >
> >
> > It's not clear that the problem _can_ be solved in user space.
> >
> > It's easy enough to say "never allocate more than a page". But it's often
> > not REALISTIC.
>  >
> > Very basic issue: the perfect is the enemy of the good. Claiming that
> > there is a "proper solution" is usually a total red herring. Quite often
> > there isn't, and the "paper over" is actually not papering over, it's
> > quite possibly the best solution there is.
>
> Yeah *smallish* higher order allocations are fine, and we use them all the
> time for things like stacks or networking.
>
> But Aubrey (who somehow got removed from the cc list) wants to do order 9
> allocations from userspace in his nommu environment. I'm just trying to be
> realistic when I say that this isn't going to be robust and a userspace
> solution is needed.
>
Hmm..., aside from big order allocations from user space, if there is
a large application we need to run, it should be loaded into the
memory, so we have to allocate a big block to accommodate it. kernel
fun like load_elf_fdpic_binary() etc will request contiguous memory,
then if vfs eat up free memory, loading fails.

-Aubrey
