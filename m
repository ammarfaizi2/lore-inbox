Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTHTPpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbTHTPpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:45:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54681 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262023AbTHTPph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:45:37 -0400
Date: Wed, 20 Aug 2003 08:38:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: ak@colin2.muc.de, dang@fprintf.net, ak@muc.de, lmb@suse.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030820083822.598ce78a.davem@redhat.com>
In-Reply-To: <20030820174133.5e3f50e5.skraw@ithnet.com>
References: <mdtk.Zy.1@gated-at.bofh.it>
	<mgUv.3Wb.39@gated-at.bofh.it>
	<mgUv.3Wb.37@gated-at.bofh.it>
	<miMw.5yo.31@gated-at.bofh.it>
	<m365ktxz3k.fsf@averell.firstfloor.org>
	<1061320620.3744.16.camel@athena.fprintf.net>
	<20030819192125.GD92576@colin2.muc.de>
	<1061321268.3744.20.camel@athena.fprintf.net>
	<20030819193235.GG92576@colin2.muc.de>
	<20030819122847.2d7e2e31.davem@redhat.com>
	<20030820174133.5e3f50e5.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 17:41:33 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Aehm, sorry but the logic is bogus. A routed packet will be sent out this
> interface with a foreign IP as source, too.

I'm talking about "local" addresses.

When we're routing, we'll use an interface address of
course.

But when the packet is originating from our host, and
the source address in the outgoing packet is local to
us, we will use it as the source in the ARP packet.

Look at the algorithm in net/ipv4/arp_solicit() to see
what I mean.

