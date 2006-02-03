Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWBCWaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWBCWaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWBCWaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:30:46 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:13745 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422677AbWBCWap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:30:45 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 21:47:18 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602031020.46641.nigel@suspend2.net> <200602030957.48626.rjw@sisk.pl>
In-Reply-To: <200602030957.48626.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2301397.HnQPEU7XHf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602032147.23782.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2301397.HnQPEU7XHf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 03 February 2006 18:57, Rafael J. Wysocki wrote:
> Hi,
>
> On Friday 03 February 2006 01:20, Nigel Cunningham wrote:
> > On Friday 03 February 2006 08:10, Rafael J. Wysocki wrote:
> > > I was referring to the (not so far) future situation when we have
> > > compression in the userland suspend/resume utilities.  The times of
> > > writing/reading the image will be similar to yours and IMHO it's
> > > usually possible to free 1/2 of RAM in a box with 512+ MB of RAM at a
> > > little cost as far as the responsiveness after resume is concerned.=20
> > > Thus on machines with 512+ MB of RAM
> > > both solutions will give similar results performance-wise, but the
> > > userland-driven suspend gives you much more flexibility wrt what you
> > > can do with the image (eg. you can even send it over the network if
> > > need be).
> > >
> > > On machines with less RAM suspend2 will probably be better
> > > preformance-wise, and that may be more important than the flexibility.
> >
> > Ok. So I bit the bullet and downloaded -mm4 to take a look at this
> > interface you're making, and I have a few questions:
> >
> > - It seems to be hardwired to use swap, but you talk about writing to a
> > network image above. In Suspend2, I just bmap whatever the storage is,
> > and then submit bios to read and write the data. Is anything like that
> > possible with this interface? (Could it be extended if not?)
>
> The swap partition was easy. :-)  However, there is the bmap() call that
> userspace processes can use, so it seems to be possible.  [BTW, the netwo=
rk
> is easy too, because it desn't require us to tamper with disks while
> suspended.]

Yes. I already did suspend to network last March, but haven't spent more ti=
me=20
on it since - it wasn't working perfectly, but it was working using a=20
modified userspace nbd client.

> > - Is there any way you could support doing a full image of memory with
> > this approach?
>
> I'm not sure, but I think that's possible.  For now I don't see major
> obstacles, but honestly I'll have to read your code (and understand it)
> to answer this question responsibly.

Ditto in reverse. I have to admit I'm still struggling to see what the=20
advantage to userspace is. At the moment, it seems to me like nothing more=
=20
than an extra layer of complexity and new possibilities for failure. Maybe =
my=20
attitude will change when I look at it more.

> > Would you take patches?
>
> Well, the code in question is already in the kernel (in -mm, but this
> doesn't matter here) and I'm not the maintainer of it, so I can't answer
> this question directly.  However, if you asked me whether I would _suppor=
t_
> any patches, I would say I had never opposed or supported a patch whithout
> trying to understand it.
>
> When I think I understand the patch, I try to value it, and I have two
> rules here:
> 1) The released code should always be functional.  [So I never submit
> untested patches without saying explicitly that they are untested and if I
> replace some code A with alternative code B, I do my best to ensure it
> won't break any existing setups.]
> 2) The software with this patch applied must be such that I would like to
> run it on my computer. [If I wouldn't, there's no chance I'll support it.]

No problems there. I only reboot when forced to, and suspend to disk by=20
default (or to put it another way, I eat my own dog food).

> > - Does the data have to be transferred to userspace? Security and
> > efficiency wise, it would seem to make a lot more sense just to be
> > telling the kernel where to write things and let it do bio calls like I=
'm
> > doing at the moment.
>
> First, there's a difference between efficiency and performance.
>
> For example, the kernel already contains the code for writing data to the
> disk or partition you are using for suspend.  By using bio directly to
> write to it you're duplicating the functionality of that code which is
> _inefficient_, although this need not be related to performance.  Worse
> yet, if some optimizations go to this code, you won't have them unless you
> notice and implement them once again.
>
> Similar observation applies to enryption and compression: There are
> libraries for encryption and compression that contain lots of different
> algorithms, so why should we try to duplicate that code?  It is more
> efficient to _use_ it, which can be done easily in the user space.

That's why I want to use the existing bio calls and crypto api support. I=20
don't use the swap read/write routines because... well I've forgotten the=20
reason 3 years later. Let me take a guess though - using swap routines migh=
t=20
corrupt LRU? One thing I do know is that the filewriter and swapwriter use=
=20
the same code to do the writing. I'd be more accurate in calling them=20
swap/file allocators now, as they really only calculate where to store the=
=20
image (and associated functions).

> This may hurt performance a bit, but usually not so far that anyone will
> notice.  [Actually on my box the suspending and resuming userland
> utilities I use for testing perform the I/O-related operations _faster_
> than the built-in swsusp code, although they seemingly do the same
> things.]

Strange.

> Second, as far as the security is concerned, the only problem I see is th=
at
> a malicious attacker may be able to read unencrypted suspend image from t=
he
> system or submit his own specially crafted image which would require
> root-equivalent access anyway.  However to prevent this you can set
> whatever paranoid permissions you desire on /dev/snapshot and implement
> your suspending utility as a daemon running in a privileged security ring
> (the resume is run from and initrd anyway).

True, and an unencrypted image on disk is as vulnerable as any other data o=
n=20
disk anyway.

> The biggest advantage of the userland-based approach I see is that there
> may be _many_ implementations of the suspending and resuming tools
> and they will not conflict.  For example, if Distributor X needs an exotic
> feature Y wrt suspend (various vendor-specific eye-candies come to mind or
> transferring the image over a network), he can implement it in his userla=
nd
> tools without modifying the kernel.  Similarly, if Vendor V wants to use
> paranoid encryption algorithm Z to encrypt the image, she can do that
> _herself_ in the user space.

True, but can you really imagine people doing that? The one instance I can=
=20
think of was the donation of LZF support to Suspend2 a couple of years back.

> We only need to provide reference tools and we won't be asked to implement
> every feature that people may want in the kernel.

I don't want it to be true, but I think you're being naive in saying that :=
)=20
We'll see, won't we?

> > - In your Documentation file, you say say opening /dev/snapshot for
> > reading is done when suspending. Shouldn't that be open read for resume
> > and write for suspend?
>
> No.  During suspend the image is read from the kernel and saved by a
> userland tool and analogously during resume.

Oh ok.

> > I'm not saying I'm going to get carried away trying to port Suspend2 to
> > userspace. Just tentatively exploring. But if I did decide to port it, =
my
> > default position would be to seek not to drop a single feature. I hope
> > that's not too unreasonable!
>
> That's fine.  I think we have the same goal which is a reasonable set of
> features available to the users.
>
> [Heh, that looks like a good starter for the userland suspend FAQ.  Perha=
ps
> I should save this message. ;-)]

Thanks.

Nigel

> Greetings,
> Rafael

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2301397.HnQPEU7XHf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD40LLN0y+n1M3mo0RAh81AJ0TgrfAkNQofy7/olchdEr5FoAm/wCeIkO+
ioj/ldwkCh82UNV4tbiHZE4=
=crhw
-----END PGP SIGNATURE-----

--nextPart2301397.HnQPEU7XHf--
