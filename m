Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTHSTJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbTHSTGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:06:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18061 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261277AbTHSTGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:06:32 -0400
Date: Tue, 19 Aug 2003 11:58:45 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819115845.4e968506.davem@redhat.com>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB5F@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB5F@post.pc.aspectgroup.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 20:00:44 +0100
Richard Underwood <richard@aspectgroup.co.uk> wrote:

> David S. Miller wrote: 
> > If I know that IP X has my configuration information, I
> > have every right to send X a packet from zero-net to
> > ask for that information before I have any IP addresses
> > attached to the interface.
> > 
> 	Ick! And how is IP X going to get the information back?

It knows the MAC address of the intended receiver, there is
no problem here.

> 	If you are going to send from 0.0.0.0, then I assume there's
> something in the ARP standard to say "don't cache this ARP request" - I must
> have missed it. If so, that's a special case - no need to spoil things
> elsewhere, though.

What is the caching problem?  The ARP response is valid, and we
have no reason to believe otherwise.

> 	Well, what do you do currently? If the packet you're routeing came
> from another host, there's no way in hell you can use their IP address in an
> ARP request ... is there? I certainly hope you don't go that far!!!

We're not talking about routing scenerios, we're talking strictly
about packets being originated by an application on the local host.

> > Besides normal IP addresses, multicast tools use these
> > facilities.
> > 
> 	Multicast uses ARP? That's news to me!

It uses routes that only have been determined only using the desired
device index.  There is no "interface address" to match up to when
we're trying to send to a multicast address.
