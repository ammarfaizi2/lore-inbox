Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271367AbRIGGTK>; Fri, 7 Sep 2001 02:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271371AbRIGGTA>; Fri, 7 Sep 2001 02:19:00 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:29195 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271367AbRIGGSz>;
	Fri, 7 Sep 2001 02:18:55 -0400
Message-ID: <20010907102605.A26028@castle.nmd.msu.ru>
Date: Fri, 7 Sep 2001 10:26:05 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Ben Greear <greearb@candelatech.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <9n8ev1$qba$1@cesium.transmeta.com> <3B985FC6.B41000A3@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3B985FC6.B41000A3@candelatech.com>; from "Ben Greear" on Thu, Sep 06, 2001 at 10:48:54PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 10:48:54PM -0700, Ben Greear wrote:
> "H. Peter Anvin" wrote:
> 
> > In autofs, I use the following technique to determine if the IP number
> > for a host is local (and therefore vfsbinds can be used rather than
> > NFS mounts):
> > 
> > connect a datagram socket (which won't produce any actual traffic) to
> > the remote host with INADDR_ANY as the local address, and then query
> > the local address.  If the local address is the same as the remote
> > address, the address is local.
> 
> That will always work, even when you have multiple ethernet
> interfaces??

It will work almost always, except cases where administrator set different
preffered sources in local routes.
I.e. it is indeed a very good approximation, but autofs shouldn't still hang
or do nasty things if the check with the datagram socket shows that address
isn't local, but in reality it happens to be local.
A subtle misbehavior or loss of efficiency are acceptable, in my opinion.

Theoretically, it might be possible to create a configuration which gives
false positive in this check, but I can't see how it may be harmful...

	Andrey
