Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUCITit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUCITaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:30:01 -0500
Received: from [193.108.190.253] ([193.108.190.253]:33468 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S262155AbUCIT2t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:28:49 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <04030910465700.32521@tabby>
References: <1078775149.23059.25.camel@luke>  <04030910465700.32521@tabby>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1078860500.3156.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 20:28:25 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 2004-03-09 kl. 17:46 skrev Jesse Pollard:
> Have you considered the problem of 64 bit uids? and gids?,

Er.. no. I just use the uid_t and gid_t. Are they 64bit? Why are they a problem?

> and unlimited number of groups assigned to a single user?

No. That's not my problem, is it? I just provide the mapping system.

> How about having to support multiple maps (one for each remote host
> that mounts a filesystem)?

The maps are on the client, so that's no issue. The trick is to make it
totally transparent to the filesystem being mounted, be it networked or
non-networked.

> These tables are going to have to be external to the kernel, and the kernel
> only caching those that are known to be active to speed up the search.

I suppose that would be a solution. But now that you know it's on the
client, is it still as big a problem? I don't think so, but I could be
wrong.

> I also suggest making it optional - or being able to specify a 1:1 mapping
> be assumed. And be used with an inverse table: UIDs that are NOT to be mapped
> (as in, all uids are mapped 1:1 EXCEPT ...)

That's the way it's done now. If there's no map in the file, it's just
passed through. And of course you don't have to supply any file at all!

> I have worked at centers that had about 1200 users on each of 5 compute 
> servers. Each compute server mounts the same filesystem from a server. IF
> and only if all systems are within one security domain (all users are common, 
> and have the same uid/gid list for all systems - a frequent case), do
> you not need a map.

Right.

> If each compute server is in a different security domain (unique user list)
> then you must have 5 maps (10 if you include group maps) for each filesystem.
> That adds up to 6000 entries in uid maps alone. If 64 bit uids are used (8
> bytes/uid) that becomes 48K for the example, with only ONE exported
> filesystem, and only uids. This might seem a lot, but consider exports to
> workstations - 150 workstations, and likely 2-5 uids each (at least
> one for admininistration use). That would be 150 maps (just uids), of only 5
> entries each - 750 entries, 6K (more reasonable).

Still, the server does not know this is going on. It's all on the
client, so the memory usage is limited.

-- 
Søren Hansen <sh@warma.dk>

