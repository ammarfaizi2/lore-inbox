Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbSKRWo3>; Mon, 18 Nov 2002 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbSKRWo2>; Mon, 18 Nov 2002 17:44:28 -0500
Received: from stine.vestdata.no ([195.204.68.10]:32411 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S266982AbSKRWo1>; Mon, 18 Nov 2002 17:44:27 -0500
Date: Mon, 18 Nov 2002 23:51:19 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Rashmi Agrawal <rashmi.agrawal@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
Message-ID: <20021118235119.G30589@vestdata.no>
References: <3DD90197.4DDEEE61@wipro.com> <200211181611.06241.pollard@admin.navo.hpc.mil> <20021118232230.F30589@vestdata.no> <200211181641.37773.pollard@admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211181641.37773.pollard@admin.navo.hpc.mil>; from pollard@admin.navo.hpc.mil on Mon, Nov 18, 2002 at 04:41:37PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 04:41:37PM -0600, Jesse Pollard wrote:
> Actually, I was thinking that each server served a different mountpoint
> instead of both providing the same one.

I know.

> I'm not sure how the locks currently would be provided unless the
> distributed lock from the shared storage interacts with each servers statd
> properly. Otherwise you will already have problems.

"The distributed lock"? Are you talking about scsi-level locks?
No, there is no link between the locks on the lower levels and NFS.

> Second, I thought that statd didn't care about the lock requests coming
> from two IP numbers. This should be no different than having two network
> interfaces attached to one server (and that works under Solaris). The
> client should be using the name from the IP number, not the router used
> between the client and server. I view the floating IP as existing behind
> a router using the real IP. Since none of the clients are using the real
> IP, the naming should remain consistant (I think).

Yes, it's simular to having two network interfaces on one server. If it
works on solaris then clearly it can be make to work on linux as well.

Older versions of nfs-utils used only the IP from
gethostbyname(gethostname); Clearly that didn't work for setups like
this.

I wrote a patch that made it possible to change the IP-address to a
"service-IP". That allowed us to do failover like described in an
earlier mail. 

Later that feature has been extended and modified by others. It is
possible that it now allows multiple IP-addresses. If that's the case,
then half the problem is solved. 

The other half remains though.


-- 
Ragnar Kjørstad
Big Storage
