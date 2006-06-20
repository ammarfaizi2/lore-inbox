Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWFTJVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWFTJVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWFTJVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:21:19 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10966 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965225AbWFTJVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:21:18 -0400
Message-ID: <4497BE00.1040409@bull.net>
Date: Tue, 20 Jun 2006 11:21:04 +0200
From: Laurent Vivier <Laurent.Vivier@bull.net>
Organization: Bull S.A.S.
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Qi Yong <qiyong@fc-cn.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org>	<1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>	<Pine.LNX.4.64.0606091344290.5498@g5.osdl.org> <4497927F.4070307@fc-cn.com> <4497B126.4000408@bull.net> <4497B230.5000508@garzik.org>
In-Reply-To: <4497B230.5000508@garzik.org>
X-Enigmail-Version: 0.94.0.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 11:25:06,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 11:25:08,
	Serialize complete at 20/06/2006 11:25:08
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE3C54331D88F5F304C79CFE8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3C54331D88F5F304C79CFE8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Laurent Vivier wrote:
>> Qi Yong wrote:
>>> Linus Torvalds wrote:
>>>
>>>> On Fri, 9 Jun 2006, Stephen C. Tweedie wrote:
>>>> =20
>>>>
>>>>> When is the Linux syscall interface enough?  When should we just
>>>>> bump it
>>>>> and cut out all the compatibility interfaces?
>>>>>
>>>>> No, we don't; we let people configure certain obsolete bits out (a.=
out
>>>>> support etc), but we keep it in the tree despite the indirection
>>>>> cost to
>>>>> maintain multiple interfaces etc.
>>>>>  =20
>>>> Right. WE ADD NEW SYSTEM CALLS. WE DO NOT EXTEND THE OLD ONES IN
>>>> WAYS THAT MIGHT BREAK OLD USERS.
>>>>
>>>> Your point was exactly what?
>>>>
>>>> Btw, where did that 2TB limit number come from? Afaik, it should be
>>>> 16TB for a 4kB filesystem, no?
>>>> =20
>>>>
>>> Partition tables describe partitions in units of one sector.
>>> 2^(32+9) =3D 2T
>>>
>>> To prevent integer overflow, we should use only 31 bits of a 32-bit
>>> integer.
>>> 2^(31+12) =3D 8T
>>>
>>> There's _terrible_ hacks to really get to 16T.
>>>
>>> -- qiyong
>>>
>>
>> IMHO, a simple solution is to use "Logical Volume Manager" instead of
>> partition
>> manager: we create 64bit filesystem in a Logical Volume, not in a
>> partition.
>=20
> That doesn't solve anything, if you are not using a 64bit filesystem.

Sorry, I don't undestand why ???

You can use 32bit filesystem too, but you limit the size of the logical v=
olume
to be compatible with the filesystem you use. LVM allows to create severa=
l 32bit
volumes on a big (> 8T) disk (if exists)

But if we think further, as biggest disk is 750 GB (and I think even usin=
g HW
RAID, there is an HW limit something like 4 TB), we can imagine a big Vol=
ume
Group belonging several Physical Volumes divided in Logical Volumes: so w=
e
already use LVM, we don't need partition...)

>> "partitioning is obsolete" ;-)
>=20
> LVM is nothing but a partition manager...

LVM is more than a partition manager:
- it is arch-independent
- it is 64bit compliant
- it can gather together several disks
- it is flexible (you can add/remove/resize volume)
- it is modern (doesn't have primary/extended partition, doesn't have lim=
ited
number of partition)

so... it's a volume manager.

Regards,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4


--------------enigE3C54331D88F5F304C79CFE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEl74E9Kffa9pFVzwRAmr9AJ0VkvQKP5WhES+p/whValRAy3odcACePcuC
ozpZFb5XV9YfIuqjmG42qrQ=
=JSiI
-----END PGP SIGNATURE-----

--------------enigE3C54331D88F5F304C79CFE8--
