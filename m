Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUFGX6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUFGX6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUFGX6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:58:50 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:6573 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265135AbUFGX6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:58:46 -0400
Date: Tue, 8 Jun 2004 01:43:26 +0200 (CEST)
From: Marc Herbert <marc.herbert@free.fr>
X-X-Sender: mherbert@fcat
To: netdev@oss.sgi.com
Cc: Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
In-Reply-To: <20040607145723.41da5783.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0406080111550.2832@fcat>
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004, David S. Miller wrote:

> On Mon, 7 Jun 2004 23:28:04 +0200
> Roger Luethi <rl@hellgate.ch> wrote:
>
> > What is the correct response if a user passes ethtool speed or duplex
> > arguments while autoneg is on? Some possible answers are:
> >
> > a) Yell at the user for doing something stupid.
> >
> > b) Fail silently (i.e. ignore command).
> >
> > c) Change advertised value accordingly and initiate new negotiation.
> >
> > d) Consider "autoneg off" implied, force media accordingly.
> >
> > The ethtool(8) man page I'm looking at doesn't address that question. The
> > actual behavior I've seen is b) which is by far my least preferred
> > solution.

> speed and duplex fields should be silently ignored in this case

I find the c) feature very convenient. For instance it allows reliably
downgrading a link connected to a switch without having to fiddle with
the configuration of the switch, something which is usually (pick your
favourites) non-standard, painful, not authorized, not implemented,
buggy,...

Command line parameters of the bcm5700 driver do implement c) (among
other nifties). Documented in its man page. Command line parameters of
e1000 also allow some control over the autonegociation process, even
if not using c) but a different (and less user-friendly) syntax. See
Documentation/--/e1000.txt. From David's words, I suspect this feature
is simply missing from ethtool.

Finally, silently ignoring user input is not very user-friendly IMHO.
I would much prefer a) to b).

I am aware that my preferences are probably in inverse order of the
amount of work required.



PS: I read netdev but not linux-kernel
