Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270357AbUJTNXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270357AbUJTNXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270354AbUJTNQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:16:49 -0400
Received: from mx6.bluewin.ch ([195.186.4.209]:62885 "EHLO mx6.bluewin.ch")
	by vger.kernel.org with ESMTP id S270082AbUJTNL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:11:28 -0400
Message-ID: <417663F6.9060303@lenherr.name>
Date: Wed, 20 Oct 2004 15:11:18 +0200
From: Thomas Lenherr <thomas@lenherr.name>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug: File-corruption when reading from network-filesystem
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC7817B494072FD23FC8598BD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7817B494072FD23FC8598BD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've got some files (9 x ~200mB) on a server with nfs and smb installed 
and built the md5sums of these files on the server itself. Then I 
mounted the nfs on my workstation and let it check the md5sums of these 
files: something about 7/9 did not match. Then i just started md5sum 
again and let it check again the same files, the result: all md5sums 
matched! (And I saw on my network monitor there was almost load on the 
network as the files were still cached locally so it had only to check 
if they changed) (fyi: I got 2gB ram).
Then I made the same again with smbfs: i mounted the shares on my 
workstation, ran md5sum and got something like 3/9 unmatched files, ran 
it again and everything matched (again: the second time i got almost no 
transfer).
Then I tested the local filesystem (so i copied files from local to 
local and so on) and everything was fine.
In my next test i copied 4 files from the nfs on my local drive and let 
them check (3/4 did not match) and repeating this check had always the 
same result: always the same 3 files did not match and always the same 
file did match, so it seems, they really were saved that way. Then I 
deleted these local files, started cp again (this time it did not 
transfer much => cache) and made the check again: all files were ok! 
(same with smb)

BTW: I checked the server with an other workstation and everything went 
fine, so the server seems to be ok.

BTW2: When I do not mount the smbfs, but rather use smbclient to get the 
files they were always ok.

So it seems the files are transferred and cached correct on the client, 
but it's somehow badly read if it's not already cached...

Here some infos about my systems:
workstation:
- kernel vanilla 2.6.9 (on a gentoo-system) (not tainted)
- motherboard: asus pc-dl deluxe (bios version 1007)
- dual xeon 3.06ghz
- 2gb non-ecc ram (made a memtest)
- nfsv3 (tried as modul and built-in)

server:
- kernel vanilla 2.6.8.1 (on a gentoo-system) (did not update because it 
seems, the error is on the workstation)
- pII 400mhz
- 320mB non-ecc ram
- nfsv3 (built-in)
- smb 3.0.2a


I hope this is enough information... else just tell me what you need to 
know....

One last thing: I tried the whole thing from a knoppix 3.4 (kernel 
2.6.?) once from my workstation and once again from a third pc (beneath 
the server and my workstation):
same result: everything went fine from the third pc, but with the same 
knoppix on my workstation i got the results with the caching: when i 
accessed the files the second time everything was fine...
So I _think_ it must be some kind of a hardware-dependent kernel-bug of 
the 2.6 :(

anyway, TIA

Thomas Lenherr

--------------enigC7817B494072FD23FC8598BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBdmP83E1pPHX30VoRAg6AAKCbHDbMNwv65mEtLZCmEmOvQoxYBACeK3YR
hWKOvQ8dv2SE4n2EbbuGnm8=
=Clps
-----END PGP SIGNATURE-----

--------------enigC7817B494072FD23FC8598BD--
