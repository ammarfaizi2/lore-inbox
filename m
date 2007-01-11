Return-Path: <linux-kernel-owner+w=401wt.eu-S965328AbXAKHyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbXAKHyJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbXAKHyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:54:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:16926 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965328AbXAKHyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:54:06 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VkHtjSZbaPBbyAyXx71nfJauDSycwDRAe/Pb982pkGKPtRmFb1h4RxGTyiv5RFiD8OGd4yeuKbT7uod3lIyUsvzjG4Lwl0aGO+1jjXZrNSRCM6Ss5txXYNXJVL+/jXg+33ZnWI/1DrNK3FPy3rbGcXwDm0ZSikjAEVxezV3V2gw=
Message-ID: <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
Date: Thu, 11 Jan 2007 15:54:05 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: O_DIRECT question
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Hua Zhong" <hzhong@gmail.com>, "Hugh Dickins" <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
In-Reply-To: <45A5E1B2.2050908@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
	 <20070110220603.f3685385.akpm@osdl.org>
	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
	 <20070110225720.7a46e702.akpm@osdl.org>
	 <45A5E1B2.2050908@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Andrew Morton wrote:
> > On Thu, 11 Jan 2007 14:45:12 +0800
> > Aubrey <aubreylee@gmail.com> wrote:
> >
> >
> >>>In the interim you could do the old "echo 3 > /proc/sys/vm/drop_caches"
> >>>thing, but that's terribly crude - drop_caches is really only for debugging
> >>>and benchmarking.
> >>>
> >>
> >>Yes. This method can drop caches, but will fragment memory.
> >
> >
> > That's what page reclaim will do as well.
> >
> > What you want is Mel's antifragmentation work, or lumpy reclaim.
> >
> >
> >>This is
> >>not what I want. I want cache is limited to a tunable value of the
> >>whole memory. For example, if total memory is 128M, is there a way to
> >>trigger reclaim when cache size > 16M?
> >
> >
> > If there was, it'd "fragment memory" as well.
> >
> > You might get a little benefit from increasing /proc/sys/vm/min_free_kbytes,
> > but not much.  Some page allocation tweaks would aid that.
> >
> > But basically, to do this well, serious work is needed.
>
> OTOH, the antifragmentation stuff can also break down eventually,
> especially if higher order allocations are actually in common use.

That's right. When VFS cache eat up almost all of the memory, I think
no memory algorithm can help the case, including Mei's anti-fragment
patch.

>
> What you _really_ want to do is avoid large mallocs after boot, or use
> a CPU with an mmu. I don't think nommu linux was ever intended to be a
> simple drop in replacement for a normal unix kernel.

Is there a position available working on mmu CPU? Joking, :)
Yes, some problems are serious on nommu linux. But I think we should
try to fix them not avoid them.

-Aubrey
