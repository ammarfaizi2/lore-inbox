Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbTIDJQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTIDJQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:16:54 -0400
Received: from ns1.questra.com ([64.132.48.186]:60676 "EHLO ns1.questra.com")
	by vger.kernel.org with ESMTP id S264827AbTIDJP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:15:26 -0400
Date: Thu, 4 Sep 2003 05:15:25 -0400
From: Scott Mcdermott <smcdermott@questra.com>
To: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: SNAT interaction with kernel-based IPSEC (in 2.6)
Message-ID: <20030904091525.GO17837@questra.com>
Mail-Followup-To: netfilter@lists.netfilter.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some difficulty doing simple pings over an IPSEC
tunnel using the implementation in 2.6.0-test4 (with
Racoon, and successful Phase 1 and 2, I get the IPSEC SA
fine), in combination with iptables.

I have SNAT rules on the same machine that is my IPSEC
tunnel endpoint.  I have RFC1918 IPs on my near side of the
NAT/IPSEC box, which are SNATted to routable IPs in the
normal case (where they don't go over the IPSEC tunnel) and
conntracked.  If they are destined for the remote LAN though
(at other end of tunnel), they need to go through
unmolested: I do NOT want them SNATted when they go over the
IPSEC tunnel, but to instead just bypass the `nat' table
altogether.  Is this possible? I would like them still to
traverse the `filter' table (so I can restrict the remote
LAN), but I would be happy right now if I could get just
bypass iptables altogether.

I am suspecting that when my packets do go over the tunnel,
get to the other end, and are unwrapped, they have the
translated IP as the source, and not the original RFC1918
source IP (which would then allow replies to get routed
correctly back over the IPSEC tunnel to me).  I am awaiting
a reply from the other end on whether or not my suspicion is
true, but in the meantime, I thought I would try to get an
understanding of how the kernel IPSEC implementation and
netfilter interact, and if it's even possible to do what I'm
trying to do (bypass nat rules in the case that the packet
is destined for the tunnel).  Hopefully this is a common
procedure that others have attempted already.

Thanks for any information.  Sorry to crosspost, I am not
sure where to discuss IPSEC issues that regard Netfilter.  I
tried subscribing to netdev, but it seems to just ignore my
subscription emails.
