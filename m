Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVGCGR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVGCGR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 02:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVGCGR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 02:17:29 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:30985 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261376AbVGCGRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 02:17:23 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050702160002.GA13730@janus> (message from Frank van Maarseveen
	on Sat, 2 Jul 2005 18:00:02 +0200)
Subject: Re: FUSE merging?
References: <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus>
Message-Id: <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 03 Jul 2005 08:16:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After some thinking, the whole "not allowing namespace differences
> based on user id" philosophy is unenforcable and not even true sometimes
> nowadays. Think NFS: have a look at the unfsd server, you'll be surprised
> what it can do. Think any other networked file system exported by a
> machine with an unusual disk file-system underneath. IIRC ncpfs does
> this on the server based on access and thus based on uid.

Hmm, do you mean returning different directory contents based on uid?

> (hmm, I _hated_ it seeing empty directories only because I had no access
>  to anything below. Based on that I'd prefer EACCES instead of seeing an
>  empty mount stub when FUSE denies access to root or any other user.)

Well, it works that way currently, and there doesn't seem to be any
real problem with it.

> The thing is, root rules the _local_ part of the name space. So it should
> make a _huge_ difference if FUSE can fiddle with that or only with what's
> below the leaf nodes.

I don't really understand what you mean by "local".

The problem with this leaf node philosophy, is that it's not really
consistent.  You can ensure that a mountpoint is a leaf node at mount
time, but you can force it to remain a leaf node after the mount.  So
I don't see why this check at mount time would make _any_ difference.

> > > What is your opinion about replacing the ptrace check by a signal check
> > > (later on, no hurry)?
> > 
> > Maybe.  You'd still have to convince me, that signals sent to suid
> > programs are not a security problem.
> 
> google kill(2):
> 
> 	http://www.opengroup.org/onlinepubs/007908799/xsh/kill.html
> 
> It is _defined_ behavior. So, it is up to the quality of the programmer
> whether or not it results in a security problem ;-)

Ahh, right.

The info leak argument still holds, but it's pretty weak.

So if the current behavior causes a problem for sombody, and relaxing
the check from ptraceability to killability fixes it, then I'll
consider doing it.  Until then, let's keep the more secure check.

Miklos
