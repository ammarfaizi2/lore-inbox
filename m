Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUHaW1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUHaW1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUHaW0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:26:07 -0400
Received: from audiogram.mail.pas.earthlink.net ([207.217.120.253]:29633 "EHLO
	audiogram.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S269095AbUHaWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:22:24 -0400
Message-ID: <4134FA0B.6030404@monolith3d.com>
Date: Tue, 31 Aug 2004 15:22:03 -0700
From: John Myers <electronerd@monolith3d.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Pascal Schmidt <der.eremit@email.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: (was: Re: PATCH: cdrecord: avoiding scsi device numbering for ide
 devices)
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>	<412889FC.nail9MX1X3XW5@burner>	<Pine.LNX.4.58.0408221450540.297@neptune.local> <m37jrr40zi.fsf@zoo.weinigel.se>
In-Reply-To: <m37jrr40zi.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA84B8CBFF2E2AAF8D1EAE495"
X-ELNK-Trace: 8839a2c17b2169aa1aa676d7e74259b7b3291a7d08dfec791ff52d89a2172c4294bba5f4212ac4d7350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 66.122.68.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA84B8CBFF2E2AAF8D1EAE495
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christer Weinigel wrote:

> Pascal Schmidt <der.eremit@email.de> writes:

> [...] if I have write permisson to a CD burner, being able to
> burn a coaster by issuing strange commands is something I expect.
> Being able to destroy the firmware of the drive is not something I
> expect a normal user to be able to do.
> 
> There are at least three conflicting goals here:
> 
> 1. Only someone with CAP_SYS_RAWIO (i.e. root) should be able to do
>    possible destructive things to a device, and only root should be
>    able to bypass the normal security checks in the kernel (e.g. get
>    access to /dev/mem since access to it means that you can read and
>    modify internal kernel structures).
> 
> 2. A Linux system should have as few suid root binaries as possible.
> 
> 3. A normal user should be able to perform most tasks without needing
>    root.
> 

I hope this is not a stupid idea:

I propose a finer-grained approach to suid-root binaries. Perhaps, 
instead of having a single flag giving the binary all the rights and 
responsibilities of its owner, there could be a table/list/something of 
capabilities which we want to grant to the binary. This, of course, 
would be a privileged operation (perhaps a new capability?).

For example, we might want to grant cdrecord CAP_SYS_RAWIO. This way, we 
don't have to worry about cdrecord running as root and not dropping all 
the capabilities it doesn't need, by accident or by malice.

Further, and I realize that this would probably require major 
restructuring, perhaps there could be another field: for each capability 
we want to grant, a method to specify _where_ the binary can use that 
capability.

To extend the previous example: we might want to give cdrecord 
CAP_SYS_RAWIO just on, say, /dev/burner0 and /dev/burner1, but not 
/dev/hda. That way, some typo won't have us trying to burn cds with our 
hard disks.

Again, I hope it's not a stupid idea. I don't have a working 
implementation, and I'm not even sure if it's even possible, but it's a 
thought.
-- 
electronerd (jonathan s myers)
code poet and recycle bin monitor
programmer, monolith3d.com

--------------enigA84B8CBFF2E2AAF8D1EAE495
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBNPoXNh5QaxZowccRAlsEAJ96uze2Oni++RGyUy1apwelMSd49ACgrrw6
KQivlUlnPuR7NUqEcdRZzUQ=
=tB1v
-----END PGP SIGNATURE-----

--------------enigA84B8CBFF2E2AAF8D1EAE495--

