Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWAWSkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWAWSkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWAWSkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:40:53 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17307 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964876AbWAWSkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:40:52 -0500
Message-Id: <200601231840.k0NIelbp017964@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Al Boldi <a1426z@gawab.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream... 
In-Reply-To: Your message of "Mon, 23 Jan 2006 21:03:06 +0300."
             <200601232103.07007.a1426z@gawab.com> 
From: Valdis.Kletnieks@vt.edu
References: <200601212108.41269.a1426z@gawab.com> <20060122123335.GB26683@lnx-holt.americas.sgi.com>
            <200601232103.07007.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1138041646_2962P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Jan 2006 13:40:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1138041646_2962P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 Jan 2006 21:03:06 +0300, Al Boldi said:

> The idea here is to run inside swap instead of using it as an addon.
> In effect running inside memory cached by physical RAM.
> 
> Wouldn't something like this at least represent a simple starting point?

We *already* treat RAM as a cache for the swap space and other backing store
(for instance, paging in executable code from a file), if you're looking at
it from the 30,000 foot fly-over...

However, it quickly digresses from a "simple starting point" when you try to
get decent performance out of it, even when people are doing things that tend
to make your algorithm fold up.  A machine with a gigabyte of memory has on the
order of a quarter million 4K pages - which page are you going to move out to
swap to make room?  And if you guess wrong, multiple processes will stall as
the system starts to thrash. (In fact, "thrashing" is just a short way of
saying "consistently guessing wrong as to which pages will be needed soon"....)

But hey, if you got a new page replacement algorithm that performs better,
feel free to post the code.. ;)

Example of why it's a pain in the butt:

A process does a "read(foo, &buffer, 65536);".  buffer is declared as 16
contiguous 4K pages, none of which are currently in memory.  How many pages do
you have to read in, and at what point do you issue the I/O? (hint - work this
problem for a device that's likely to return 64K of data, and again for a
device that has a high chance of only returning 2K of data.....)

But yeah, other than all the cruft like that, it's simple. :)


--==_Exmh_1138041646_2962P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD1SMucC3lWbTT17ARAp4qAJ9LnWxo50kFa+ga5IcCh45hssp0XQCg8EIY
KUmT5K0gG1TMQY1L3zkXuVo=
=uKb6
-----END PGP SIGNATURE-----

--==_Exmh_1138041646_2962P--
