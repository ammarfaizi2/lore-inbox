Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUHQKID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUHQKID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 06:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUHQKIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 06:08:02 -0400
Received: from mail.gmx.de ([213.165.64.20]:142 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264750AbUHQKH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 06:07:58 -0400
X-Authenticated: #453372
Message-ID: <4121D919.1070205@gmx.net>
Date: Tue, 17 Aug 2004 12:08:25 +0200
From: Daniel Paschka <monkey20181@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040630
X-Accept-Language: en-us, en, de-de, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with CIFS
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA7C6E22D0B7F297BDDD6EDB0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7C6E22D0B7F297BDDD6EDB0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I was trying to use CIFS, but it failed to mount my samba shares whereas 
mounting a share of a Win2K PC worked.

I dowloaded and compiled the newest samba-server, but that didn't help 
either so I investigated a bit.

After googling if someone else was experiencing this problem I became a 
bit iritated because I only found a handful results, none helped to 
solve this problem in any way.

So I narrowed the problem down myself.

In fs/cifs/cifssmb.c around line 238 the cifs modul expects a 16 Byte 
GUID, where samba only send 14 bytes consisting of some random numbers 
followed by my workgroupname: WG.
So I to set my workgroupname to something longer with enabled me to 
mount my share.

I am not sure what the right behaviour is (must cifs accept shorter 
seqenzes or must samba send some dummy bytes to fill up to 16 Bytes), 
but I think it should be possible to mount shares in workgroups which 
names are shorter the 4 Bytes.

Help would be appreciated
Daniel

--------------enigA7C6E22D0B7F297BDDD6EDB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBIdkflycClYdpvAkRAlLnAJ4lvffiaI/9/9HdxwKp1Bzhyn0/cwCfVtjJ
r5IH74xBnqnpsLSF5sVJxOo=
=UYxf
-----END PGP SIGNATURE-----

--------------enigA7C6E22D0B7F297BDDD6EDB0--
