Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270474AbTGNAhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270480AbTGNAhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:37:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1735 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270474AbTGNAhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:37:05 -0400
Date: Sun, 13 Jul 2003 17:42:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-Id: <20030713174242.3ceb8213.davem@redhat.com>
In-Reply-To: <200307140046.h6E0kcMQ021180@turing-police.cc.vt.edu>
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
	<20030713004818.4f1895be.davem@redhat.com>
	<52u19qwg53.fsf@topspin.com>
	<20030713160200.571716cf.davem@redhat.com>
	<20030713233503.GA31793@work.bitmover.com>
	<20030713164003.21839eb4.davem@redhat.com>
	<20030713235424.GB31793@work.bitmover.com>
	<20030713165323.3fc2601f.davem@redhat.com>
	<200307140046.h6E0kcMQ021180@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 20:46:38 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Sun, 13 Jul 2003 16:53:23 PDT, "David S. Miller" said:
> 
> > I really don't see why receive is so much of a big deal
> > compared to send, and we do a send side version of this
> > stuff already with zero problems.
> 
> Well.... there's optimizations you can do on the send side..

I consider the send side complete covered already.  We don't
touch any of the data portion, we only put together the
headers.

> It's hard to do tricks like that when you don't know (for instance) how
> many IP option fields the packet has until you've already started sucking
> the packet off the wire - at which point either the NIC itself has to be clever
> (Hmm, there's that IP offload again) or you have literally about 30 CPU cycles
> to do interrrupt latency *and* decide what to do....

There are cards, both existing and in development, that have
very simple header parsing engines you can program to do stuff
like this, it isn't hard at all.

But this is only half of the problem, you need a flow cache and
clever RX buffer management as well to make the RX side zero-copy
stuff work.

