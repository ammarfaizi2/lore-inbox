Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUC0HtR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 02:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUC0HtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 02:49:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261605AbUC0HtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 02:49:14 -0500
Date: Sat, 27 Mar 2004 08:44:49 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, davej@redhat.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040327074449.GA10596@devserv.devel.redhat.com>
References: <20040325224726.GB8366@waste.org> <16483.35656.864787.827149@napali.hpl.hp.com> <20040325180014.29e40b65.akpm@osdl.org> <20040326110619.GA25210@redhat.com> <16484.29095.842735.102236@napali.hpl.hp.com> <20040326104904.59f7a156.akpm@osdl.org> <16484.37279.839961.375027@napali.hpl.hp.com> <20040326123303.7a775b02.akpm@osdl.org> <1080333938.7033.0.camel@laptop.fenrus.com> <20040326131736.1cc6a939.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20040326131736.1cc6a939.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 26, 2004 at 01:17:36PM -0800, Andrew Morton wrote:
> If someone does
> 
> 	prefetch_range(4090, 20);
> 
> on 4k pagesize, what should we do?

well if the datastructure you prefetch crosses pageboundary you know both
pages are safe to prefetch.

> Issuing a single
> 
> 	prefetch 4090
> 
> sounds reasonable.
> 
> In that case I'm arranging for it to perform
> 
> 	prefetch (4096 - 32)
> 
> in that case, which seems neater.

well prefetch is defined as "get the cacheline the address is located in";
eg the cpu does the rounding to cacheline size for you.

(btw prefetch stride isn't the cacheline size! it's how far you're supposed
to prefetch ahead to get any useful gain, si for aligning and stuff it's
useless)

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAZTDwxULwo51rQBIRAhEDAJ9/j+kL6xE6NzDbqcfBobex/NXzawCcCOLk
5asjxaFSfljkaCWBoxjQ+Ug=
=keC+
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
