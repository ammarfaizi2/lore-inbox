Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbUKEJkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbUKEJkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 04:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUKEJkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 04:40:47 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:42403 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262631AbUKEJki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 04:40:38 -0500
Date: Fri, 5 Nov 2004 10:40:35 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: foo@porto.bmb.uga.edu
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bad UDP checksums with 2.6.9
In-Reply-To: <20041104062834.GE12763@porto.bmb.uga.edu>
Message-ID: <Pine.LNX.4.58.0411051038090.23710@tux.rsn.bth.se>
References: <20041104054838.GC12763@porto.bmb.uga.edu>
 <20041104062834.GE12763@porto.bmb.uga.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004 foo@porto.bmb.uga.edu wrote:

> On Thu, Nov 04, 2004 at 12:48:38AM -0500, foo wrote:
> > 'm seeing the same problem as in:
> > Message-Id: 20041020191203.GA14356@merlin.emma.line.org
> > or http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/1310.html
> >
> > I just upgraded a machine from 2.6.5 to 2.6.9, and when the amanda
> > backup server contacts it, it sometimes replies with a UDP packet with a
> > bad checksum.  I'm using e1000 here, so it seems to not be related to
> > the ethernet driver.  I have a binary tcpdump if anyone's interested.
>
> I don't know why I didn't think of this at first, but I have another
> identical machine that I upgraded at the same time that doesn't have the
> problem.
>
> Here's a diff between their .configs - albarino is the one having
> trouble.  Maybe CONFIG_PACKET_MMAP?  If someone can point me at a likely
> config option to change I'll boot a new kernel for the next backup run
> Friday night.

> -CONFIG_IP_NF_AMANDA=y

Disable that and it should work again, there's a bug in that conntrack
helper that was introduced when some performance-fixes for non-linear
packets went in. Davem has a patch for it in his tree, should find it's
way into mainline soonish.

Look at a netfilter-devel archive for the discussion if you are
interested.

/Martin
