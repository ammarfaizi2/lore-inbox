Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTE3EAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTE3EAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:00:21 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:14984 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S263246AbTE3EAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:00:17 -0400
Date: Fri, 30 May 2003 06:12:12 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@digeo.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       bonganih@discovery.co.za
Subject: Re: 2.5.70-mm1 Strangeness
Message-Id: <20030530061212.22b2c625.bonganilinux@mweb.co.za>
In-Reply-To: <20030529175135.7b204aaf.akpm@digeo.com>
References: <20030529221622.542a6df5.bonganilinux@mweb.co.za>
	<20030529135541.7c926896.akpm@digeo.com>
	<20030529.171114.34756018.davem@redhat.com>
	<20030529175135.7b204aaf.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.9uDUT_BwMqH+3("
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.9uDUT_BwMqH+3(
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2003 17:51:35 -0700
Andrew Morton <akpm@digeo.com> wrote:

> "David S. Miller" <davem@redhat.com> wrote:
> >
> >    From: Andrew Morton <akpm@digeo.com>
> >    Date: Thu, 29 May 2003 13:55:41 -0700
> > 
> >    The ip_dst_cache seems unreasonably large.  Unless your desktop is a
> >    backbone router or something.
> > 
> > Lots of DST entries can result on any machine actually.  We create one
> > per source address, not just per destination address.  So if you talk
> > to a lot of sites, or lots of sites talk to you, you'll get a lot of
> > DST entries.
> > 
> > Regardless, 80MB _IS_ excessive.  That's nearly 400,000 entries.
> > It definitely indicates there is a leak somewhere.
> > 
> > Although it say:
> > 
> > ip_dst_cache       19470  19470   4096    1    1
> > 
> > Which is 19470 active objects right?
> 
> Yes, 19470 entries.  But note that each entry is 4096 bytes.
> 
> Something seems to have gone and bumped the object size from 240 bytes up
> to 4096.  This is actually what I want CONFIG_DEBUG_PAGEALLOC to do, but I
> don't think it does it yet.  
> 
> Bongani, if you have CONFIG_DEBUG_PAGEALLOC enabled then please try turning
> it off.  And maybe Manfred can throw some light on what slab has done
> there.

Cool, I'll let you know how it goes. I'll also try davem,s suggestion about 
/proc/sys/net/ipv4/route/max_size

--=.9uDUT_BwMqH+3(
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+1tod+pvEqv8+FEMRAoFZAJ9S3Xj+yep9kyQHuFN+fb37uVtXNgCeOz9c
b611jl6L7oPf+JPFyNrLLs4=
=LeHZ
-----END PGP SIGNATURE-----

--=.9uDUT_BwMqH+3(--
