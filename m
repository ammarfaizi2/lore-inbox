Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUFNNKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUFNNKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUFNNKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 09:10:49 -0400
Received: from relay03s.ntr.oleane.net ([194.2.8.84]:30170 "EHLO
	relay03s.ntr.oleane.net") by vger.kernel.org with ESMTP
	id S262902AbUFNNKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 09:10:47 -0400
Date: Mon, 14 Jun 2004 15:11:15 +0200 (CEST)
From: Marc Herbert <marc.herbert@free.fr>
X-X-Sender: mherbert@fcat
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
In-Reply-To: <20040609151246.1c28c4d9.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0406141458270.16762@fcat>
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com>
 <20040608210809.GA10542@k3.hellgate.ch> <40C77C70.5070409@tmr.com>
 <20040609213850.GA17243@k3.hellgate.ch> <20040609151246.1c28c4d9.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, David S. Miller wrote:

> On Wed, 9 Jun 2004 23:38:50 +0200
> Roger Luethi <rl@hellgate.ch> wrote:
>
> > <sigh> I just killed the module parameters in my via-rhine development
> > tree.
>
> That is absolutely the correct thing to do, module parameters for
> link settings are %100 deprecated, people need to use ethtool for
> everything.

This is precisely the reason why I am concerned about having "rich"
ethtool semantics. A unified, standard interface is great,... as long
it does not leave behind some features, like setting the advertised
values in autoneg. As a user of these features, I hope driver
developers will NOT remove those module_param features that cannot
migrated to ethtool.


On Tue, 8 Jun 2004, Marc Herbert wrote:

> > On Mon, 7 Jun 2004 23:28:04 +0200
> > Roger Luethi <rl@hellgate.ch> wrote:
> >
> > > What is the correct response if a user passes ethtool speed or duplex
> > > arguments while autoneg is on? Some possible answers are:

> > > c) Change advertised value accordingly and initiate new negotiation.

> I find the c) feature very convenient. For instance it allows reliably
> downgrading a link connected to a switch without having to fiddle with
> the configuration of the switch, something which is usually (pick your
> favourites) non-standard, painful, not authorized, not implemented,
> buggy,...

In case any one wondered: probably the most common motivation for
manually downgrading a link is when the cabling is found to be not
"good enough" for the max common speed of the two transceivers.
(see "Gigabit Ethernet - Rich Seifert, section 8.2.3")

See also: "Running 1000BASE-T: Gigabit Ethernet over Copper"
  http://www.10gea.org/GEA_copper_0999_rev-wp.pdf
 "The 1000BASE-T Task Force and the cabling companies estimate that
 less than 10 percent of the installed base of Category 5 cable was
 improperly installed,"

I find "less than 10 percent" not so negligible.

