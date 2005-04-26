Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVDZJGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVDZJGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVDZJGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:06:38 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:47273 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261406AbVDZJGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:06:31 -0400
Date: Tue, 26 Apr 2005 11:05:39 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@parcelfarce.linux.theplanet.co.uk,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426090539.GB9131@vagabond>
References: <3WWn1-2ZC-3@gated-at.bofh.it> <3WWwR-3hT-35@gated-at.bofh.it> <3WWwU-3hT-49@gated-at.bofh.it> <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 25, 2005 at 17:17:35 +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Jan Hudec <bulb@ucw.cz> wrote:
> > On Mon, Apr 25, 2005 at 11:58:50 +0200, Miklos Szeredi wrote:
> Use a daemon to keep an additional reference to the namespace? That's UGLY.

It's as ugly as ssh-agent.

But I have to say, that I really like attachable namespaces bettern than
descriptor mount bind. It's a hell lot simpler to work with.

> With attachable namespaces, the whole thing should be as simple as
> (pseudocode)
> mknamespace -p users/$UID # (like mkdir -p)
> setnamespace users/$UID   # (like cd)

Well, yes and no. We should probably just have a syscall
int join_namespace(pid_t pid)
which would join the namespace process pid uses. And then have a PAM
session module, that would attach the namespace of the first user's
session (creating new namespace if this is the first session).

> Optionally, the namespaces and their private mounts might be scheduled to
> be removed if the last user is gone, or they need to be persistent,
> depending on the applicaton (e.g. ssh used as rexec or shared mounts).

I'd have them garbage-collected. When last process using them goes away,
so does the namespace. If that's not what you want, start a persistent
process for the user.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCbgRjRel1vVwhjGURAvjVAJ4gxvVwupwfSc957O2plamX5ezalgCbBXPj
aSZBZScuwiTy5swOcQQKnc8=
=NMIP
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
