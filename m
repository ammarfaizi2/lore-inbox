Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129993AbQKIG5I>; Thu, 9 Nov 2000 01:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130294AbQKIG4t>; Thu, 9 Nov 2000 01:56:49 -0500
Received: from vp175121.reshsg.uci.edu ([128.195.175.121]:46602 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S130148AbQKIG4p>; Thu, 9 Nov 2000 01:56:45 -0500
Date: Wed, 8 Nov 2000 22:56:03 -0800
Message-Id: <200011090656.eA96u3Y22945@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Stange NFS messages - 2.2.18pre19
In-Reply-To: <20001109024949$4fc3@tornado.cs.columbia.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.17 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000 21:15:38 -0500, Scott McDermott <vaxerdec@frontiernet.net> wrote:
> Sasi Peter on Tue  7/11 23:28 +0100:
>> I'm getting this under moderate NFS load:
>> Nov  6 17:39:56 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
>> Nov  6 17:40:08 iq kernel: svc: unknown program 100227 (me 100003)
>> Nov  6 19:06:11 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
>> Nov  6 19:38:48 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
>> 
>> What do these means? Is this a kernel bug?
> 
> Your Suns are using TCP mounts, this got introduced into 2.2.18
> somewhere and is a bit broken, do a patch -R with
> ftp://oss.sgi.com/www.projects/nfs3/download/nfs_tcp-2.2.17.dif and
> these go away.  Suns try TCP mounts first.  Be careful to unmount them
> first or they will hang waiting for the TCP server to come back up.

I really really think this should be backed out -- or at the very least
disabled. The code wasn't part of the dhiggen merge, it wasn't tested,
and it doesn't work well. Heck, it's still experimental and not recommended
in 2.4.0-test.

What's worse, it will burn everybody out there who is using am-utils or 
an automounter that tries TCP mounts first. NFS/UDP server support in 2.2.18
is so much better than in previous versions, it would a shame to ruin
it with this ill-fated patch.


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
