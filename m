Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWBBVbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWBBVbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWBBVbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:31:11 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:37802 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932272AbWBBVbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:31:10 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 07:27:43 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202093859.GA1884@elf.ucw.cz> <200602021353.30802.rjw@sisk.pl>
In-Reply-To: <200602021353.30802.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1387327.c0Xc1q20bk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602030727.48855.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1387327.c0Xc1q20bk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 22:53, Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday 02 February 2006 10:38, Pavel Machek wrote:
> > > Its limitation , however, is that it requires a lot of memory for the
> > > system memory snapshot which may be impractical for systems with
> > > limited RAM, and that's where your solution may be required.
> >
> > Actually, suspend2 has similar limitation. It still needs half a
> > memory free, but it does not count caches into that as it can save
> > them separately.
>
> I didn't know that.  [If that is the case, I wonder what Nigel means by
> the "whole memory image".  Nigel?]

The LRU almost always easily accounts for more 50% of memory in use. Suspen=
d2=20
writes LRU pages to disk, then uses those pages to store the atomic copy of=
=20
the remainder of memory. That's how I overcome the 50% problem and still=20
really do get a full image of memory. If the LRU is smaller than the=20
remainder of memory in use, we allocate extra memory if possible. If that=20
still doesn't give enough memory for the atomic copy, we seek to free memor=
y=20
until that constraint is satisfied. If we free everything we can, and still=
=20
can't satisfy that constraint, we give up and return control to the user. I=
n=20
99% of the cases, however, no freeing of memory is required and the user=20
really can get a full image of memory saved.

> > That means that on certain small systems (32MB RAM?), suspend2 is going
> > to have big advantage of responsivity after resume. But on the systems
> > where [u]swsusp can't suspend (6MB RAM?), suspend2 is not going to be
> > able to suspend, either. [Roughly; due to bugs and implementation
> > differences there may be some system size where one works and second one
> > does not, but they are pretty similar]
>
> Generally speaking, my perception is that suspend2 may be preferrable bel=
ow
> 256 MB of RAM.  Moreover there are some people who seem to prefer
> entirely kernel-based suspend, and I'm not going to develop the code
> in swap.c and disk.c any further (of course with the exception of bugfixes
> etc.).  Nigel has done it already so perhaps there is a room for his code,
> too, _provided_ _that_ it is accepted.

All of the machines I regularly use have 512M+ of memory. Suspend2 is=20
definitely preferable on them because I've worked hard to maximise I/O=20
throughput. Last time I measured swsusp throughput, it was 16MB/s on my old=
=20
Omnibook. Suspend2 achieved ~25MB writing and 50MB/s reading when using LZF=
=20
compression (933 Celeron), or the 35MB/s uncompressed (the maximum throughp=
ut=20
that could be achieved according to tools like hdparm -t) on the same syste=
m.=20
With the same drive in my new laptop (amd64 M34), I get ~70MB/s read/write=
=20
(depending on cpufreq settings). My 3G P4s at work and home do about 70
(w)/110(r) MB/s. (All of this is using LZF compression).

Regards,

Nigel

> Greetings,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1387327.c0Xc1q20bk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4nlUN0y+n1M3mo0RAkdTAKCBwKjjeltmCQDT0zULREwYxH9WygCfc55F
cvm+XAnKve+KfQeUy1G9X3Q=
=Wvas
-----END PGP SIGNATURE-----

--nextPart1387327.c0Xc1q20bk--
