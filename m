Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLASOZ>; Fri, 1 Dec 2000 13:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbQLASOQ>; Fri, 1 Dec 2000 13:14:16 -0500
Received: from relay2.smtp.psi.ca ([154.11.137.2]:23224 "EHLO
	relay2.smtp.psi.ca") by vger.kernel.org with ESMTP
	id <S129391AbQLASOG>; Fri, 1 Dec 2000 13:14:06 -0500
From: Francois Desloges <fd@vipswitch.com>
To: romieu@ensta.fr, Francois romieu <romieu@cogenit.fr>,
        Ivan Passos <lists@cyclades.com>
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Date: Fri, 1 Dec 2000 11:26:59 -0500
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20001201100124.A4986@se1.cogenit.fr>
In-Reply-To: <20001201100124.A4986@se1.cogenit.fr>
MIME-Version: 1.0
Message-Id: <00120112303800.07574@dual.vip.ca>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2000, Francois romieu wrote:
> [netdev Cced]
> 
> The Thu, Nov 30, 2000 at 11:16:52AM -0800, Ivan Passos wrote :
> [...]
> > For synchronous network interfaces, besides configuring network parameters
> > such as IP address, netmask, MTU, etc., the system should also configure
> > parameters specific to these sync i/f's, such as media (e.g V.35, X.21,
> > T1, E1), clock (internal or external, and value if int.), protocol (e.g
> > PPP, HDLC, Frame Relay), etc.
> > What I noticed was that each synchronous board in Linux provides a
> > different way of doing this, and it would be good for users to have a
> > single, standard interface (such as ifconfig) to do this type of
> > configuration. Maybe even patch ifconfig itself, I don't know ...
> > 
> > Questions:
> > - Is there any existing _standard_ interface to do that??
> 
> No.
> 

Humm...  If I recall the thread about 802.1Q that happened in June on netdev,
(See the thread starting at
http://sloth.wcug.wwu.edu/lists/netdev/200006/msg00003.html ), and I add up
with what I read here, I think we would be due for a major rewrite of the Layer
2 akin to what Alexey did for Layer 3 in 2.2.

A lot of questions need to be answered like:

What is _really_ a net_device ? (Hardware card, interface to tag a L3 address
on, etc..)

Considering the following divisions that exist today:
 - A hardware card (or let's say a chipset so that anything on a mobo count as
   well) can have many physical ports. I will call them PHY.
 - A PHY can use TDM or Wavelenght Multiplexing (including Lambdas on
   GEthernet and 10 GEthernet fibers) or both ! to create physical channels.
   I'll call them Channels.
 - Each of these Channels may further on use logics in header to (possibly)
   create virtual links (802.1Q, MPLS (?)) Let's call this top abstraction a
   Link, that is, something that can receive a L3 address.

Consider as well that you want to maintain the actual funtionnality of the
kernel, including:
 - Bridging.
 - 802.1Q VLANing (with a patch from one of Gleb or Ben's Project)
 - Bridging/802.1Q (Is this possible yet ?) 
 - Hooking a _lot_ of different L3 on top of L2 (including AplleTalk, etc)
 - simple user tools like, ifconfig, and very powerful one, like ip.

How many abstractions are really desirable at Layer 2 in order to limit the
proliferation of tools linked to specific hardware?

-- 
François Desloges
fd@vipswitch.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
