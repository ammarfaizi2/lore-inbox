Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUCORtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbUCORtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:49:23 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:58602 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262635AbUCORtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:49:20 -0500
Date: Mon, 15 Mar 2004 10:49:19 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: =?iso-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UID/GID mapping system
Message-ID: <20040315174919.GW1144@schnapps.adilger.int>
Mail-Followup-To: Jesse Pollard <jesse@cats-chateau.net>,
	=?iso-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby> <20040310234640.GO1144@schnapps.adilger.int> <04031108083100.05054@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04031108083100.05054@tabby>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 11, 2004  08:08 -0600, Jesse Pollard wrote:
> On Wednesday 10 March 2004 17:46, Andreas Dilger wrote:
> > I agree with Søren on this.  If the client is compromised such that the
> > attacker can manipulate the maps (i.e. root) then there is no reason why
> > the attacker can't just "su" to any UID it wants (regardless of mapping)
> > and NFS is none-the-wiser.
> 
> Absolutely true. The attacker can do the "su" to any uid. Which is why the
> server must be the one to provide the mapping service. The server does not
> have to accept the UID unless it is one of the entries in the authorized map.

But this is true whether the client is mapping the UIDs or not.  The server
wouldn't know whether the client is mapping UIDs or not, so it shouldn't trust
UIDs from a client that isn't supposed to be using that UID.

> This isolates the penetration to only the accounts authorized to the
> penetrated host.

Still true regardless of client-side UID mapping.

> And even root can be blocked from access to the server - in fact, root
> could be mapped to any uid by the server (say for the purpose of remote
> configuration files). The penetrated client can only access accounts that
> were authorized by the server map.

Still true regardless of client-side UID mapping.

> > If the client is trusted to mount NFS, then it is also trusted enough not
> > to use the wrong UID.  There is no "more" or "less" safe in this regard.
> 
> It is only trusted to not misuse the uids that are mapped for that client. If
> the client DOES misuse the uids, then only those mapped uids will be affected.
> UIDS that are not mapped for that host will be protected.

Still true regardless of client-side UID mapping.

> It is to ISOLATE the penetration to the host that this is done. The server
> will not and should not extend trust to any uid not authorized to that host. 

Still true regardless of client-side UID mapping.


Maybe you are confusing some term "mapping" that you understand for the
server-side (related to allowing only certain UIDs for a particular host?)
with an unrelated operation of the same name that Søren is proposing
(which is just a simple uid->uid translation)?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

