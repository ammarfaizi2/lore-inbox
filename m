Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVANRD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVANRD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVANRDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:03:15 -0500
Received: from colin2.muc.de ([193.149.48.15]:61703 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262022AbVANRBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:01:41 -0500
Date: 14 Jan 2005 18:01:40 +0100
Date: Fri, 14 Jan 2005 18:01:40 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-ID: <20050114170140.GB4634@muc.de>
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com> <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com> <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com> <20050114043944.GB41559@muc.de> <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looked at  arch/i386/lib/mmx.c. It avoids the mmx ops in an interrupt
> context but the rest of the prep for mmx only saves the fpu state if its
> in use. So that code would only be used rarely. The mmx 64 bit
> instructions seem to be quite fast according to the manual. Double the
> cycles than the 32 bit instructions on Pentium M (somewhat higher on Pentium 4).

With all the other overhead (disabling exceptions, saving register etc.)
will be likely slower. Also you would need fallback paths for CPUs 
without MMX but with PAE (like Ppro). You can benchmark
it if you want, but I wouldn't be very optimistic. 

-Andi
