Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWC1A3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWC1A3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWC1A3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:29:51 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:16260 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751180AbWC1A3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:29:51 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Subject: Re: Fwd: Faster resuming of suspend technology.
Date: Tue, 28 Mar 2006 10:28:21 +1000
User-Agent: KMail/1.9.1
Cc: Jim Crilly <jim@why.dont.jablowme.net>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, xen-devel@lists.xensource.com
References: <200603211133.AA00855@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603272357.AA00920@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
In-Reply-To: <200603272357.AA00920@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4635319.t1Zdxsjekg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603281028.25627.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4635319.t1Zdxsjekg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 28 March 2006 09:57, Jun OKAJIMA wrote:
> >I wasn't thinking suspend2 was the topic, but I'll freely admit my bias
> > and say I think it's the best tool for the job, for a number of reasons:
> >
> >First, speed is not the only criteria that should be considered. There's
> > also memory overhead, the difference in speed post-resume, reliability,
> > flexibility and the list goes on.
> >
> >Second, Xen would not be the most practical candidate now. It would be
> > slower than suspend2 because suspend2 is reading the image as fast as t=
he
> > hardware will allow it (Ok. Perhaps algorithm changes could make small
> > improvements here and there). In contrast, what is Xen doing? I'm not
> > claiming knowledge of its internals, but I'm sure it will have at least
> > some emphasis on keeping other vms (or whatever it calls them) running
> > and interactive while the resume is occuring. It will therefore surely =
be
> > resuming at something less than the fastest possible rate.
> >
> >Additionally, Xen cannot solve the problems raised by the kernel lacking
> >complete hotplug support. Only further development in the kernel itself
> > can address those issues.
>
> I made very easy testing.
>
> H/W
>   CPU:Sempron64 2600+
>   MEM:1G    for Xen3.0 (I put 768MB for dom0, and 256MB for domU)
>       256MB for swsusp2
>   WAN:100Mbps FTTH ( up to about 8MBytes/sec , from ISP's web server).
>   HDD:250G 7200rpm ATA
>   DVD:x16 DVD-R ATA
> S/W
>   SuSE10 with Xen3.0
>   Using KDE3 desktop, with Firefox and OOo 2.0 Writer launched.
>
> Performance:
> swsusp2    -> about 10sec after "uncompressing Linux kernel".
>               (from HDD, of course.)

How was suspend2 configured? On a 7200rpm ATA drive, I'd expect 36MB/s=20
throughput. That alone would give you your 10s. But if you add LZF=20
compression to the mix, you should be able to resume in half the time=20
(literally - LZF usually acheived ~50% compression on an image).

> Xen resume -> almost same! But needs to boot dom0 first.

Impressive. I was afraid it might take much longer. Is that getting all the=
=20
image in, or is more of an image pulled in as necessary?

> On Xen experiment, I booted dom0 from HDD, but loaded the suspend image
> from x16 DVD-R. And, it resumed about in 10sec including decompressing
> time of suspend image. This means, Xen can resume almost same speed
> as swsusp2 from DVD-R, with H/W abstraction which current swsusp2 lacks.
> (Note: I did vnc reconnection workaround manually, so the time is just
> an estimation.)
> And, for example, if you boot dom0 up within 10 sec, ( and this
> is quite possible, check my site http://www.machboot.com/), you can get
> KDE3+FF1.5+OOo2 workinig  within 20sec measured from ISOLINUX loaded,
> with x16 DVD-R. Yes, DVD is not slow any more!.
>
> And, I also tried to do Xen resume from Internet.
> What I did was very easy. Just did like this.
> (Sorry, no gpg yet.)
> # wget $URL -o - | gzip -d > /tmp/$TMP.chk && xm restore /tmp/$TMP.chk
>
> The result is, I succeeded to "boot" (actually resume) KDE3+FF1.5+OOo2
> in about 15 sec from Internet!. I believe this is the fastest record of
> Internet booting ever.

Impressive!

> What I want to say is, using Xen suspend is one way to "boot" your desktop
> faster, especially if you use big apps and big window manager.
>
> Note: This experiment is very easy one, and no guarantee of correctness or
> reproducitivity. Must have many mistakes and misunderstanding and
> misconception, so on. I am afraid that even me could not reproduce it.
> So, dont accept this figure on faith, but treat as just one suggestion.
> But, I believe my suggestion must be meaningful one.
> Dont you want to boot your desktop within 20 sec from x48 CD-R?
> I suggest that this is not just a dream, but maybe feasible.

=46or live cds, it might be attractive, but for your average hdd based=20
installation, I wouldn't think that using the cd would be that interesting.=
=20
Nevertheless, yes - booting more quickly from whatever media is desirable.

> >> I admit that Jim Crilly's concern is right, but with using Xen suspend,
> >> it can be solved very easily. What you do is just like this:
> >> [Xen DOM0]# wget

(pretend url removed so LKML servers don't think this is spam)

> >> gpg --verify debian.image
> >> [Xen DOM0]# xen --resume debian.image
> >
> >Given this example, I guess you're talking about Xen (or vmware for that
> >matter) providing an abstraction of the hardware that's really available.
> >Doesn't this still have the problems I mentioned above, namely that your
> > Xen image can't possibly have support for any possible hardware the user
> > might have, allowing that hardware to be used with full functionality a=
nd
> > full speed. Surely such any such solution must be viewed as second best,
> > at best?
>
> I have not checked this feature yet.
> I only have one Xen installed PC and to make matters worse,
> the condition of the PC is very unstable, so it is a bit tough
> to check this by myself.
>
> Do somebody know about this?
> I mean, Xen really does not have an abstraction layer of the H/W?

Yeah, I guess it would too. Sorry for my wonky thinking there.

> I think it must have and you can use the same suspend image on all Xen PC=
s.

Yeah.

Regards,

Nigel

--nextPart4635319.t1Zdxsjekg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKIMpN0y+n1M3mo0RAin3AJ0WtmDZSm2ZS4vwcBcYYTBqGnh0QgCfVOoK
xRyCTnhxZUVtKmcLoFY8DCY=
=lMcJ
-----END PGP SIGNATURE-----

--nextPart4635319.t1Zdxsjekg--
