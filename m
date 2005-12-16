Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVLPRsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVLPRsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVLPRsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:48:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750741AbVLPRsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:48:39 -0500
Date: Fri, 16 Dec 2005 09:48:10 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, mpm@selenic.com, ak@suse.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051216094810.70082caa@dxpl.pdx.osdl.net>
In-Reply-To: <1134698963.10101.43.camel@w-sridhar2.beaverton.ibm.com>
References: <20051215033937.GC11856@waste.org>
	<20051214.203023.129054759.davem@davemloft.net>
	<Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com>
	<20051215.002120.133621586.davem@davemloft.net>
	<1134698963.10101.43.camel@w-sridhar2.beaverton.ibm.com>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005 18:09:22 -0800
Sridhar Samudrala <sri@us.ibm.com> wrote:

> On Thu, 2005-12-15 at 00:21 -0800, David S. Miller wrote:
> > From: Sridhar Samudrala <sri@us.ibm.com>
> > Date: Wed, 14 Dec 2005 23:37:37 -0800 (PST)
> > 
> > > Instead, you seem to be suggesting in_emergency to be set dynamically
> > > when we are about to run out of ATOMIC memory. Is this right?
> > 
> > Not when we run out, but rather when we reach some low water mark, the
> > "critical sockets" would still use GFP_ATOMIC memory but only
> > "critical sockets" would be allowed to do so.
> > 
> > But even this has faults, consider the IPSEC scenerio I mentioned, and
> > this applies to any kind of encapsulation actually, even simple
> > tunneling examples can be concocted which make the "critical socket"
> > idea fail.
> > 
> > The knee jerk reaction is "mark IPSEC's sockets critical, and mark the
> > tunneling allocations critical, and... and..."  well you have
> > GFP_ATOMIC then my friend.
> 
> I would like to mention another reason why we need to have a new 
> GFP_CRITICAL flag for an allocation request. When we are in emergency,
> even the GFP_KERNEL allocations for a critical socket should not 
> sleep. This is because the swap device may have failed and we would
> like to communicate this event to a management server over the 
> critical socket so that it can initiate the failover.
> 
> We are not trying to solve swapping over network problem. It is much
> simpler. The critical sockets are to be used only to send/receive
> a few critical messages reliably during a short period of emergency.
> 

If it is only one place, why not pre-allocate one "I'm sick now"
skb and hold onto it. Any bigger solution seems to snowball into
a huge mess.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
