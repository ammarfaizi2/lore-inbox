Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbTHQNNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270066AbTHQNNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:13:34 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:62215 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S270009AbTHQNNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:13:24 -0400
Message-ID: <200308171509570955.003E4FEC@192.168.128.16>
In-Reply-To: <20030728213933.F81299@coredump.scriptkiddie.org>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
 <20030728213933.F81299@coredump.scriptkiddie.org>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Sun, 17 Aug 2003 15:09:57 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "Lamont Granquist" <lamont@scriptkiddie.org>,
       "Bill Davidsen" <davidsen@tmr.com>
Cc: "David S. Miller" <davem@redhat.com>, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have received reply from Cisco:

*********** BEGIN FORWARDED MESSAGE  ***********

On 06/08/2003 at 11:40 Oscar Madrid <omadrid@cisco.com> wrote:

>
>My name is Oscar Madrid and I'm Luis Isselin's escalation engineer.
I've
>decided to answer to this case straight as this is a question of
whether
>or not Cisco is following a standard.
>
>I can only think of one scenario where an arp request would come in
from
>192.168.140.x to a router interface that has 192.168.128.1.  That one
>scenario is a misconfiguration.    
>ARP is designed to find the next hop on a LAN.   If the host has an IP
>address of 192.168.140.140 and wants to get to 192.168.128.1, it will
have
>to have a default gateway configured.
>This default gateway would have to be on the same logical local
network.
>
>Now, lets say that the host has an IP address of 192.168.140.140/17
which
>will include both 192.168.128.x and 192.168.140.x.   This would still
be a
>misconfig as the router is not on the same subnet. (meaning the router
>does not have the same /17 mask. The host can see the router, but the
>router cannot see the host).
>
>You could, in theory, say that we're not following "similar algorithm"
in
>the RFC as we check the source, but this is more for a sanity check as
if
>it was a perfect world and everything is configured properly and there
>were no such things as bad implementations of TCP/IP stacks, then we
>wouldn't need to check.
>
>If the router for some reason was responding to the ARP broadcast, how
>would anyone know where the packet came from since the network is not
>being advertised as connected to this router? Meaning, how would a
return
>packet make it back to the host? The router doesn't "see" the host in
his
>logical network therefore it cannot communicate with it.
>
>I believe that reason we do the sanity check is because of basic IP
>routing. If the source is not from an IP address on the interface we
>received it on, we cannot reply to that IP address.  It is simple as
that.
>As I stated, ARP is designed to be used on a LAN.  This means that all
>stations that send/receive ARP packets are on the same subnet.  This
is
>the reason we do the check.   
>
>Please also note another portion of the RFC 0826 in question: 
>
>[The purpose of this RFC is to present a method of Converting
>Protocol Addresses (e.g., IP addresses) to Local Network
>Addresses (e.g., Ethernet addresses).  This is a issue of general
>concern in the ARPA Internet community at this time.  The
>method proposed here is presented for your consideration and
>comment.  This is not the specification of a Internet Standard.]
>
>When it is talking about Local Network Addresses, that means IP
addresses
>on the same network.   This is why we can perform the checks we
perform in
>our IOS.
>
>The point of the check would be to verify that the hosts are
configured
>correctly.   There is no case where a properly configured host should
ever
>send a ARP request for an IP address on a different subnet.
>
>The best example I can point out is this: 
>Ethernet is a Broadcast  network which uses ARP to find HW addresses
of
>other IP addresses on the same broadcast network.  If the IP address
is
>not on the same network, then the host/router/client needs to find the
>gateway which is on the local network.
>
>Basic and proper implementations of the TCP/IP stack should never ARP
out
>for a device that it is not located on the same logical network the
host
>is, the reason for this being they cannot communicate directly unless
a
>gateway is involved. The only ARP request a host should send in this
case
>is for its gateway that should also be a "local" device to the host
(same
>network).
>
>I hope this clears up the reson why Cisco's ARP implementation has
this
>safeguard you have found along with several others, HOWEVER, please
refer
>to RFC 1027, (http://www.ietf.org/rfc/rfc1027.txt) and under section
2.4,
>it contains the following paragraph:
>
>[If the IP networks of the source and target hosts of an ARP request 
>are different, an ARP subnet gateway implementation should not 
>reply. This is to prevent the ARP subnet gateway from being used to 
>reach foreign IP networks and thus possibly bypass security checks 
>provided by IP gateways. ]
>
>I would also ask you if you would be so kind to send me the link to
the
>netdev list of linux kernel you are making mention to so I can
escalate it
>and respond to the linux community if higher up is deemed up necesary.
>
>Best Regards,
>
>
>
>Oscar Madrid
>Customer Support Engineer
>Routing Protocols Team
>Cisco Systems
>omadrid@cisco.com
>
>                                    
>Open a TAC case on the web for faster response!
www.cisco.com/tac/caseopen
>Visit the TAC Web Site for quick access to technical support!
>www.cisco.com/tac
>Use the new TAC Advanced Search to find information fast!
>www.cisco.com/tac/advancedsearch
>
>

*********** END FORWARDED MESSAGE  ***********


