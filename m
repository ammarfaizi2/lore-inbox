Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270977AbUJVDh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270977AbUJVDh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270976AbUJVDdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:33:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:42443 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271198AbUJVD24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:28:56 -0400
Date: Thu, 21 Oct 2004 20:26:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@novell.com, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-Id: <20041021202656.08788551.akpm@osdl.org>
In-Reply-To: <417879FB.5030604@yahoo.com.au>
References: <20041021011714.GQ24619@dualathlon.random>
	<417728B0.3070006@yahoo.com.au>
	<20041020213622.77afdd4a.akpm@osdl.org>
	<417837A7.8010908@yahoo.com.au>
	<20041021224533.GB8756@dualathlon.random>
	<41785585.6030809@yahoo.com.au>
	<20041022011057.GC14325@dualathlon.random>
	<20041021182651.082e7f68.akpm@osdl.org>
	<417879FB.5030604@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Andrea Arcangeli <andrea@novell.com> wrote:
> > 
> >>I'm still unsure if the 2.6 lower_zone_protection completely mimics the
> >> 2.4 lowmem_zone_reserve algorithm if tuned by reversing the pages_min
> >> settings accordingly, but I believe it's easier to drop it and replace
> >> with a clear understandable API that as well drops the pages_min levels
> >> that have no reason to exists anymore
> > 
> > 
> > I'd be OK with wapping over to the watermark version, as long as we have
> > runtime-settable levels.
> > 
> 
> Please no "wapping" over :) This release is the first time the allocator
> has been anywhere near working properly in this area.
> 
> Of course, if Andrea shows that the ->protection racket isn't sufficient,
> then yeah.

Well yes, I spose the answer as always is "show me a testcase".  But the
lack of reports from the field has weight.

> > But I'd be worried about making the default values anything other than zero
> > because nobody seems to be hitting the problems.
> > 
> > But then again, this get discussed so infrequently that by the time it
> > comes around again I've forgotten all the previous discussion.  Ho hum.
> > 
> 
> I think they probably should be turned on. A system with a gig of ram
> shouldn't be able to use up all of ZONE_DMA on pagecache. It seems like
> a small price to pay... same goes for very big highmem systems and ZONE_NORMAL.

Problem is, how much lower zone memory do you reserve?  If someone is
really getting hit by this in real life then the answer for their workload
is probably "lots".  If they are not getting hit then the answer is "none".

Any halfway setting will screw everyone.

