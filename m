Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbTAMDD4>; Sun, 12 Jan 2003 22:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTAMDDz>; Sun, 12 Jan 2003 22:03:55 -0500
Received: from smtp.comcast.net ([24.153.64.2]:42214 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267133AbTAMDD2>;
	Sun, 12 Jan 2003 22:03:28 -0500
Date: Sun, 12 Jan 2003 22:11:51 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Re: Sending sk_buffs without being tied to a struct sock
In-reply-to: <3E21A5AE.5060607@trash.net>
To: Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1042427512.22006.2.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1042301388.8667.0.camel@localhost.localdomain>
 <3E21A5AE.5060607@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, if I call skb->dst->output() what should skb->data point
to? A properly crafted IP packet?  Checksummed and all?  I shouldn't
need any layer 2 info in my skb at all to use this solution, should I?

Thanks for the help.  I think this will do the trick.

J

On Sun, 2003-01-12 at 12:28, Patrick McHardy wrote:
> Joshua Stewart wrote:
> 
> >
> >I'm trying to take "hand-built" sk_buffs with little more than some data
> >and a dev member and push them to the NIC for transmission.  I would
> >like to simply give them to dev_queue_xmit.  Does anybody know what
> >state I should have them in before handing them to dev_queue_xmit? 
> >Should skb->data point to the start of a MAC header or an IP header?
> >
> >Also, given an IP address in skb->nh.iph->daddr, what's the easiest way
> >to get the appropriate MAC address?
> >
> use ip_route_output_key() and then skb->dst->output(), that way it will work on all media
> and you don't have to care about l2 resolving at all.
> 
> 
> Patrick
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


