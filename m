Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132347AbRASPVW>; Fri, 19 Jan 2001 10:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRASPVN>; Fri, 19 Jan 2001 10:21:13 -0500
Received: from host213-120-148-5.btopenworld.com ([213.120.148.5]:39269 "EHLO
	nvlonlx01.nv.london") by vger.kernel.org with ESMTP
	id <S132347AbRASPVI>; Fri, 19 Jan 2001 10:21:08 -0500
Date: Fri, 19 Jan 2001 15:20:44 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Mo McKinlay <mmckinlay@gnu.org>, Peter Samuelson <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A68591B.417EC21E@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.30.0101191516360.2331-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

  > Thanks. I think having the option of the namespace augmentation would be
  > useful, in terms of supporting existing filesystems. On NTFS, ":" is not
  > a legal filename character anyway. The namespace augmentation suggested
  > in the paper would allow filesystems like NTFS to work as they should,
  > and all other filesystems to ignore it.

This was the tack I originally took - but I realised it would eventually
cause problems - not least because rather than returning an error when a
user does something not supported like most actions do, the operation
behaves differently - which is a little confusing.

(Take symbolic linking, for example - if you ln -s on VFAT, you get
'operation not permitted' - named stream/EA operations on a filesystem
that doesn't support them should return the same, IMHO).

Also, I don't like the idea of bypassing POSIX in this manner (using ':'
as a delimeter), even if the underlying filesystem *may* not support it.

What's to say that ext4 (or whatever) won't support named streams, but
still allow ':'? Your solution as it stands would break in that situation
(assuming I've not missed something :)

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpoW04ACgkQRcGgB3aidfncVgCgm19oUQqgGSW7XNCZwoWB/bIj
2W0AoK64xCfbjcamj3F5fDyBtVg8KQBa
=PEu2
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
