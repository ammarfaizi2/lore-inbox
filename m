Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUCWD73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 22:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCWD72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 22:59:28 -0500
Received: from holomorphy.com ([207.189.100.168]:2451 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261932AbUCWD71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 22:59:27 -0500
Date: Mon, 22 Mar 2004 19:59:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040323035921.GZ2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040320000235.5e72040a.pj@sgi.com> <20040320111340.GA2045@holomorphy.com> <20040322171243.070774e5.pj@sgi.com> <20040323020940.GV2045@holomorphy.com> <20040322183918.5e0f17c7.pj@sgi.com> <20040323031345.GY2045@holomorphy.com> <20040322193628.4278db8c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322193628.4278db8c.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> gcc flat out miscompiled such inlines last I checked (Zwane shipped the
>> bugreport IIRC).

On Mon, Mar 22, 2004 at 07:36:28PM -0800, Paul Jackson wrote:
> The one error I've heard tell of recently is one that Andi Kleen hit in
> include/linux/bitmap.h.  He had to compute the copy length explicitly in
> a separate variable, or gcc forgot to do it (I forget the details).  The
> change is:
>  static inline void bitmap_copy(unsigned long *dst,
>                         const unsigned long *src, int bits)
>  {
> -       memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
> +       int len = BITS_TO_LONGS(bits)*sizeof(unsigned long);
> +       memcpy(dst, src, len);
>  }
> Do you have any more pointers/info on the miscompile you quote above?
> Like - how long ago - what gcc version ...

It dates back to before the merge. It should have been posted to lkml
by Zwane.


On Mon, Mar 22, 2004 at 07:36:28PM -0800, Paul Jackson wrote:
> It would be an insult to wrap the entire cpumask design around the
> axle of such non-specific allegations of gcc misconduct.  Better to
> get the API right, and then deal with specific tool bugs as necessary.
> Or, as Linus might say (did say, in a quite different context):
>   Never _ever_ make your source-code look worse because your tools suck. Fix
>   the tools instead.

I can't answer this directly. Basically, if ppl are merging workarounds
for ancient compilers, my expectation is that operational semantics
specific to newer compiler versions (or specific architectures) can't
be assumed. I'm not the one making the calls as to whether the
requirements (compiling out completely on UP, compiling to no indirection
on small SMP) are relaxed or if "new enough compiler" meets them.


-- wli
