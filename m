Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264738AbTFFIDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 04:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbTFFIDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 04:03:42 -0400
Received: from angband.namesys.com ([212.16.7.85]:9104 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S264738AbTFFIDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 04:03:40 -0400
Date: Fri, 6 Jun 2003 12:17:12 +0400
From: Oleg Drokin <green@namesys.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030606081712.GA27663@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030524111608.GA4599@alpha.home.local> <20030605170551.3d61b0d4.skraw@ithnet.com> <20030605181423.GA17277@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605181423.GA17277@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jun 05, 2003 at 08:14:23PM +0200, Willy Tarreau wrote:
> > It took some days to produce output for my freezing problem. This one is rc7+aic20030603:
> Good !
> It seems that it crashed in the reiserfs code rather than in aic7xxx ! perhaps
> you hit 2 different bugs, or perhaps there's a race that only newer code can
> trigger, or there's a leak somewhere. You may want to forward the oops to the
> reiserfs team too.

No, it did crashed in allocation code (you skipped one trace line):
Jun  5 16:53:55 admin kernel: Call Trace:    [__kmem_cache_alloc+107/304] [kmem_cache_grow+508/624] [__kmem_cache_alloc+125/304]
+[get_mem_for_virtual_node+87/224] [fix_nodes+198/1008]

And the EIP is in kmem_cache_alloc_batch, sounds like it tripped on bad pointer or something like this.
So something is corrupting slab lists it seems.

Bye,
    Oleg
