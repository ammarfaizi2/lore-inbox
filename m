Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVJEFSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVJEFSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 01:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVJEFSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 01:18:00 -0400
Received: from smtp.enter.net ([216.193.128.24]:60681 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932413AbVJEFR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 01:17:59 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Marc Perkel <marc@perkel.com>
Subject: Re: what's next for the linux kernel?
Date: Wed, 5 Oct 2005 01:22:33 +0000
User-Agent: KMail/1.7.2
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com>
In-Reply-To: <4342DC4D.8090908@perkel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart45141318.44vOTiU38x";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510050122.39307.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart45141318.44vOTiU38x
Content-Type: multipart/mixed;
  boundary="Boundary-01=_aryQDxxIrtxzqoO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_aryQDxxIrtxzqoO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 04 October 2005 19:47, Marc Perkel wrote:
> I think it's time for some innovative thinking and for people to
> step outside the Linux box and look around at other operating
> systems for some good ideas. I'll run through a few ideas here.
>
> Reiser 4 - The idea of building a file system on top of a database
> is the right way to go. Reiser is onto something here and this is a
> technology that needs to be built upon. It's current condition is a
> little on the week side - no ACLs for example - but the underlying
> concept is ound.

A filesystem built on top of a database? Isn't that introducing=20
complexity into something that should be as simple as possible so=20
that the number of possible errors is reduced?

But then, I do not have experience with filesystem design and=20
implementation, so I cannot make a suggestion on this front.

> Novell Netware type permissions. ACLs are a step in the right
> direction but Linux isn't any where near where Novell was back in
> 1990. Linux lets you - for example - to delete files that you have
> no read or write access rights to.=20

As someone else pointed out, this is because unlinking is related to=20
your access permissions on the parent directory and not the file.

> Netware on the other hand=20
> prevents you from deleting files that you can't write to and if you
> have no right it is as if the file isn't there. You can't even see=20
> it in the directory.=20


This is just adding a layer of security through hiding data. I=20
personally don't like this idea for a number of reasons, not the=20
least of which is that it is the access permissions of the directory=20
that control whether or not you can see a file. This and the previous=20
comment about unlinking of files is, IIRC, actually part of the POSIX=20
standard.

> Netware also has inherited permissions like=20
> Windows and Samba has and this is doing it right.=20

This would only be a bonus with ACL's. It makes no real sense to=20
propogate a directories permissions down to the files in a directory=20
since an directory you can list the contents of has at least 1=20
execute bit set.

> File systems and=20
> individual directories should be able to be flagged as
> casesensitive/insensitive.=20

This would be a rarely used feature and would break many tools. Having=20
an extra bit would also require modifying the kernel and I doubt=20
anyone wants to tackle such a job, as it would also break all extant=20
filesystems.

> Permissions need to be fine grained and=20
> easy to use. Netware is a good example to emulate.

I do agree with this, but have to point out that this is already=20
allowed for under POSIX and a number of filesystems support this.=20
It's called "POSIX ACL's" in the kernel configuration system. Since I=20
don't use them on my home system (I see no need since it's just me=20
and whatever hacker has managed to penetrate the system (to date: 0))=20
I do use ACL's (POSIX and otherwise) on all the systems I maintain=20
for my various clients (providing the OS supports them)

> The bootup sequence of Linux is pathetic. What an ungodly mess. The
> FSTAB file needs to go and a smarter system needs to be developed.
> I know this isn't entirely a kernel issue but it is somewhat
> related.

I'll have to disagree about FSTAB - this is something that is at the=20
peak of it's usefulness and changing or removing it would require the=20
people that maintain the core utilities to rewrite mount(8) almost=20
entirely.

However, when it comes to the boot sequence as controlled by init(8) I=20
have to agree. I'm personally working on an entirely new set of=20
init-scripts for my system and have thought about seeing if anyone=20
has ever released an init(8) that is more functional than the basic=20
GNU/FSF version. If there was an init(8) that could run the scripts=20
in parallel I'd be using it as soon as I had a set of scripts lined=20
up that were designed to be run in parallel.

> I think development needs to be done to make the kernel cleaner and
> smarter rather than just bigger and faster. It's time to look at
> what users need and try to make Linux somewhat more windows like in
> being able to smartly recover from problems. Perhaps better error
> messages that your traditional kernel panic or hex dump screen of
> death.

lol. Nope. The kernel panic could be refined to contain even more=20
information and be even more user-friendly but it is definately=20
light-years ahead of a Windows BSOD. Now if you're talking about the=20
errors as seen by users of applications that's not a kernel issue and=20
is the purview of the application developers.

> The big challenge for Linux is to be able to put it in the hands of
> people who don't want to dedicate their entire life to
> understanding all the little quirks that we have become used to.
> The slogan should be "this just works" and is intuitive.

Yep. I do agree with that. However, until the rest of the big=20
companies catch up to the ones that already support Linux this will=20
never happen. Several of my non-business maintenance clients have=20
inquired abotu Linux and I've had to tell them to just stick with=20
Windows because they rely on a rather large number of Windows only=20
programs (that do _not_ run under Wine) and/or are not technically=20
enough inclined to be able to handle the learning curve involved in=20
moving to a non-MS operating system. =20

The fact that I have gotten those inquiries means that the news about=20
how stable Linux is is getting to the "mainstream" population. Only=20
problem is that MS and the home-PC boom has landed the PC and the=20
internet in the hands of too many people who are barely computer=20
literate enough to use a mouse. (I'm speaking from experience. A=20
large number of my private clients fit this description to a T.=20
Although they are good as a continuing source of income :)  And with=20
Windows being as "User Friendly" as it is, and with at least 75% of=20
the major software firms still not supporting Linux, there is no way=20
Linux can make any real inroads into the desktop market.

OTOH several of my clients have inquired about Linux because of it's=20
security - it doesn't take a genius to see that the same reason=20
=46irefox made such a big dent in MS's hold on the browser market could=20
work for Linux as well. And I have had more than one client ask if=20
there was an alternative to Windows than ran well - I've always=20
answered the same way: "Yes, but you would need to learn an all-new=20
way of doing things." Every last one of them dropped it on hearing=20
those words.

> Anyhow - before I piss off too many people who are religiously
> attached to Linux worshiping - I'll quit not. ;)

heh. keep it up. you've managed to turn a pointless argument of micro=20
versus mono into something productive. (even if you didn't mean to)

DRH

--Boundary-01=_aryQDxxIrtxzqoO
Content-Type: application/pgp-keys;
  name="OpenPGP key 0xA6992F96300F159086FF28208F8280BB8B00C32A"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0xA6992F96300F159086FF28208F8280BB8B00C32A.asc

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.7 (GNU/Linux)

mQGiBEJS3C0RBADeLmOaFYR40Pd/n86pPD10DYJIiSuEEJJAovJI/E3kjYgKnom0
CmwPa9oEXf4B3FMVcqB0ksKrhA8ECVsNRwO91+LObFczyc59XBgYDScn9h9t+lu4
IZTObcR1SnQ/I+YdeJpd12ZcuLAnQ3EGl9+7bBOJgr4JcwM6Idixtg92kwCg4vhj
97BpUqPSk6cwD4LMRoqzABcEAJPZdEpYDwrXiy5aQx8ax+CbdfJX+XhxVcOrqzoI
8TS7yZPcE1rszCANpCb6xg7TReWyIOu+FQvfzLg5e7Cl2XtVC66RDgdlTBy/pjnX
fxIOIW5Hl+cVaWLBJ2tdAOIiyGPrKC/uTyY/N+4iQTsQK2l/yxc3fOgEN0g9AY9a
GSkHBACmX6awLcrdnxY0p2J/OmRtT4oOWcbq5TUchM9SzPLLIatGZEs7jUal9OYo
ZzmRPjElgM4koF7TTB+71FTUaqVGd0smJVKfJ1nVp6nefxOI6MH/v8/4j7Bvtb1Y
Ypkrxt+R8WWUI1L19yEDp55rvzqIkkLtmJZP/QJg2e7zxTYYi7Q5RGFuaWVsIFIu
IEhhemVsdG9uIChUaGUgU2hhZG93V29sZikgPGRoYXplbHRvbkBlbnRlci5uZXQ+
iF4EExECAB4FAkJS3C0CGwMGCwkIBwMCAxUCAwMWAgECHgECF4AACgkQj4KAu4sA
wyoRwwCeN+PEM8jpxxpxiG4dGyXNwTZBtNkAoKAtdOgeK66+zPEtJFanUeFe6lRX
uQENBEJS3DoQBACfejnq7GSJ7g8nL669pXDVFFrabOaiIC4sH0FgqbK+Oewm4h77
Ir5QL9SsHWvYSBYxnCODvR7zHv8HefWgJ4duC66b8PCXY/qcmxhRhYtdEssx/ncm
BhNXlPPvsyPT/e7PdZkDv7dJuVtVJrLVVeSniz+3KBIIYb395B+yhzjPLwAEDQP9
HFlaX9Duyg8c+RFhqStVrIluy7ZTg8pGjF2KLPsCmcSVzVLLhplF1M6Fs1CSgwRe
OCDRWPFohcaSxPIwIdlS0h2HOnWziPVpzh4HWylbtC6cZYg7dpgaDlJA00ikUlyj
6/bxwNwBuVoNSegIe0mN+xAIsvXM2TLuY1fFYcmeRxmISQQYEQIACQUCQlLcOgIb
DAAKCRCPgoC7iwDDKsoRAJwKJETliGVgcCSTMd7sq/WMOe9VAgCgxq4MRqWBvPWY
fPs99FjiIC8asFc=
=vwF/
-----END PGP PUBLIC KEY BLOCK-----

--Boundary-01=_aryQDxxIrtxzqoO--

--nextPart45141318.44vOTiU38x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDQyrfj4KAu4sAwyoRAvXaAKCexjWeLkrShm7r5RlWA6EpiI68rACfZ6BP
8fJ28/b7HdyJN60X/Dn4z6I=
=ejOV
-----END PGP SIGNATURE-----

--nextPart45141318.44vOTiU38x--
