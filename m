Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264859AbUD2VYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264859AbUD2VYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUD2VVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:21:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:54502 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264980AbUD2VSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:18:17 -0400
Date: Thu, 29 Apr 2004 14:19:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429141947.1ff81104.akpm@osdl.org>
In-Reply-To: <20040429133613.791f9f9b.pj@sgi.com>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > How on earth is the kernel supposed to know that for this one particular
> > job you don't care if it takes 3 hours instead of 10 minutes,
> 
> I'd pay ten bucks (yeah, I'm a cheapskate) for an option that I could
> twiddle that would mark my nightly updatedb and backup jobs as ones to
> use reduced memory footprint (both for file caching and backing user
> virtual address space), even if it took much longer.
> 
> So, rather than protest in mock outrage that it's impossible for the
> kernel to know this, instead answer the question as stated in all
> seriousness ... well ... how _could_ the kernel know, and what _could_
> the kernel do if it knew.  What mechanism(s) would be needed so that
> the kernel could restrict a jobs memory usage?

Two things:

a) a knob to say "only reclaim pagecache".  We have that now.

b) a knob to say "reclaim vfs caches harder".  That's simply a matter of boosting
   the return value from shrink_dcache_memory() and perhaps shrink_icache_memory().

It's not quite what you're after, but it's close.
