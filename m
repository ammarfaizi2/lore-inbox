Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272745AbRIGP7b>; Fri, 7 Sep 2001 11:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272743AbRIGP7V>; Fri, 7 Sep 2001 11:59:21 -0400
Received: from [195.89.159.99] ([195.89.159.99]:44789 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272747AbRIGP7I>; Fri, 7 Sep 2001 11:59:08 -0400
Date: Fri, 7 Sep 2001 16:58:52 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: kubla@sciobyte.de, joe@mathewson.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
Message-ID: <20010907165852.B8956@kushida.degree2.com>
In-Reply-To: <200109071534.KAA90220@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109071534.KAA90220@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Fri, Sep 07, 2001 at 10:34:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> > It can improve security if you use NFS over TCP over SSL...
> > That may be easier to configure than IPSec in some environments.
> 
> I've never seen that used. I assume the procedure is something like:
> 
> 1. login on client (requires home directory be local)
> 2. ssh to server (local window for password)

Or you can use the `openssl' program.

> 3. user mode mount to another directory (assuming not mounting working
>    directory - marked busy, though that might be allowed)
> 4. use another window for local usage.
> 
> 	mountd port has to be redirected
> 	nfsd port(s) have to be redirected (I think, might not apply to server)

Really, the only critical one if you're worried about people
reading/writing your data is nfsd.  mountd is second most important, but
not really if you're using the user-space NFS server.

> 	biod port(s) have to be redirected

No need for biod.

> 	lockd port(s) have to be redirected (unless nolocking)
> 	statd port(s) have to be redirected (not sure)

I'm not sure about statd either.  It would be safest to run this over SSL.

> And only a single user per host (not unreasonable).

You could have multiple users per host, with appropriate funky mounts so
each user can only access their own secure mounts.  Either mount in a
subdirectory of a user-private directory, or use the Plan9-style
per-user mount trees (experimental patches from Al Viro).

> Would it also work for windows/Macs?

If you put a Linux box in between to implement the SSL part :-)

It's pretty complicated, but then even a simple port-based firewall is
rather complicated with NFS.

Now, if somebody were to fix the portmapper and RPC libraries to use
sensible fixed ports, so we could sensibly firewall RPC services, they
might be tempted to implement automatic SSL tunnelling while they're
there...

-- Jamie
