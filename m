Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUGFUTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUGFUTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGFUTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:19:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26287 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263147AbUGFUT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:19:26 -0400
Date: Tue, 6 Jul 2004 13:16:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: shemminger@osdl.org, ahu@ds9a.nl, acme@conectiva.com.br,
       netdev@oss.sgi.com, alessandro.suardi@oracle.com, phyprabab@yahoo.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706131617.39484eff.davem@redhat.com>
In-Reply-To: <40EB04C7.4000007@us.ibm.com>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	<20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	<40EB04C7.4000007@us.ibm.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jul 2004 13:00:07 -0700
Nivedita Singhvi <niv@us.ibm.com> wrote:

> Stephen Hemminger wrote:
> > Recent TCP changes exposed the problem that there ar lots of really broken firewalls 
> > that strip or alter TCP options.
> 
> We should not be accepting of this situation, surely. I mean, the firewalls
> have to get fixed. Multiple things are breaking here, due to this. What
> are the other options they are messing with, and and any idea why?

I totally agree with Nivedita, and that's why I'm not going to
apply Stephen's patch.

> If the firewall is actually stripping the TCP window scaling option,
> then that tells the other end that we can't *receive* scaled windows
> either, since the option indicates both, we are sending and capable
> of receiving. i.e. The other end will not send us scaled windows.
> There is no way we can fix this on the rcv end.
> 

That's correct.  If the SYN contains a window scale option, this tells
the SYN+ACK sending side that both receive and send side window scaling
is supported.  I think what's really happening is that the firewall is
patching the non-zero window scale option in the SYN+ACK  packet to be
zero, yet not adjusting the window field of packets in the rest of the
TCP stream.

> Does this need to be the default behaviour? Just how prevalent is
> this??

Frankly, I've personally seen none of this.  I sit on a DSL line with
no firewalling at my end and I can access all sites just fine.  This
seems to indicate that most of the breakage is local to the user's
point of access to the net, rather than a firewall at google.com
or kernel.org or similar.
