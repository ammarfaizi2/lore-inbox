Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319464AbSILH0Z>; Thu, 12 Sep 2002 03:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319466AbSILH0Z>; Thu, 12 Sep 2002 03:26:25 -0400
Received: from puerco.nm.org ([129.121.1.22]:27920 "HELO puerco.nm.org")
	by vger.kernel.org with SMTP id <S319464AbSILH0Y>;
	Thu, 12 Sep 2002 03:26:24 -0400
Date: Thu, 12 Sep 2002 01:28:34 -0600 (MDT)
From: Todd Underwood <todd@osogrande.com>
X-X-Sender: todd@gp
To: "David S. Miller" <davem@redhat.com>
cc: "hadi@cyberus.ca" <hadi@cyberus.ca>,
       "tcw@tempest.prismnet.com" <tcw@tempest.prismnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <20020905.204721.49430679.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209120119580.25406-100000@gp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folx,

sorry for the late reply.  catching up on kernel mail.

so all this TSO stuff looks v. v. similar to the IP-only fragmentation 
that patricia gilfeather and i implemented on alteon acenics a couple of 
years ago (see http://www.cs.unm.edu/~maccabe/SSL/frag/FragPaper1/ for a 
general overview).  it's exciting to see someone else take a stab on 
different hardware and approaching some of the tcp-specific issues.

the main different, though, is that general purpose kernel development 
still focussed on the improvements in *sending* speed.  for real high 
performance networking, the improvements are necessary in *receiving* cpu 
utilization, in our estimation. (see our analysis of interrupt overhead 
and the effect on receivers at gigabit speeds--i hope that this has become 
common understanding by now)

i guess i can't disagree with david miller that the improvments in TSO are 
due entirely to header retransmission for sending, but that's only because 
sending wasn't CPU-intensive in the first place.  we were able to get a 
significant reduction in receiver cpu-utilization by reassembling IP 
fragments on the receiver side (sort of a standards-based interrupt 
mitigation strategy that has the benefit of not increasing latency the way 
interrupt coalescing does).

anyway, nice work, 

t.

On Thu, 5 Sep 2002, David S. Miller wrote:

> It's the DMA bandwidth saved, most of the specweb runs on x86 hardware
> is limited by the DMA throughput of the PCI host controller.  In
> particular some controllers are limited to smaller DMA bursts to
> work around hardware bugs.
> 
> Ie. the headers that don't need to go across the bus are the critical
> resource saved by TSO.
> 
> I think I've said this a million times, perhaps the next person who
> tries to figure out where the gains come from can just reply with
> a pointer to a URL of this email I'm typing right now :-)

-- 
todd underwood, vp & cto
oso grande technologies, inc.
todd@osogrande.com

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin

