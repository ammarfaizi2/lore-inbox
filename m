Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUEXHGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUEXHGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUEXHGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:06:05 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:28873 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262208AbUEXHFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:05:40 -0400
Date: Mon, 24 May 2004 17:05:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
Message-Id: <20040524170504.29a8d001.sfr@canb.auug.org.au>
In-Reply-To: <20040523232920.2fb0640a.akpm@osdl.org>
References: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
	<20040523232920.2fb0640a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_17_05_04_+1000_cPs6GuVN2YQH/1aS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_17_05_04_+1000_cPs6GuVN2YQH/1aS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Sun, 23 May 2004 23:29:20 -0700 Andrew Morton <akpm@osdl.org> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > This patch allows us to dynamically add virtual disks to an iSeries
> >  partition. It works like this: after you have created the virtual disk
> >  file on OS/400 and attached it to the Linux partition, you need to read
> >  /sys/bus/vio/drivers/viodasd/probe.  This will do the probe and list any
> >  new disks discovered.
> > 
> >  This was the nicest way I could think of doing this as the interface to
> >  the hypervisor is polled ...
> 
> Is it possible to present all the virtual disks as partitions of a single
> disk, use the "partition table" to query what is present?

The virtual disks are just that: disks.  They present as /dev/iseries/vda
etc and have their own partitions. I can't change that, I will get skinned
by current users.  It was bad enough when I removed the ide emulation hack
... :-)

(Just in case of confusion: the "Linux partition" I referred to above is a
logical partition fo the whole machine.)

> Or to generate a hotplug event when a disk is added?  Even if there's no
> notification to the kernel, it should be possible to generate the hotplug
> events in response to a /proc-based trigger.

I guess that would be possible.  In this case I am trying to do the
minimum change.

> It's a shame you didn't cc linux-kernel on this - the blockdev police would
> have better ideas than I.

I have now sent the patch to LKML and cc'd this reply there as well.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__24_May_2004_17_05_04_+1000_cPs6GuVN2YQH/1aS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsZ6gFG47PeJeR58RArc+AKCWSpiDJ/8b2tWV83vNdCh/hq5jcgCgtaee
m68Dc0EBw12u0n+UqkVD5gI=
=iqGy
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_17_05_04_+1000_cPs6GuVN2YQH/1aS--
