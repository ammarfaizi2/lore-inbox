Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272363AbTHSRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272360AbTHSRRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:17:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29067 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S274903AbTHSROx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:14:53 -0400
Date: Tue, 19 Aug 2003 10:07:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: richard@aspectgroup.co.uk, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819100712.2470d18d.davem@redhat.com>
In-Reply-To: <20030819191010.43d83b79.skraw@ithnet.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB5B@post.pc.aspectgroup.co.uk>
	<20030819095105.2cb9acc1.davem@redhat.com>
	<20030819191010.43d83b79.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 19:10:10 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Well, then you have a problem, at least with RFC-985 as quoted in my other
> email.

RFC-985 does not take into consideration a system model where IP
addresses are owned by the host not specific interfaces which is a
valid system model that the RFC standards allow.

> <quote RFC-985>
> An ARP request is discarded if the source IP address is not in the same subnet.
> </quote>

This RFC is broken in an environment consistent of systems using
the host address ownership model.

It also doesn't consider cases where the host receiving the
ARP request is not aware of all subnets present on a LAN.

Ignoring such ARPs is therefore broken and prevents valid
communications from occuring.

Some systems implement this check to provide "pseudo security",
but it isn't even that.
