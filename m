Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVA0Gyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVA0Gyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVA0Gyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:54:36 -0500
Received: from h80ad2540.async.vt.edu ([128.173.37.64]:31753 "EHLO
	h80ad2540.async.vt.edu") by vger.kernel.org with ESMTP
	id S262509AbVA0GyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:54:19 -0500
Message-Id: <200501270653.j0R6rvgH006041@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
Cc: John Richard Moser <nigelenki@comcast.net>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL? 
In-Reply-To: Your message of "Thu, 27 Jan 2005 01:40:12 EST."
             <200501270640.j0R6eD7N000647@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org> <41F8530C.6010305@comcast.net> <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk> <41F86176.3010000@comcast.net>
            <200501270640.j0R6eD7N000647@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106808836_17814P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jan 2005 01:53:57 -0500
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106808836_17814P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Jan 2005 01:40:12 EST, Valdis.Kletnieks@vt.edu said:

> You may want to use a properly timed initcall() to create a callback that
> happens after proc_misc_init() happens, but before userspace gets going, and
> walk through the /proc tree at that time and cache info on the files you care
> about, so you don't have to re-walk /proc every time permission() gets called

Blarg.

The proper time to walk the /proc filesystem and cache such info, is, of
course, in the ->sp_post_addmount() LSM hook.  Check @mnt and @mountpoint_nd to
see if it's /proc, and if so, go snarf all the info you need to make your tests
fast..

Not sure if you'd need to redo your cache in sp_post_remount(), for the odd case
where /proc gets remounted....


--==_Exmh_1106808836_17814P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB+JAEcC3lWbTT17ARAruVAJ0bvvnPIw1MEPVHDeTX0pT9NgcVmgCgylpY
hmJ2KT3NYgc5oK1641RMNgk=
=tcbQ
-----END PGP SIGNATURE-----

--==_Exmh_1106808836_17814P--
