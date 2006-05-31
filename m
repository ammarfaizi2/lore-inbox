Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWEaSUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWEaSUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWEaSUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:20:21 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:18836 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751772AbWEaSUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:20:20 -0400
Date: Wed, 31 May 2006 20:20:19 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE
Message-ID: <20060531182019.GA26456@janus>
References: <20060531094626.GA23156@janus> <447DAEC9.3050003@trash.net> <20060531160611.GA25637@janus> <447DC613.10102@trash.net> <20060531172936.GB25788@janus> <447DD66C.30605@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447DD66C.30605@trash.net>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 07:46:20PM +0200, Patrick McHardy wrote:
> Frank van Maarseveen wrote:
> > On Wed, May 31, 2006 at 06:36:35PM +0200, Patrick McHardy wrote:
> > 
> >>The messages might get dropped when the output queue is full.
> >>Does one of the drop counters shown by "ip -s link list"
> >>and "tc -s -d qdisc show" increase (the other counts might also
> >>give some clues)? Otherwise please apply the attached patch
> >>(should fix tcpdump, last patch was incomplete) and post a dump.
> > 
> > 
> > No visible improvement with the new patch.
> 
> Does this mean tcpdump doesn't show any packets?

tcpdump output is consistent with what the netconsole receiver sees: 9
packets are still missing. I know there are 9 because 2.6.13.2 shows them.

The two patches behaved identically for me.

> 
> > ip -s link doesn't show any
> > dropped packets so far with any patch and I don't use traffic control
> > that I'm aware of. But I'm not sure what to make of "tc" output, maybe
> > because CONFIG_SHAPER is not set:
> > 
> > 	# tc -s -d qdisc show
> > 	RTNETLINK answers: Invalid argument
> > 	Dump terminated
> 
> Thats because you're missing CONFIG_NET_SCHED. Please enable it and
> try the tc command again, without it we can't see whether the qdisc
> (which is present even without CONFIG_NET_SCHED) just dropped the
> packets.

I'll try that tomorrow.

-- 
Frank
