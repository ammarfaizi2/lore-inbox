Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUIIX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUIIX7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUIIX7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:59:38 -0400
Received: from holomorphy.com ([207.189.100.168]:40884 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266867AbUIIX7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:59:16 -0400
Date: Thu, 9 Sep 2004 16:59:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheline align pagevec structure
Message-ID: <20040909235903.GQ3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909221238.GA6182@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909221238.GA6182@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 04:09:05PM -0700, William Lee Irwin III wrote:
>> Reducing arrival rates by an Omega(NR_CPUS) factor would probably help,
>> though that may blow the stack on e.g. larger Altixen. Perhaps
>> O(lg(NR_CPUS)), e.g. NR_CPUS > 1 ? 4*lg(NR_CPUS) : 4 etc., will suffice,
>> though we may have debates about how to evaluate lg(n) at compile-time...
>> Would be nice if calls to sufficiently simple __attribute__((pure))
>> functions with constant args were considered constant expressions by gcc.

On Thu, Sep 09, 2004 at 07:12:38PM -0300, Marcelo Tosatti wrote:
> Let me see if I get you right - basically what you're suggesting is 
> to depend PAGEVEC_SIZE on NR_CPUS?

Yes. The motive is that as the arrival rate is O(num_cpus_online()), and
NR_CPUS is supposed to be strongly correlated with that, so reducing the
arrival rate by a (hopefully) similar factor ought to help.


-- wli
