Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWAQGJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWAQGJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWAQGJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:09:00 -0500
Received: from mail.autoweb.net ([198.172.237.26]:10970 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751081AbWAQGJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:09:00 -0500
Message-ID: <43CC89F0.7060109@michonline.com>
Date: Tue, 17 Jan 2006 01:08:48 -0500
From: Ryan Anderson <ryan@michonline.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: git-diff-files and fakeroot
References: <43CC5231.3090005@michonline.com> <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net> <20060117052758.GA22839@mythryan2.michonline.com> <95E085A7-B910-4C01-BA6E-43971A6F5F97@mac.com>
In-Reply-To: <95E085A7-B910-4C01-BA6E-43971A6F5F97@mac.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3CCE83DC59F1E70AA1CE7F7A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3CCE83DC59F1E70AA1CE7F7A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kyle Moffett wrote:

> On Jan 17, 2006, at 00:27, Ryan Anderson wrote:
>
>> On Mon, Jan 16, 2006 at 06:36:39PM -0800, Junio C Hamano wrote:
>>
>>> BTW, Ryan, I suspect this is where you try to append "-dirty" to 
>>> the version number.  But I wonder why you are doing the build  under
>>> fakeroot to begin with?  Wasn't the SOP "build as
>>> yourself, install as root"?
>>
>>
>> That's exactly what started this search, because I was running  "make
>> deb-pkg". (Effectively.)  dpkg-buildpackage wants to think it  is
>> running as root, either via sudo or via fakeroot.  I had my  build
>> environment switched over entirely to fakeroot, as it just  seems to
>> be a better practice, but I've temporarily switched back  to sudo.
>>
>> However, your explanation has pointed out to me how I can solve  this
>> - run "fakeroot -u" instead of "fakeroot", and I think it will  be
>> fixed.
>
>
> You should run "make" first, then after that completes run "fakeroot 
> make deb-pkg".  I think this is similar to what the Debian package 
> "kernel-package" does, except it substitutes an alternate "debian/" 
> directory.  IIRC, it just runs "make install" as a normal user to a 
> staging directory, then runs "$(ROOTCMD) dpkg-deb -b [...]" to build 
> the package.  IMHO it's somewhat of a cleaner solution, and I've used 
> it for several years now with no issues.


Right "make all && fakeroot make deb-pkg" was failing, because with
CONFIG_LOCALVERSION_AUTO set, I was both getting a "-dirty" string
appended to the version, as well as something awfully close to a full
rebuild due to the version number changing, and on top of all that, the
dpkg-buildpackage would fail, as "-dirty" doesn't have a number in it
(hence why you see dfsg1 or ubuntu0 in version strings.)

I think I might take your suggestion, and fix up the builddeb script to
do the "run as root" part itself, rather than needing to do it outside. 
It would make it possible to just run "make oldconfig deb-pkg" which
would make things a little bit simpler.

-- 

Ryan Anderson
  sometimes Pug Majere


--------------enig3CCE83DC59F1E70AA1CE7F7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzInzfhVDhkBuUKURApaMAJ4rveLOnQY5RsybPVOGzfIvFIGCagCg/xfU
42/u9uplhOGZjtz94AYJRQo=
=OnhI
-----END PGP SIGNATURE-----

--------------enig3CCE83DC59F1E70AA1CE7F7A--
