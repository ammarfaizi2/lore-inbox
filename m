Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUCHPRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUCHPQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:16:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59087 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262508AbUCHPQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:16:44 -0500
Date: Mon, 8 Mar 2004 16:16:25 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andy Isaacson <adi@hexapodia.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
Message-ID: <20040308151625.GC3999@devserv.devel.redhat.com>
References: <20040307144921.GA189@elf.ucw.cz> <20040307164052.0c8a212b.akpm@osdl.org> <20040308063639.GA20793@hexapodia.org> <1078738772.4678.5.camel@laptop.fenrus.com> <404C8CBB.1030008@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <404C8CBB.1030008@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 08, 2004 at 10:09:47AM -0500, Chris Friesen wrote:
> Arjan van de Ven wrote:
> >>Note that there are some applications for which it is a *bug* if an
> >>mlocked page gets written out to magnetic media.  (gpg, for example.)
> >>
> >
> >mlock() does not guarantee things not hitting magnetic media, just as
> >mlock() doesn't guarantee that the physical address of a page doesn't
> >change.
> 
> The mlock() man page sure seems to hint that they do, by explicitly 
> describing its use by high-security data processing as a way to keep the 
> information from getting to disk.

... and explicitly describing that this is not a 100% thing due to suspend
etc etc. 

----
mlock disables paging for the memory in the range starting at addr with
length len bytes. All pages which contain a part of the specified memory
range are guaranteed be resident in RAM when the mlock system call returns
successfully and they are guaranteed to stay in RAM until the pages are
unlocked by munlock or munlockall, until the pages are unmapped via munmap,
or until the process terminates or starts another program with exec.  Child
processes do not inherit page locks across a fork.
-----

that is what it guarantees. it guarantees that you don't hard-fault.
The rest of the manpage talks about potential usages but immediatly
describes the crypto one as non-solid

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFATI5IxULwo51rQBIRAhEQAJ95v3AFBibomdAvQgGJGkrfRDvO3QCcDLWT
wUX3tFTWdZR0dLVXB41goNg=
=UTEo
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
