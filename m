Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUIIXJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUIIXJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUIIXJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:09:14 -0400
Received: from holomorphy.com ([207.189.100.168]:20404 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266798AbUIIXJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:09:09 -0400
Date: Thu, 9 Sep 2004 16:09:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheline align pagevec structure
Message-ID: <20040909230905.GO3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909155226.714dc704.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>> I do not see a problem with changing pagevec to "15" page pointers either, 
>> Andrew, is there a special reason for that "16"? Is intentional to align
>> to 64 kbytes (IO device alignment)? I dont think that matters much because
>> of the elevator which sorts and merges requests anyway?

On Thu, Sep 09, 2004 at 03:52:26PM -0700, Andrew Morton wrote:
> No, it was just a randomly-chosen batching factor.
> The tradeoff here is between
> a) lock acquisition frequency versus lock hold time (increasing the size
>    helps).
> b) icache misses versus dcache misses. (increasing the size probably hurts).
> I suspect that some benefit would be seen from making the size very small
> (say, 4). And on some machines, making it larger might help.

Reducing arrival rates by an Omega(NR_CPUS) factor would probably help,
though that may blow the stack on e.g. larger Altixen. Perhaps
O(lg(NR_CPUS)), e.g. NR_CPUS > 1 ? 4*lg(NR_CPUS) : 4 etc., will suffice,
though we may have debates about how to evaluate lg(n) at compile-time...
Would be nice if calls to sufficiently simple __attribute__((pure))
functions with constant args were considered constant expressions by gcc.

-- wli
