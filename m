Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUCKOJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUCKOJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:09:07 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:50929 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261351AbUCKOI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:08:57 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: UID/GID mapping system
Date: Thu, 11 Mar 2004 08:08:31 -0600
X-Mailer: KMail [version 1.2]
Cc: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby> <20040310234640.GO1144@schnapps.adilger.int>
In-Reply-To: <20040310234640.GO1144@schnapps.adilger.int>
MIME-Version: 1.0
Message-Id: <04031108083100.05054@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 17:46, Andreas Dilger wrote:
> On Mar 10, 2004  15:41 -0600, Jesse Pollard wrote:
> > On Wednesday 10 March 2004 11:58, Søren Hansen wrote:
> > > The server can't trust the client as it is now anyway. The client can
> > > do whatever it wants already. There is no security impact as I see it.
> >
> > First, if the server refuses to map uids into what it considers system
> > (say, those less than 100... or better, 1000) then the daemons that may
> > be using those uids/gids on the server (or other hosts even) will be
> > protected from a simple mapping attack. Any attempt to do so will be
> > detected by the server, blocked, and reported.
> >
> > Second, if the various organizations are mapped, then only maps (and
> > uids/gids) authorized by those maps can be used. Any hanky panky on the
> > client host will ONLY involve those accounts/uids already on the client.
> > They will NOT be able to map to accounts/uids that are assigned to the
> > other organization. Again, attempts to access improper accounts will be
> > detected by the server, blocked,  and reported.
>
> I agree with Søren on this.  If the client is compromised such that the
> attacker can manipulate the maps (i.e. root) then there is no reason why
> the attacker can't just "su" to any UID it wants (regardless of mapping)
> and NFS is none-the-wiser.

Absolutely true. The attacker can do the "su" to any uid. Which is why the
server must be the one to provide the mapping service. The server does not
have to accept the UID unless it is one of the entries in the authorized map.

This isolates the penetration to only the accounts authorized to the
penetrated host.

And even root can be blocked from access to the server - in fact, root
could be mapped to any uid by the server (say for the purpose of remote
configuration files). The penetrated client can only access accounts that
were authorized by the server map.

> If the client is trusted to mount NFS, then it is also trusted enough not
> to use the wrong UID.  There is no "more" or "less" safe in this regard.

It is only trusted to not misuse the uids that are mapped for that client. If
the client DOES misuse the uids, then only those mapped uids will be affected.
UIDS that are not mapped for that host will be protected.

It is to ISOLATE the penetration to the host that this is done. The server
will not and should not extend trust to any uid not authorized to that host. 
This is what the UID/GID maps on the server provide.

