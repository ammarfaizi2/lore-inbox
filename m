Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUIOXhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUIOXhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUIOXej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:34:39 -0400
Received: from [142.46.200.198] ([142.46.200.198]:56283 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S267774AbUIOXaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:30:39 -0400
Message-Id: <200409152329.i8FNTsqG025184@guinness.s2io.com>
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: "'David S. Miller'" <davem@davemloft.net>,
       "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <paul@clubi.ie>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: The ultimate TOE design
Date: Wed, 15 Sep 2004 16:29:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSba93oeMQT0vylSiqa+KzHVJsgAQABuSwQ
In-Reply-To: <20040915142926.7bc456a4.davem@davemloft.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Spam-Score: -103.3
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_10,FORGED_MUA_OUTLOOK,IN_REP_TO,MISSING_OUTLOOK_NAME,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Jeff's "ultimate TOE card" based upon generic embedded CPU is doable
at GbE, but we may not see such a product because it's too late for it to
succeed.

TOE is a pretty questionable product in itself; one of the main reasons
people build TOE cards is to put RDMA on top of it and end up with an RNIC
(NIC+TOE+RDMA) Ethernet card.
The hope is to eventually run all three types of server traffic (network,
storage, IPC) over an RNIC, and get rid of two other HBAs in a system.

For this "fabric conversion" over Ethernet to happen it has to be at 10GbE
not GbE, since storage (FiberChannel) is already at 4Gb.
And at 10GbE, embedded CPUs just don't cut it - it has to be custom ASIC
(granted, with some means to simplify debugging and reduce the risk of hw
bugs and TCP changes).

On some other points on the thread:

WRT the TOE price, I suspect that when RNICs come out they will command
little premium over conventional NICs - it will be just a technology
upgrade.

WRT larger MTU - going to bigger MTUs helps a lot, but it will be years
before the infrastructure moves beyond 9600 byte MTU. Even right now, usage
of 9600 byte Jumbos is not universal.

WRT TSO, for applications that don't require RDMA TSO indeed helps a lot on
the transmit side for 1500 MTU - 10GbE cards are innevitably CPU bound, and
we are seeing ~3x throughput improvement with normal frames.

This leaves receive offload schemes in Linux as a biggest improvement (short
of supporting TOE) to make.
It will be great to see such receive schemes defined and implemented, as I
stated in an earlier thread we will be willing to participate in such work
and put the support in S2io 10GbE ASIC and drivers.




> -----Original Message-----
> From: David S. Miller [mailto:davem@davemloft.net] 
> Sent: Wednesday, September 15, 2004 2:29 PM
> To: Jeff Garzik
> Cc: alan@lxorguk.ukuu.org.uk; paul@clubi.ie; 
> netdev@oss.sgi.com; leonid.grossman@s2io.com; 
> linux-kernel@vger.kernel.org
> Subject: Re: The ultimate TOE design
> 
> On Wed, 15 Sep 2004 17:23:49 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > The typical definition of TOE is "offload 90+% of the net 
> stack", as 
> > opposed to "TCP assist", which is stuff like TSO.
> 
> I think a better goal is "offload 90+% of the net stack cost" 
> which is effectively what TSO does on the send side.
> 
> This is why these discussions are so circular.
> 
> If we want to discuss something specific, like receive 
> offload schemes, that is a very different matter.  And I'm 
> sure folks like Rusty have a lot to contribute in this area :-)
> 

