Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUFVLXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUFVLXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 07:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUFVLXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 07:23:33 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:41627 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262389AbUFVLXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 07:23:31 -0400
Date: Tue, 22 Jun 2004 21:23:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] iSeries virtual i/o sysfs files
Message-Id: <20040622212319.2a0c121b.sfr@canb.auug.org.au>
In-Reply-To: <40D7CFBC.30706@pobox.com>
References: <20040622140405.4cb6f8e1.sfr@canb.auug.org.au>
	<40D7CFBC.30706@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__22_Jun_2004_21_23_20_+1000_QZ.664CoBE+yJ9I="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__22_Jun_2004_21_23_20_+1000_QZ.664CoBE+yJ9I=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Jeff,

On Tue, 22 Jun 2004 02:20:44 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Stephen Rothwell wrote:
> > 
> > OK, this is what the patch does.  All the iSeries virtual devices now
> > appear in /sys/devices/vio and /sys/bus/vio/devices.  Unfortunately,
> > apart from the veth devices, there are all possible devices there at
> > the moment - I need to think about how to reduce it but that requires
> > moving all the probe code into vio.c ...
> 
> I'm not sure I entirely parse the third sentence in this paragraph, but 
> nonetheless...

What it means is that, as the patch stands, a node is created in
/sys/devices/vio (and /sys/bus/vio/devices) for all possible virtual
devices not just those actually present.  The exception is for virtual
ethernets which are relatively easy to enumerate.  To enumerate the other
devices precisely, I will need to extract the device probing code from
each of the other device drivers (viodasd, viocd and viotape) and include
some (hopefully simplified) form of the code directly into the bus probing
code for iSeries in vio.c.

> My general idea was that vio should be presented as a bus, so that 
> userland could enumerate all vio devices.  This approach seems along 
> these lines, and I have no objections to the patch.

Great, thanks.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__22_Jun_2004_21_23_20_+1000_QZ.664CoBE+yJ9I=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2BavFG47PeJeR58RAtqMAKDmKwlusH7YK83xvqhXffrhwWcFygCcCE6H
S3Dp+BzjIuz48QtMpwDUYbI=
=dA7W
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Jun_2004_21_23_20_+1000_QZ.664CoBE+yJ9I=--
