Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbULCKpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbULCKpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbULCKpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:45:20 -0500
Received: from imap.gmx.net ([213.165.64.20]:49073 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262149AbULCKpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:45:11 -0500
X-Authenticated: #4512188
Message-ID: <41B043AF.3070503@gmx.de>
Date: Fri, 03 Dec 2004 11:45:03 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org> <20041203093903.GE10492@suse.de> <41B03722.5090001@gmx.de> <20041203103130.GH10492@suse.de> <20041203103828.GI10492@suse.de>
In-Reply-To: <20041203103828.GI10492@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBFD25EDFFDAC80FECD8D362F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBFD25EDFFDAC80FECD8D362F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> On Fri, Dec 03 2004, Jens Axboe wrote:
> 
>>Funky. It looks like another case of the io scheduler being at the wrong
>>place - if raid sends dependent reads to different drives, it screws up
>>the io scheduling. The right way to fix that would be to io scheduler
>>before raid (reverse of what we do now), but that is a lot of work. A
>>hack would be to try and tie processes to one md component for periods
>>of time, sort of like cfq slicing.
> 
> 
> It makes sense to split the slice period for sync and async requests,
> since async requests usually get a lot of requests queued in a short
> period of time. Might even make sense to introduce a slice_rq value as
> well, limiting the number of requests queued in a given slice.
> 
> But at least this patch lets you set slice_sync and slice_async
> seperately, if you want to experiement.

An idea, which values I should try?

In generell I rather have the impression the problem I am experiencing 
is not the problem of the io scheduler alone or why do all show the same 
problem?

BTW, I just did my little test on the ide drive and it shows the same 
problem, so it is not sata / libata related.

Prakash

--------------enigBFD25EDFFDAC80FECD8D362F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBsEO1xU2n/+9+t5gRAth9AJ9LAQVDMif2Uuh6iKHR/jDFqD6HqgCgyPy3
CDS50cq/CjvJlliCVbRUAaI=
=X6nQ
-----END PGP SIGNATURE-----

--------------enigBFD25EDFFDAC80FECD8D362F--
