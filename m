Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270468AbTGNASe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270467AbTGNASe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:18:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53958 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270466AbTGNASa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:18:30 -0400
Date: Sun, 13 Jul 2003 17:24:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: Larry McVoy <lm@bitmover.com>
Cc: lm@bitmover.com, roland@topspin.com, alan@storlinksemi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-Id: <20030713172414.5c888094.davem@redhat.com>
In-Reply-To: <20030714002200.GA24697@work.bitmover.com>
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
	<20030713004818.4f1895be.davem@redhat.com>
	<52u19qwg53.fsf@topspin.com>
	<20030713160200.571716cf.davem@redhat.com>
	<20030713233503.GA31793@work.bitmover.com>
	<20030713164003.21839eb4.davem@redhat.com>
	<20030713235424.GB31793@work.bitmover.com>
	<20030713165323.3fc2601f.davem@redhat.com>
	<20030714002200.GA24697@work.bitmover.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 17:22:00 -0700
Larry McVoy <lm@bitmover.com> wrote:

> Hey, maybe it isn't, but could you please quantify the cost of the VM 
> operations?  How hard is that?

Ok.

So the page is in a non-uptodate state, NFS would have it locked,
and anyone else trying to get at it would sleep.

This page we have currently is "dummy" in that it is only a place
holder in case we don't get a full page from the networking.

We have all the infrastructure to do everything up to this point.

Next, if the networking gave us a full page, we'd "replace"
the dummy page with this one, which would involve:

1) delete the dummy page from the lookup, insert the networking's
   page

2) arrange so that all sleepers on the dummy page will do a relookup
   and find the new page

And when we're done with the operation we wake everyone up.

I can't see any part of this turning out to be expensive.
