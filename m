Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293270AbSCAQc7>; Fri, 1 Mar 2002 11:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293256AbSCAQbg>; Fri, 1 Mar 2002 11:31:36 -0500
Received: from web14507.mail.yahoo.com ([216.136.224.70]:26378 "HELO
	web14507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293249AbSCAQam>; Fri, 1 Mar 2002 11:30:42 -0500
Message-ID: <20020301163041.66246.qmail@web14507.mail.yahoo.com>
Date: Fri, 1 Mar 2002 08:30:41 -0800 (PST)
From: sekhar raja <manamraja@yahoo.com>
Subject: Problem in sending out the IPv6 packet
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I am working in Mobile IPv6 as my final thesis
project.  I need to submit it by monday, but my linux
box is getting hanged while i tried to send out a
packet when the linux box connected to Different
network. 

The Scnerio is as follows

Let us say i configured Linux box named MN with
address 3fee:c000:b000:a000:2:3:4:5. I ping to other
nodes i am successful.

I moved this Linux box to different network, i tried
to send packet the Router to which i connected
previously. The Linux node getting hanged in
"neigh_resolve_output" function while processing
following code

if (neigh_event_send(neigh, skb) == 0) {
                int err;
                struct device *dev = neigh->dev;
                if (dev->hard_header_cache && dst->hh
== NULL) {
                        start_bh_atomic();
                        if (dst->hh == NULL)
                                neigh_hh_init(neigh,
dst, dst->ops->protocol);
                        err = dev->hard_header(skb,
dev, ntohs(skb->protocol), neigh->ha, NULL, skb->len);
                        end_bh_atomic();
                } else {
                        start_bh_atomic();
                        err = dev->hard_header(skb,
dev, ntohs(skb->protocol), neigh->ha, NULL, skb->len);
                        end_bh_atomic();
                }
                if (err >= 0)
                        return
neigh->ops->queue_xmit(skb);
                kfree_skb(skb);
                return -EINVAL;
        }
in net/core/neighbour.c. 

As my observation goes from three days of testing, it
is getting hanged whenever the nud_state variable
value in neighbour structure is NUD_STALE or
NUD_FAILED. It is hanging otherwise it is O.K.

I created my own socket for filling the sock
structure.

In another scenerio I reboot the machine while i
connected to the router which is having different
subnet prefix from the Linux box. I send packet to the
router which has same network address as Linux node. I
succeed. Same way i move to another network i am able
to send out the packets. 

I come back to router which is having the same network
address as Linux node, i am able to send out the
packet. 

As soon as i move the link from router which has same
network address ad Linux Node to another router with
different network address, it is getting hanged.

Is i need to clean the routing table as i moved to
another network? From where this neighbour structure
learnt in dst->neighbour->output to send out packet?
This function call is in ip6_output() function of
ip6_outpt.c file.

The packet sending out initiation starts when there is
new Router Advertisement from the Neighbour routers.

Please help me to crack this out. Any inputs will be
greatly appreciated.

Please do a reply all to this mail as i am not in the
mailing list.

Thanks & Regards
-Rajasekhar

__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
