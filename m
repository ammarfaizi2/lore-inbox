Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264760AbUD2Utl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbUD2Utl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbUD2Ur7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:47:59 -0400
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:48908 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S264786AbUD2UqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:46:13 -0400
In-Reply-To: <4090CB31.6090300@softhome.net>
References: <1PX8S-5z2-23@gated-at.bofh.it> <4090CB31.6090300@softhome.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--262319677"
Message-Id: <44228702-9A1E-11D8-B804-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: Mikael Pettersson <mikpe@user.it.uu.se>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
From: Paul Wagland <paul@wagland.net>
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
Date: Thu, 29 Apr 2004 22:46:19 +0200
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-4--262319677
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 29, 2004, at 11:30, Ihar 'Philips' Filipau wrote:

> Mikael Pettersson wrote:
>> This patch fixes three warnings from gcc-3.4.0 in 2.6.6-rc3:
>> - drivers/char/ftape/: use of cast-as-lvalue
>>  		if (get_unaligned((__u32*)ptr)) {
>> -			++(__u32*)ptr;
>> +			ptr += sizeof(__u32);
>>  		} else {
>
>   Can anyone explain what is the problem with this?
>   To me it seems pretty ligitimate code - why it was outlawed in gcc 
> 3.4?

http://es-sun2.fernuni-hagen.de/cgi-bin/info2html?(gcc)Subscripting

The ability to manipulate a cast was always a gcc extension, whether by 
design or feature I am not sure. The problem is that it breaks C++ 
templates in a bad way. Here is where the extension is documented for 
GCC 3.3.3

http://gcc.gnu.org/onlinedocs/gcc-3.3.3/gcc/Lvalues.html

This extension is now obsoleted.

>   Previous code was agnostic to type of ptr, but you code presume ptr 
> being char pointer (to effectively increment by 4 bytes).

Yes, and the previous code assumed that that ptr was not a pointer to a 
64 bit value, since dereferencing it on most platforms would then 
explode. I bet that both assumptions are just as safe ;-)  However if 
you really wanted to be safe then you could do

ptr += sizeof (__32) / sizeof (*ptr);

Again, assuming that we are not using a greater then 4 byte ptr*, since 
otherwise it would not increment... But personally I think that this is 
not required.

Cheers,
Paul

--Apple-Mail-4--262319677
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAkWmbtch0EvEFvxURAsu9AJ9iFDt/Kd5CC++SAXYoWfdRR64gKgCeJiGs
oKUUAQc1+wjPN/LBeR6W2a8=
=Ei5s
-----END PGP SIGNATURE-----

--Apple-Mail-4--262319677--

