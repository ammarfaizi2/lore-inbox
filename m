Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVGBQAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVGBQAR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVGBQAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 12:00:17 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:3768 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261189AbVGBQAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 12:00:03 -0400
Date: Sat, 2 Jul 2005 18:00:02 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050702160002.GA13730@janus>
References: <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 04:49:24PM +0200, Miklos Szeredi wrote:
> > 
> > All things considered I'd still prefer forbidding FUSE mounts on non-leaf
> > dirs. For name space sanity. And it may be easier to get the whole thing
> > accepted:
> > 
> 
> But I don't think it would matter in the acceptance of the mount
> hiding patch, since that patch was not rejected on the basis of what
> FUSE would use it for, rather for the general philosophy of not
> allowing namespace differences based on user id.

That would really be a loss.

After some thinking, the whole "not allowing namespace differences
based on user id" philosophy is unenforcable and not even true sometimes
nowadays. Think NFS: have a look at the unfsd server, you'll be surprised
what it can do. Think any other networked file system exported by a
machine with an unusual disk file-system underneath. IIRC ncpfs does
this on the server based on access and thus based on uid.

(hmm, I _hated_ it seeing empty directories only because I had no access
 to anything below. Based on that I'd prefer EACCES instead of seeing an
 empty mount stub when FUSE denies access to root or any other user.)

The thing is, root rules the _local_ part of the name space. So it should
make a _huge_ difference if FUSE can fiddle with that or only with what's
below the leaf nodes.

> > What is your opinion about replacing the ptrace check by a signal check
> > (later on, no hurry)?
> 
> Maybe.  You'd still have to convince me, that signals sent to suid
> programs are not a security problem.

google kill(2):

	http://www.opengroup.org/onlinepubs/007908799/xsh/kill.html

It is _defined_ behavior. So, it is up to the quality of the programmer
whether or not it results in a security problem ;-)

-- 
Frank
