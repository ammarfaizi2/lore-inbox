Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUDETkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbUDETkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:40:31 -0400
Received: from smtp-hub2.mrf.mail.rcn.net ([207.172.4.76]:20182 "EHLO
	smtp-hub2.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S263157AbUDETkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:40:24 -0400
Message-ID: <4071B622.20103@lycos.com>
Date: Mon, 05 Apr 2004 15:40:18 -0400
From: James Vega <vega_james@lycos.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Roeland <marco.roeland@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: fat32 all upper-case filename problem
References: <4070910E.7020808@lycos.com> <20040405103008.GB12373@localhost>
In-Reply-To: <20040405103008.GB12373@localhost>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2646F49A84B31FE13D3AFD0A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2646F49A84B31FE13D3AFD0A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marco Roeland wrote:
> You forgot a 'ls /usbdrive' *before* the 'touch'. Now we don't know
> whether it was empty before. We'll assume so.

Sorry. Yes, the directory was empty before the 'touch'.

>>debil% touch /usbdrive/CASE
>>debil% ls /usbdrive
>>case
> 
> 
> This suggests that you've mounted your usbdrive (vfat probably?)
> _specifically_ with the option to force lowercase filenames. The default
> is to preserve the case of the filename (to the filename *should* be CASE here)
> and to see both names as equals.

Here is the output from the 'mount' command:

/dev/sda1 on /usbdrive type vfat (rw,noexec,nosuid,nodev,uid=1000,gid=1000)

AFAIK, I did nothing to force lowercase filenames.

> Another possibility is that there *was* already a file called 'case' and
> that the actual writing of the 'CASE' file in the directory is postponed
> until some sort of 'sync' operation. This also would need a
> specific 'case-sensitive' mount option.
> 
> 
>>debil% ls /usbdrive/CASE
>>/usbdrive/CASE
>>debil% ls /usbdrive/case
>>/usbdrive/case
> 
> 
> The above normally can only happen if there really are *two* files, one
> name 'case' and the other 'CASE'. So a case sensitive filesystem.

There was only one file as shown by the ls output above.  Also, the few people 
that I have asked to reproduce this are always able to ls both 'case' and 'CASE' 
even after a remount or waiting for the cached entry to expire.

>>debil% umount /usbdrive && mount /usbdrive
>>debil% ls /usbdrive/case
>>/usbdrive/case
>>debil% ls /usbdrive/CASE
>>ls: /usbdrive/CASE: No such file or directory
> 
> 
> Looks like you have mounted the thing with case-sensitiviy *and* forcing
> lowercase filenames always. Either there is a bug in the combination,
> or perhaps there is a bug in that the uppercase name is cached for some
> time in VFS until the lowercase name is reread from the usbdrive?

Again, I'm not knowingly specifying either case-sensitivity or forced lowercase 
filenames.  The line in /etc/fstab is as follows:
/dev/sda1 /usbdrive auto (rw,noexec,nosuid,nodev,uid=1000,gid=1000) 0 0

> When you test this please be very careful to reproduce every start and
> end condition *exactly*. <Bad pun alert> It's very easy to look at
> Heisenbugs here, with all these virtual filenames in case space. </Bad
> pun alert>

Thank you for the suggestions. I'll keep these in mind for future testing.

--------------enig2646F49A84B31FE13D3AFD0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iEYEARECAAYFAkBxtigACgkQDb3UpmEybUAn2gCgl4KpeF0mUh/ctLzJzNUHaJxl
gj0AniS/XYD791rgjlnkS4dW7vlkewPP
=2NLQ
-----END PGP SIGNATURE-----

--------------enig2646F49A84B31FE13D3AFD0A--
