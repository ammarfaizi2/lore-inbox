Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269557AbUICBjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbUICBjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269554AbUICBiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:38:16 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:28855 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269527AbUICBeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:34:25 -0400
Message-ID: <4137CA17.6060605@slaphack.com>
Date: Thu, 02 Sep 2004 20:34:15 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Spam <spam@tnonline.net>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <14260000.1094149320@flay> <4137BDA7.4040304@slaphack.com> <793789713.20040903024629@tnonline.net>
In-Reply-To: <793789713.20040903024629@tnonline.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Spam wrote:
[...]
|>   I thought reiser4 had its journaling and atomic commits. Am I
|>   mistaken? I run reiser4 as primary fs on my test systems and it seem
|>   to work as expected.

consider this:

save_file () {
	write()	/* what if the write flushes halfway through
		 * then crashes?
		 */

	blah()	/* what if "blah" crashes? */
	write()
}

Some apps need consistency across multiple files, but we don't even have
it on a single file.  You need a new interface to do that.  As you can
see, reiser4 has absolutely no way of knowing, anywhere in the above
code, when you're done writing -- and when the file is consistent.

AFAIK, all that has to be done now for this to work is for them to
finish the userland interface to the journalling and atomic commits that
already exist for kernel space.  But so far, all that is truly atomic is
metadata operations -- chmod, mv, mkdir, touch, and rm/rmdir are all
atomic, so long as you only use them on a single file/dir.  But this has
been true in reiserfs3, xfs, ext3, and others.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTfKF3gHNmZLgCUhAQKp3Q//WcijAx8VVdKjJFHENZvrA2P3/wjdCLIn
OeIGi9VxbcQhS1cBM+BU6nBN6wz8S59o9hEM/F8L5oDxto8YW6sfyceoanbtVkLo
r7k4i39A4Ao1UQFzYEzxWzgCA607WvGBboNN1J/5pYe+bWATWBw+oQgc6XikQofQ
QwFX+0KxEDUva5Xkei/wBNhvpSveFBjAm/t79nVkANOVLji2KYALtewps+7QDiGc
PNwfjSUcAbNgXrvuhwpocFgAGEhgS/Y7ANR4DqFAiUseDwY6WgkZqhTaxC8t9ZzF
/Hd82sEb/J+hGpMfrTIe+D5VYhnjX+bPPs/U0OcfoH4CfkgOFgGOeuzlWg3xeTyX
vgtgYGwuGQuWux7WNte0GOCNxfaFDE8lLGexdQYLkdVCSsLmzACA17H1bQdeswgH
UnWL3oBoBx5BcdpkW1y1ZeoJv4xInazkzeU3GtEOd50tlJmOXmdjRNfj5LTrTh+1
CUpEKVvSjQ8MY70uQW6XKEUAkCYyBmSVeMay5SSQS/1Q0ISLEG3gMqPdsL2BOBO/
LkkQKjLe3LQS913wUtibL1CCfJCS/BrDswNCMsboivcg1SnwY+xJb9ffFMW0blBL
kQ0B1AGZCjWHDfxXKIlC31PJYKzgE5vaKZ6+INj8mG8t5PzqgikBDQStvsXqczJq
VgvvOVCjvho=
=I+Xw
-----END PGP SIGNATURE-----
