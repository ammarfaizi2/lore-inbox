Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272444AbTHSRUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272417AbTHSRTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:19:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34699 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272052AbTHSRRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:17:00 -0400
Date: Tue, 19 Aug 2003 10:09:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: willy@w.ods.org, richard@aspectgroup.co.uk, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819100929.0bfefbb4.davem@redhat.com>
In-Reply-To: <20030819191246.027061dd.skraw@ithnet.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
	<20030819170751.2b92ba2e.skraw@ithnet.com>
	<20030819085717.56046afd.davem@redhat.com>
	<20030819185219.116fd259.skraw@ithnet.com>
	<20030819095302.7213ddd5.davem@redhat.com>
	<20030819191246.027061dd.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 19:12:46 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> On Tue, 19 Aug 2003 09:53:02 -0700
> "David S. Miller" <davem@redhat.com> wrote:
> 
> > In the ARP request we are using the source address in the packet we
> > are building for output.
> > 
> > If ARP doesn't work using that source address, we can only assume IP
> > communication is not possible either.
> > 
> > It is the box not responding to this ARP which is preventing
> > communication not the box creating the ARP request.
> 
> Please read my example from other email. Very simple to prove you wrong here.

Not really, the RFC you keep quoting is broken in several
regards:

1) It is non-functional in environments containing systems
   using the host ownership model for IP addresses which the
   RFC standards fully allow.

2) It does not consider the cases where a host is not completely
   aware of all subnets present on a given link.  This is actually
   quite common.

   Dropping such ARP requests can only be done when the
   the host is aware of all subnets that exist, which is cannot
   be possibly true.
