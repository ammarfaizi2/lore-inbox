Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbULRAWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbULRAWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbULRAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:22:33 -0500
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:13242 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S262252AbULRAUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:20:35 -0500
Message-ID: <41C377CF.2040506@slaphack.com>
Date: Fri, 17 Dec 2004 18:20:31 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040924)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com>	 <1103059622.2999.17.camel@grape.st-and.ac.uk>	 <41BFC1C5.1070302@slaphack.com>	 <1103102854.30601.12.camel@pear.st-and.ac.uk>	 <41C0CF3B.1030705@slaphack.com>  <41C1D870.2020407@namesys.com> <1103223664.2336.335.camel@pear.st-and.ac.uk> <41C320EB.1050400@namesys.com>
In-Reply-To: <41C320EB.1050400@namesys.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
| Peter Foldiak wrote:
|
|> On Thu, 2004-12-16 at 18:48, Hans Reiser wrote:
|>
|>
|>> David Masover wrote:
|>>
|>>
|>>> Speaking of which, how much speed is lost by starting up a process?
|>>>
|>>> The idea of caching is that running
|>>>
|>>> cat *; cat *; cat *; cat *; cat *
|>>>
|>>> is probably slower than
|>>>
|>>> cat * > baz; cat baz; cat baz; cat baz; cat baz; cat baz
|>>>
|>>
|>> Only for small files where the per file overhead of a read is
|>> significant.
|>>
|>
|>
|> But if the glued "file" is a stream (or pipe?) you can't do everything
|> with it (e.g. seek() ) that you could do with a proper file, right?
|>
|>
| It does not need to be a pipe-like file.  Seek can be implemented for a
| composite (glued) file.

Composite plugins are likely fairly simple (cat *) so they shouldn't be
required to implement seek on their own.  In OO terms, they should
"inherit" a more global facility, which would be based on cached pipes.

But definitely for files that are likely to be large, but still seekable
(zipfiles), you want the plugin to provide its own seek support.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQcN3zXgHNmZLgCUhAQKF1w/7B51wfpaIVi6ap+TVsZ+t3FLPTqyOF24W
lnqSUnM50zlJixQMKLzmZSOUGC/EsDZIVqShAUhniKAp8cvYNCE0HjqZl1b8S0HV
MggehXJJwSfl3/RHCbRXo1URXzSodGLyCsdEhi88viyhilj7+9uJRhxmOx1cO7uS
p/yS3LgpxEEjhDiu09MXnAHuXGTdKB9hQl63HxPwa72uM3Q5M7zCl0p+X+rH9xIj
HgdZMbmoCiA6QmRJzLBq/s0xRo385bfeTHMCwB3aIyYNFeTvJDoZP6IEbi9Ee0DH
Ns9rwJo+B2FPbHKHlmFxZkLVwmnQqr9WemYYybUGNOVdIamn87Ah6/ObvAmM+dQw
dnRF2YVPM9gNv0LSOS3nteNr6ldYzEZWGi24ScPpFrJpZAMBVNarX0zE4+S2Dc75
a733Z2pkOhHUvRPoDVXvUTKC5863cuWH7lgvTfT5eAANG/AANphi2vyFfgT5KWKt
gF+SnRkLiDSfjcqgts036vfpIziz/aM9dZxzgE+j8IjuGNchl/6q1OVt7+WOJOrq
grfOgVB26pFgYFD7ZjJSiZKHGRDJZXrUo4VnUoG43Dy4JZVlG4qpivMO50Ep0GD2
cVFw1/MKP0beAA1S1R5Fh0mLo0jNHlsxSD6XoKjUuL/xjnLpyN/AdmIhQq0mMujY
vYBBaDHYkYc=
=RMFf
-----END PGP SIGNATURE-----
