Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270454AbTGMXrk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270450AbTGMXrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:47:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40902 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270449AbTGMXri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:47:38 -0400
Date: Sun, 13 Jul 2003 16:53:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Larry McVoy <lm@bitmover.com>
Cc: lm@bitmover.com, roland@topspin.com, alan@storlinksemi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-Id: <20030713165323.3fc2601f.davem@redhat.com>
In-Reply-To: <20030713235424.GB31793@work.bitmover.com>
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
	<20030713004818.4f1895be.davem@redhat.com>
	<52u19qwg53.fsf@topspin.com>
	<20030713160200.571716cf.davem@redhat.com>
	<20030713233503.GA31793@work.bitmover.com>
	<20030713164003.21839eb4.davem@redhat.com>
	<20030713235424.GB31793@work.bitmover.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 16:54:24 -0700
Larry McVoy <lm@bitmover.com> wrote:

> Every time I tried to push the page flip idea or offloading or any of
> that crap, Andy Bechtolsheim would tell "the CPUs will get faster faster
> than you can make that work".  He was right.

I really don't see why receive is so much of a big deal
compared to send, and we do a send side version of this
stuff already with zero problems.

The NFS code is already basically ready to handle a fragmented packet
(headers + pages), and could stick the page part into the page cache
easily on receive.

And it's not the CPUs that really limit us here, it's memory
bandwidth.  It's one thing to have a PCI-X bus fast enough
to service 10Ggb/sec rates, it's yet another thing to have
a memory bus and RAM underneath that which can handle moving
that data over it _twice_.

The infrastructure needed to support this on the networking side
help us support other useful things, such as driver local packet
buffer recycling.
