Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUIIWpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUIIWpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUIIWp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:45:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:29621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266684AbUIIWpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:45:22 -0400
Date: Thu, 9 Sep 2004 15:49:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheline align pagevec structure
Message-Id: <20040909154906.57f9391b.akpm@osdl.org>
In-Reply-To: <20040909163929.GA4484@logos.cnet>
References: <20040909163929.GA4484@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Right now it is 140 bytes on 64-bit and 72 bytes on 32-bit. Thats just a little bit more 
> than a power of 2 (which will cacheline align), so shrink it to be aligned: 64 bytes on 
> 32bit and 124bytes on 64-bit. 
> 
> It now occupies two cachelines most of the time instead of three. 
> 
> I changed nr and cold to "unsigned short" because they'll never reach 2 ^ 16.
> 
> I do not see a problem with changing pagevec to "15" page pointers either, 
> Andrew, is there a special reason for that "16"? Is intentional to align
> to 64 kbytes (IO device alignment)? I dont think that matters much because
> of the elevator which sorts and merges requests anyway?
> 
> 
> 
> Did some reaim benchmarking on 4way PIII (32byte cacheline), with 512MB RAM:
> 
> #### stock 2.6.9-rc1-mm4 ####
> 
> Peak load Test: Maximum Jobs per Minute 4144.44 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 4007.86 (average of 3 runs)
> 
> Peak load Test: Maximum Jobs per Minute 4207.48 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 3999.28 (average of 3 runs)
> 
> #### shrink-pagevec #####
> 
> Peak load Test: Maximum Jobs per Minute 4717.88 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 4360.59 (average of 3 runs)
> 
> Peak load Test: Maximum Jobs per Minute 4493.18 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 4327.77 (average of 3 runs)

I think the patch make sense, but I'm very sceptical about the benchmarks
;)

