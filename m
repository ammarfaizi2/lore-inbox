Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSG0U5J>; Sat, 27 Jul 2002 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318822AbSG0U5J>; Sat, 27 Jul 2002 16:57:09 -0400
Received: from adsl-66-136-196-103.dsl.austtx.swbell.net ([66.136.196.103]:40320
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S317772AbSG0U5I>; Sat, 27 Jul 2002 16:57:08 -0400
Subject: Re: About the need of a swap area
From: Austin Gonyou <austin@digitalroadkill.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Ville Herva <vherva@niksula.hut.fi>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200207271904.g6RJ4jT27545@Port.imtp.ilyichevsk.odessa.ua>
References: <3D42907C.mailFS15JQVA@viadomus.com>
	 <20020727144228.GQ1548@niksula.cs.hut.fi>
	 <200207271904.g6RJ4jT27545@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1027803522.18360.17.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 Jul 2002 15:58:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-27 at 19:02, Denis Vlasenko wrote:
> On 27 July 2002 12:42, Ville Herva wrote:
> > >     I created a swap area twice as large as my RAM size (just an
> > > arbitrary size), that is 1G. I've tested with lower sizes too. My RAM
> > > is never filled (well, I haven't seen it filled, at least) since I
> > > always work on console, no X and things like those. Even compiling
> > > two or three kernels at a time don't consume my RAM. What I try to
> > > explain is that the swap is not really needed in my machine, since
> > > the memory is not prone to be filled.
> >
> > So you have 512MB of RAM? All the programs (without X) will fit there
> > easily. You'll still have plenty for disk cache.
> 
> With today's software I'd say you probably need swap if you have
> less than 256M of RAM and use X. You _definitely_ need it if you have less 
> than 128M.

You really must think beyond the desktop as well. With large servers
running many databases, or a single large database, you will inherently
use swap. Maybe not much, but it will get used. 
On a P4 Xeon 1MB L3 server with 8GB ram, I've got 4GB swap configured,
and use about 2 of that with a 4 oracle instances running. The largest
instance is ~700GB, whereas the 4 others are ~30GB ea. 

In this scenario you have a large SHMMAX defined (4GB in this case), or
50% available RAM. As Oracle, Java, and other bits are used in the
system threading or not, most of the entirety of the availble ram will
eventually get used. The available to cache ratio on a box like this
with 2.4.19-rc1 is ~2% free ram, and 95% cached, and 3% active. 
Swap is ~50% right now. So regardless of how much ram you have, you will
swap some, somewhere.

> X is regularly uses 50+ megs, Mozilla and OpenOffice are big
> leaky beasts too. Hopes for improvements are dim.
> 
> Really, we have to fight software bloat instead of adding tons of RAM
> and swap, but sadly we have quite a number of vital desktop software
> packages overbloated.

This is another scenario as well. On my 1.333Ghz Athlon-C I've got 512MB
ram. My swap total is 265064 KB, but my free is 263600KB. I'm not
swapping much right now, but I also just rebooted last night. Either
way, Memfree is 19256 KB. After running some video applications or
ogg123 or something like this, the swap typically will go up to ~40 or
~100 mb used. Thankfully the -aa tree reclaims this very well, and it
will usually go back down to nearly 0KB used..or like it is now at 2-3MB
used. 

> I am enormously grateful for all kernel developers for Linux kernel
> which is:
> 
> Memory: 124644k/129536k available
> (1403k kernel code, 4436k reserved, 403k data, 152k init, 0k highmem)
> 
> Only 1.5 megs of code, 0.5 megs of data!
> --
> vda
> -

-- 
Austin Gonyou <austin@digitalroadkill.net>
