Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318964AbSHMIBJ>; Tue, 13 Aug 2002 04:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318965AbSHMIBJ>; Tue, 13 Aug 2002 04:01:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13005 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318964AbSHMIBI>;
	Tue, 13 Aug 2002 04:01:08 -0400
Date: Tue, 13 Aug 2002 04:04:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Erik Andersen <andersen@codepoet.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc and logging
In-Reply-To: <20020813075256.GA26384@codepoet.org>
Message-ID: <Pine.GSO.4.21.0208130356480.1689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Aug 2002, Erik Andersen wrote:

> May I suggest that the poor souls that wish to use NFS mounts
> should be statically linking their NFS mount app vs glibc, uClibc
> or whatever.  I see little need for you to recreate that whole
> evil pile of mush...  What happens next week when someone wants
> to get their NFS mount password from LDAP or NIS?  Will you add
> klibc nss support?  Or when someone just needs to have wordexp()
> and regcomp() and....  I think you are on a very slippery slope.
> Keep it simple.  If people want to do stuff that is complex, they
> can pay the price for the added baggage.  Even if people need to
> statically link one app vs uClibc or dietlibc, they are still
> going to get a very small binary.  And they can still include all
> their nasty closed source binary only playtoys in the initrootfs
> linked vs klibc.

We do have nfsroot support in the kernel.  If we are going to move it
into the userland, we _must_ have the code for that.  "Use glibc" is
laughable - try to link anything statically against that dungpile and
see what size you'll get.

Said that, we don't need anywhere near the full RPC support for nfsroot
and I'm not sure that we want it in libc even if it will be implemented.
"Use -lrpc" is perfectly OK.

Stuff needed for nfsroot
	a) is purely sequential (full-sync)
	b) we need 2 or 3 RPC calls
	c) we can open-code marshalling for these
IOW, the most complex part of that is handling of timeout and possibly -
logics with retransmit.  Other than that it's filling an array, doing
sendmsg(), waiting for reply, and checking several words in received array.

