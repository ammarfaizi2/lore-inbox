Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130020AbQKCBXP>; Thu, 2 Nov 2000 20:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130089AbQKCBXG>; Thu, 2 Nov 2000 20:23:06 -0500
Received: from web5205.mail.yahoo.com ([216.115.106.86]:61453 "HELO
	web5205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130020AbQKCBWy>; Thu, 2 Nov 2000 20:22:54 -0500
Message-ID: <20001103012247.8956.qmail@web5205.mail.yahoo.com>
Date: Thu, 2 Nov 2000 17:22:47 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: 255.255.255.255 won't broadcast to multiple NICs
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> Rob Landley wrote:
> > Under 2.2.16, broadcast packets addressed to
> > 255.255.255.255 do not go out to all interfaces in
> a
> > machine with multiple network cards.  They're
> getting
> > routed out the default gateway's interface
> instead.
> 
> Are the network cards on the same network?

Two subnets.  (both martians: 10.blah and
192.168.blah).  Gateway's off of 10.blah (beyond which
lives the internet), the 192 thing is the small
cluster I'm putting together in my office to test the
software.

I take it this makes a difference?  If there's some
kind of "don't do that" here, I might be happy just
documenting it.  (In theory, I could iterate through
the NICs and send out a broadcast packet to each
interface's broadcast address (although for reasons
that are a bit complicated to go into right now unless
you really want to know, that's not easy to do in this
case).)  But that's just a workaround to cover up the
fact that the IP stack isn't doing the obvious with
global broadcasts.

So the question is, is the stack's behavior right?  If
not, what's involved in fixing it, and if so, is it
documented anywhere?

(I checked google rather a lot before coming here, and
linux/Documentation, and even glanced at the route.c
source code.  ip_route_output_slow has several
explicit checks for "FFFFFFFF" which are easily
searched for, but the upshot is that the packet gets
mapped to a single interface anyway.  Around line 1641
of my sources there's an #ifdef CONFIG_IP_MROUTE that
looked very interesting, but it turns out only to be
for multicast addresses and I don't know if
IN_DEV_FORWARD is forking the packet or not...)

At which point I came here. :)

Rob

__________________________________________________
Do You Yahoo!?
>From homework help to love advice, Yahoo! Experts has your answer.
http://experts.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
