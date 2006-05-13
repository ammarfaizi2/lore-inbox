Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWEML2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWEML2q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWEML2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:28:46 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:11695 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932386AbWEML2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:28:45 -0400
Message-ID: <4465C2E8.8070106@stesmi.com>
Date: Sat, 13 May 2006 13:28:40 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Douglas McNaught <doug@mcnaught.org>
CC: Arjan van de Ven <arjan@infradead.org>,
       Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
References: <20060513103841.B6683146AF@hunin.borkware.net>	<1147517786.3217.0.camel@laptopd505.fenrus.org>	<20060513110324.10A38146AF@hunin.borkware.net>	<1147518432.3217.2.camel@laptopd505.fenrus.org> <87r72yi346.fsf@suzuka.mcnaught.org>
In-Reply-To: <87r72yi346.fsf@suzuka.mcnaught.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig6B6849CC0FB4861C34D7EE49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B6849CC0FB4861C34D7EE49
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Douglas McNaught wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> 
>>On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> 
> 
>>>bash-3.00$ cat << EOF > test
>>>
>>>>#!/bin/sh
>>>>echo "yay, I'm executing!"
>>>>EOF
>>>
>>>bash-3.00$ chmod 111 test
>>>bash-3.00$ ./test
>>>/bin/sh: ./test: Permission denied
>>
>>is your script readable as well? 111 is just weird/odd.
> 
> 
> It needs to be readable as well.  What ends up happening is that the
> kernel sees the execute bit, looks at the shebang line and then does:
> 
> /bin/sh test
> 
> Since read permission is off, the shell's open() call fails.  It will
> work fine if you use 755 as the permissions.
> 
> Every Unix I've ever seen works this way.  It'd be nice to have
> unreadable executable scripts, but no one's ever done it.

The solution would be to either stick bash in the kernel (YUCK!)
or to have the kernel basically copy the read-only script to /tmp
or somewhere else, set permissions to sane values and
/bin/sh /tmp/foo.a12345.

Now why on earth would one want the kernel to jump all those hoops
instead of just requiring read access on anything with a shebang?

Naturally, bash has to be supplemented by any other gorramn shell
out there and naturally perl and anything at all that can be invoked
using a shebang, since bash doesn't know how to execute perl
and perl doesn't know how to execute shell and .. and .. and...

So either copy it and set sane values or require read-access
on the file.

// Stefan

--------------enig6B6849CC0FB4861C34D7EE49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZcLrBrn2kJu9P78RAwYfAJ9AI7FX0fVqNjVQVMTtT6NtMqfoewCcD04q
HIUr8O2Ur0d58f7Kdy3tfa0=
=4XTV
-----END PGP SIGNATURE-----

--------------enig6B6849CC0FB4861C34D7EE49--
