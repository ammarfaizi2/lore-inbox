Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbUCJP33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUCJP33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:29:29 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:35310 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262650AbUCJP3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:29:22 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
Date: Wed, 10 Mar 2004 09:28:59 -0600
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04030910465700.32521@tabby> <1078855981.1768.12.camel@homer>
In-Reply-To: <1078855981.1768.12.camel@homer>
MIME-Version: 1.0
Message-Id: <04031009285900.02381@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 March 2004 13:28, Søren Hansen wrote:
> tir, 2004-03-09 kl. 17:46 skrev Jesse Pollard:
> > Have you considered the problem of 64 bit uids? and gids?,
>
> Er.. no. I just use the uid_t and gid_t. Are they 64bit?

32 bits currently.

>
> > and unlimited number of groups assigned to a single user?
>
> No. That's not my problem, is it? I just provide the mapping system.

but the mapping system has to be able to handle it.

> > How about having to support multiple maps (one for each remote host
> > that mounts a filesystem)?
>
> The maps are on the client, so that's no issue. The trick is to make it
> totally transparent to the filesystem being mounted, be it networked or
> non-networked.

The server cannot trust the clients to do the right thing. After all, the
administrator of the server is not in charge of the client. Therefore, the
server cannot trust the client. Hence, the server must perform the mapping.

> > These tables are going to have to be external to the kernel, and the
> > kernel only caching those that are known to be active to speed up the
> > search.
>
> I suppose that would be a solution. But now that you know it's on the
> client, is it still as big a problem? I don't think so, but I could be
> wrong.

As stated above, the server cannot trust the client.

> > I also suggest making it optional - or being able to specify a 1:1
> > mapping be assumed. And be used with an inverse table: UIDs that are NOT
> > to be mapped (as in, all uids are mapped 1:1 EXCEPT ...)
>
> That's the way it's done now. If there's no map in the file, it's just
> passed through. And of course you don't have to supply any file at all!
>
> > I have worked at centers that had about 1200 users on each of 5 compute
> > servers. Each compute server mounts the same filesystem from a server. IF
> > and only if all systems are within one security domain (all users are
> > common, and have the same uid/gid list for all systems - a frequent
> > case), do you not need a map.
>
> Right.
>
> > If each compute server is in a different security domain (unique user
> > list) then you must have 5 maps (10 if you include group maps) for each
> > filesystem. That adds up to 6000 entries in uid maps alone. If 64 bit
> > uids are used (8 bytes/uid) that becomes 48K for the example, with only
> > ONE exported filesystem, and only uids. This might seem a lot, but
> > consider exports to workstations - 150 workstations, and likely 2-5 uids
> > each (at least one for admininistration use). That would be 150 maps
> > (just uids), of only 5 entries each - 750 entries, 6K (more reasonable).
>
> Still, the server does not know this is going on. It's all on the
> client, so the memory usage is limited.

The server cannot trust the client. Think about it. The security domain of the
server (when using maps at all) will NOT be the same as the client. Since 
different organizations are in charge of the server, how can that server trust
the client? A violation (even minor) on the client could cause a significant
violation of the server. As in a shipping department mounting a server, and a
financial client mounting from the same server - a violation on the shipping
client COULD expose financial data; and the server not even know. Or worse -
the shipping depeartment has been outsourced...

The server MUST control access to its resources.

Been there, seen that. Have NO desire to have to talk to the FBI about "due 
diligence".
