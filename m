Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbUKLTbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUKLTbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUKLTbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:31:08 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:58302 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261813AbUKLTaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:30:16 -0500
Message-Id: <200411121930.iACJUA59030215@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Ed Schouten <ed@il.fontys.nl>
Cc: Diego <foxdemon@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some ideas about % of CPU for a process 
In-Reply-To: Your message of "Fri, 12 Nov 2004 19:55:33 +0100."
             <20041112185533.GA16907@il.fontys.nl> 
From: Valdis.Kletnieks@vt.edu
References: <d5a95e6d0411121047690a0b51@mail.gmail.com>
            <20041112185533.GA16907@il.fontys.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2078791266P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Nov 2004 14:30:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2078791266P
Content-Type: text/plain; charset=us-ascii

On Fri, 12 Nov 2004 19:55:33 +0100, Ed Schouten said:

> On Fri 12 Nov 2004 03:47 PM, Diego wrote:
> > I'm trying to define a % of cpu for a process, but i don?t have idea
> > about how i can do it. For example, i said that my process need 40% of
> > CPU during its lifetime, how can i do it in kernel 2.6?
> > Thanks for ideas.
> 
> Why don't you 'ps' the process and divide the running time through the
> starting time?

I think he's trying to make a 40% *allotment* - as in "this number cruncher
is authorized to take 40% of the CPU for the next 6 hours".  The devil always
ends up being in the details however - things I've seen scheduling systems
fail with in the past:

1) Process is allowed to take 40% of the CPU, but so overcommits memory that
it can't actually *get* it because 65% of the time, the system is in a page
wait from the swap partition. (iterate across any *other* shared resource
that isn't directly tied to CPU).

2) Process is allowed to take 40% of the CPU, and no more - and somebody gets
torqued off because the system is 60% idle.

3) Process is allowed to take 40% at all times, and more if available - and
somebody gets torqued off because it's slow to notice the system has bogged
down - so it's still getting 60% for another 2-3 minutes when we're loaded
before the scheduler catches up.

4) And you always get the whiner who complains it's getting 39% or 41%. ;)

Saying "40% of the CPU" is easy - the fun is in the corner cases...

--==_Exmh_-2078791266P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBlQ9BcC3lWbTT17ARAq3lAJwP++h357UBIYn1FVVf8u+VIRZoggCfQWJi
FoYGX72jPxfat3sR4lPBtz0=
=PO2p
-----END PGP SIGNATURE-----

--==_Exmh_-2078791266P--
