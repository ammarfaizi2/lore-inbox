Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271453AbVBEN0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271453AbVBEN0A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 08:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271395AbVBENZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 08:25:59 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:49363 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S271425AbVBENZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 08:25:45 -0500
Message-ID: <4204C94C.8030506@free.fr>
Date: Sat, 05 Feb 2005 14:25:32 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.11-rc3-mm1 : can't insmod dm-mod
References: <20050204103350.241a907a.akpm@osdl.org>	<4204880A.3010703@free.fr> <20050205032605.764eedac.akpm@osdl.org>
In-Reply-To: <20050205032605.764eedac.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6EAAC196E82061DCE62B5044"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EAAC196E82061DCE62B5044
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Le 05.02.2005 12:26, Andrew Morton a écrit :
> Laurent Riffard <laurent.riffard@free.fr> wrote:
>
>>Le 04.02.2005 19:33, Andrew Morton a écrit :
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
>> >
>>
>> loading dm-mod module fails with this message :
>>
>> FATAL: Error inserting dm-mod
>> (/lib/modules/2.6.11-rc3-mm1/kernel/drivers/md/dm-mod.ko): Device or resource busy
>>
>> The following line appears in dmesg :
>>
>> register_blkdev: failed to get major for device-mapper
>
>
> You've enabled CONFIG_BASE_SMALL and so the major_names[] hashtable has
> just one element.  device-mapper uses dynamic major allocation, the range
> of which is limited to the size of the top-level major_names[] array.  You
> ran out of slots and register_blkdev() failed.

Ok, selecting CONFIG_BASE_FULL=y solved the problem.

Thanks for your help.

--
laurent

--------------enig6EAAC196E82061DCE62B5044
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCBMlXUqUFrirTu6IRAvUnAJ9zDuH3SR4VFrzys8KXuktqD1J21QCfS9Yu
nlD9WiQYGuLFBjnvUJouM8U=
=ABDn
-----END PGP SIGNATURE-----

--------------enig6EAAC196E82061DCE62B5044--
