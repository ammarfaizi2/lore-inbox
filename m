Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUIIXGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUIIXGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUIIXGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:06:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19079 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266741AbUIIXGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:06:05 -0400
Date: Thu, 9 Sep 2004 18:41:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheline align pagevec structure
Message-ID: <20040909214113.GB5723@logos.cnet>
References: <20040909163929.GA4484@logos.cnet> <20040909154906.57f9391b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909154906.57f9391b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 03:49:06PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > Right now it is 140 bytes on 64-bit and 72 bytes on 32-bit. Thats just a little bit more 
> > than a power of 2 (which will cacheline align), so shrink it to be aligned: 64 bytes on 
> > 32bit and 124bytes on 64-bit. 
> > 
> > It now occupies two cachelines most of the time instead of three. 
> > 
> > I changed nr and cold to "unsigned short" because they'll never reach 2 ^ 16.
> > 
> > I do not see a problem with changing pagevec to "15" page pointers either, 
> > Andrew, is there a special reason for that "16"? Is intentional to align
> > to 64 kbytes (IO device alignment)? I dont think that matters much because
> > of the elevator which sorts and merges requests anyway?
> > 
> > 
> > 
> > Did some reaim benchmarking on 4way PIII (32byte cacheline), with 512MB RAM:
> > 
> > #### stock 2.6.9-rc1-mm4 ####
> > 
> > Peak load Test: Maximum Jobs per Minute 4144.44 (average of 3 runs)
> > Quick Convergence Test: Maximum Jobs per Minute 4007.86 (average of 3 runs)
> > 
> > Peak load Test: Maximum Jobs per Minute 4207.48 (average of 3 runs)
> > Quick Convergence Test: Maximum Jobs per Minute 3999.28 (average of 3 runs)
> > 
> > #### shrink-pagevec #####
> > 
> > Peak load Test: Maximum Jobs per Minute 4717.88 (average of 3 runs)
> > Quick Convergence Test: Maximum Jobs per Minute 4360.59 (average of 3 runs)
> > 
> > Peak load Test: Maximum Jobs per Minute 4493.18 (average of 3 runs)
> > Quick Convergence Test: Maximum Jobs per Minute 4327.77 (average of 3 runs)
> 
> I think the patch make sense, but I'm very sceptical about the benchmarks
> ;)

Why's that? You think changing to the number of pages in the pagevec to "15" instead
"16" is the cause?

Or that the performance increase is not a direct effect of the one cacheline 
saved per pagevec instance?

Or you think such benchmark is too specific to be interpreted as a broad
vision of performance? 

:)

