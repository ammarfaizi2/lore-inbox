Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUGLKLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUGLKLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUGLKLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:11:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26528 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266777AbUGLKLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:11:44 -0400
Date: Mon, 12 Jul 2004 12:11:07 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712101107.GA31013@devserv.devel.redhat.com>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20040712100547.GF3933@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Mon, Jul 12, 2004 at 12:05:47PM +0200, Lars Marowsky-Bree wrote:
> On 2004-07-12T08:58:46,
>    Arjan van de Ven <arjanv@redhat.com> said:
> 
> > Running realtime and mlocked (prealloced) is most certainly not
> > sufficient for causes like this; any system call that internally
> > allocates memory (even if it's just for allocating the kernel side of
> > the filename you handle to open) can lead to this RT, mlocked process to
> > cause VM writeout elsewhere. 
> 
> Of course; appropriate safety measures - like not doing any syscall
> which could potentially block, or isolating them from the main task via
> double-buffering childs - need to be done. (heartbeat does this in
> fact.)

well the problem is that you cannot prevent a syscall from blocking really.
O_NONBLOCK only impacts the waiting for IO/socket buffer space to not do so
(in general), it doesn't impact the memory allocation strategies by
syscalls. And there's a whopping lot of that in the non-boring syscalls...
So while your heartbeat process won't block during getpid, it'll eventually
need to do real work too .... and I'm quite certain that will lead down to
GFP_KERNEL memory allocations.



--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA8mO6xULwo51rQBIRAi1UAJ0dZDU3dAEiyXfjhntigkxJTHt7hQCfWuKI
5nXGvlFq9X3B/mi/EWbh8vY=
=1Nlu
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
