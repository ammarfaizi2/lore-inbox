Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUEXHht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUEXHht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUEXHht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:37:49 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:42443 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264098AbUEXHgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:36:45 -0400
Date: Mon, 24 May 2004 17:36:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
Message-Id: <20040524173616.3e8e3676.sfr@canb.auug.org.au>
In-Reply-To: <1085383408.20577.7.camel@nighthawk>
References: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
	<20040523232920.2fb0640a.akpm@osdl.org>
	<20040524170504.29a8d001.sfr@canb.auug.org.au>
	<1085383408.20577.7.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_17_36_16_+1000_gbUVsRX5GRm1OC5k"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_17_36_16_+1000_gbUVsRX5GRm1OC5k
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 24 May 2004 00:23:28 -0700 Dave Hansen <haveblue@us.ibm.com> wrote:
>
> On Mon, 2004-05-24 at 00:05, Stephen Rothwell wrote:
> > On Sun, 23 May 2004 23:29:20 -0700 Andrew Morton <akpm@osdl.org> wrote:
> > > Or to generate a hotplug event when a disk is added?  Even if there's no
> > > notification to the kernel, it should be possible to generate the hotplug
> > > events in response to a /proc-based trigger.
> > 
> > I guess that would be possible.  In this case I am trying to do the
> > minimum change.
> 
> I think this would be a worthy change.  It's the same kind of thing that
> we're planning for memory hotplug on ppc64: initiate a probe in /sys
> somewhere, and get a few hotplug events in short order.  The only
> difference is that we'll probably require a write for the probe to
> trigger.  You don't want a 'grep -r foo /sys' to cause probes, do you?

OK, I am convinced.  :-)  Now to learn about hotplug. :-(

> > +       printk(VIOD_KERN_INFO "disk %d: %lu sectors (%lu MB) "
> > +                       "CHS=%d/%d/%d sector size %d%s\n",
> > +                       dev_no, (unsigned long)(d->size >> 9),
> > +                       (unsigned long)(d->size >> 20),
> > +                       (int)d->cylinders, (int)d->tracks,
> > +                       (int)d->sectors, (int)d->bytes_per_sector,
> > +                       d->read_only ? " (RO)" : "");
> > +
> 
> Isn't it a little naughty to be spitting out so many values in a /sys
> file?  

Thats not the sys file ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__24_May_2004_17_36_16_+1000_gbUVsRX5GRm1OC5k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQFAsaXwFG47PeJeR58RAsY/AKCAtigyXjdeQuYnTUTVPBITbeiJQwCYy5U/
KJgQ/gydUKmgGOZbYDlDzA==
=d9Vv
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_17_36_16_+1000_gbUVsRX5GRm1OC5k--
