Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUAIU3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAIU3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:29:14 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:44235 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264229AbUAIU24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:28:56 -0500
Date: Fri, 09 Jan 2004 15:28:32 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFDEAE6.4030503@metaparadigm.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ian Kent <raven@themaw.net>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3FFF0EF0.90807@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enigCB976E857DF6C1047F7DF8A1;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
 <3FFD9498.6030905@zytor.com> <3FFDEAE6.4030503@metaparadigm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB976E857DF6C1047F7DF8A1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Clark wrote:

> On 01/09/04 01:34, H. Peter Anvin wrote:
>
>> In many ways this returns to the simplicity of the autofs v3 design 
>> where the atomicity constraints where guaranteed by the VFS itself, 
>> *as long as* mount traps can be atomically destroyed with umounting 
>> the underlying filesystem.
>
>
> Do we need to revive Tigran's forced unmount patch 'badfs' ala FreeBSD's
> deadfs? Although it doesn't guarantee atomic unmount, it could help
> a lot with the tendancy to get stuck autofs mounts.
>
>   http://tinyurl.com/2hto8
>
> I've been long waiting for this functionality in mainline.


This is an interesting approach to killing off a mountpoint.  However, 
the problem in question is not the destruction of the mountpoints, but 
rather being able to 
check_activity_of_a_hierarchy_of_mountpoints/unmount_them_together 
atomically.  This cannot be done cleanly in userspace even when given an 
interface to do the check, someone can race in before userspace 
initiates the unmounts.  The alternative is to have userspace detach the 
hierarchy of mountpoints using the '-l' option to umount(8), but then we 
may still unneccesarily unmount the filesystem will someone is in it. 

I think that both HPA and I agree that this capability is needed in 
order to support lazy mounting of multimounts properly.    The issue 
that remains is *how* to do it. 

>
> I wonder if binding badfs over the mountpoint at the beginning of the
> potentially lengthy unmount process would improve the atomicity
> to userspace. ie although the unmount would proceed in the background,
> badfs would have been mounted at that point at the start of the process
> - mounts are atomic no?
>
> ~mc
>
The time required to unmount something is constant if we detach the 
mountpoint using a lazy umount.

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enigCB976E857DF6C1047F7DF8A1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//w7zdQs4kOxk3/MRAsGTAJwMR0IEgCMs5VxRFZ71cRI8TxW0AgCdEBc2
CIDvcCuT5lo3qBkRK1zeR/I=
=TCaT
-----END PGP SIGNATURE-----

--------------enigCB976E857DF6C1047F7DF8A1--

