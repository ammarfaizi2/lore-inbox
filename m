Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUHDNwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUHDNwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUHDNwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:52:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265805AbUHDNwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:52:08 -0400
Date: Wed, 4 Aug 2004 15:51:10 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804135110.GA13270@devserv.devel.redhat.com>
References: <20040803230614.C1924@build.pdx.osdl.net> <Pine.LNX.4.44.0408040825180.7628-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408040825180.7628-100000@dhcp83-102.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 04, 2004 at 09:31:54AM -0400, Rik van Riel wrote:
> > > @@ -392,8 +392,11 @@ int ipcperms (struct kern_ipc_perm *ipcp
> > >  		granted_mode >>= 3;
> > >  	/* is there some bit set in requested_mode but not in granted_mode? */
> > >  	if ((requested_mode & ~granted_mode & 0007) && 
> > > -	    !capable(CAP_IPC_OWNER))
> > > -		return -1;
> > > +	    !capable(CAP_IPC_OWNER)) {
> > > +		if (!can_do_mlock())  {
> > > +			return -1;
> > > +		}
> > > +	}	
> > 
> > I still don't see the use for this one.  I believe it duplicates
> > SHM_HUGETLB check that's already there.
> 
> I'm not sure about your comments here.  However, I'm also not
> quite sure about this piece of code.  Arjan ? ;)

hmmm looks bullshit now that I look at it again.


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBEOnOxULwo51rQBIRAvk+AKCfFvg4MlelN9B94E36IfioUnWrmACdF0br
oFJaDh9jGYER9yOlepbLhS0=
=TVY/
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
