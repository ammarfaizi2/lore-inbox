Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUXzb>; Wed, 21 Feb 2001 18:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRBUXzX>; Wed, 21 Feb 2001 18:55:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30592 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129170AbRBUXzQ>;
	Wed, 21 Feb 2001 18:55:16 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.21701.542448.49413@pizda.ninka.net>
Date: Wed, 21 Feb 2001 15:52:37 -0800 (PST)
To: Jordan Mendelson <jordy@napster.com>
Cc: ookhoi@dds.nl, Vibol Hou <vibol@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, sim@stormix.com,
        netdev@oss.sgi.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues 
 (3c905B))
In-Reply-To: <3A9453F4.993A9A74@napster.com>
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc>
	<20010221104723.C1714@humilis>
	<14995.40701.818777.181432@pizda.ninka.net>
	<3A9453F4.993A9A74@napster.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jordan Mendelson writes:
 > Now, if it didn't have the side effect of dropping packets left and
 > right after ~4000 open connections (simultaneously), I could finally
 > move our production system to 2.4.x.

There is no reason my patch should have this effect.

All of this is what appears to be a bug in Windows TCP header
compression, if the ID field of the IPv4 header does not change then
it drops every other packet.

The change I posted as-is, is unacceptable because it adds unnecessary
cost to a fast path.  The final change I actually use will likely
involve using the TCP sequence numbers to calculate an "always
changing" ID number in the IPv4 headers to placate these broken
windows machines.

Later,
David S. Miller
davem@redhat.com
