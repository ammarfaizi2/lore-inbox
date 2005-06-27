Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVF0CuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVF0CuB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 22:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVF0CuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 22:50:01 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:24075 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261762AbVF0Ctz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 22:49:55 -0400
Message-ID: <42BF6952.4080004@slaphack.com>
Date: Sun, 26 Jun 2005 21:49:54 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>            <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
In-Reply-To: <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 26 Jun 2005 17:35:48 CDT, David Masover said:
> 
> 
>>>Right. So please explain what crypto/raw/foo and crypto/inflated/foo.gz give you.
>>
>>In that example (shouldn't have used the name "crypto", but oh well), it
>>should be crypto/raw/foo.gz and crypto/inflated/foo -- where foo.gz is
>>the gzip'ed file and foo is the transparently compressed/decompressed
>>file.  Basically, these are equivalent:
>>
>>$ zcat crypto/raw/foo.gz
>>$ cat crypto/inflated/foo
> 
> 
> I'm *quite* aware of what your preconceived notions think it *should* be.

So, by "what would ... give you", you meant what the benefits are?  I
was just clarifying how they work, I *thought* that's what you meant...

> Maybe the two examples I asked for have *real-world* meanings that you should
> be allowing for.  Like, for instance, on a mail server, where the A/V software
> may need to unzip a file 5 or 6 times to find out if there's malicious content.

Why would it want to unzip the *same* file that many times?

If you're talking about nested zipfiles, we can do nested plugins just
as easily.

> Or seeing if it's a ".zip bomb", where a small .zip will decompress to gigabytes.

> Or I'm testing a new compression algorithm, to see if multiple compressions help
> (yes, I know that it *shouldn't* help - but I've seen real-world cases where the
> algorithm could only look at a 4K or 8K window at a time, and if you hit a *very*
> long run of duplicate 4K segments, a second compression would compress all the
> identical or near-identical "this is a 4K chunk" tokens...)

Tune the plugin, or use zip directly.  I'm not proposing necessarily to
embed zip in the kernel and drop it from userland, just to have a kernel
interface so that apps/people don't have to all know about the zip
program and how to use it.

Besides, in the zip example, I made very sure that unless you point a
program specifically at where the zip plugin unpacks stuff, you can
easily get the zipfile.

Of course, that could be turned on its head if it was more low-level
transparent compression, the kind where you just compress everything in
/etc because it's all tiny text files.  In that case, you would want a
setup where you have to work to get the raw data.  But in that case,
it's a different kind of plugin anyway -- a plugin for storing data,
rather than just accessing it.

Stop worrying about automagic stuff, though.  It won't trigger unless
you go looking for it.  It will just be easier to find if you do.

>>I guess I need a new name for this approach.  That's three possible ways
>>of doing this?
> 
> 
> I *said* you need to think this through in detail, didn't I? ;)

I said we already did, which is true.  I don't think I'm making these
up, I just don't remember where they were in Silent Semantic.


(oops, I fired the last one off before I was done...)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr9pUXgHNmZLgCUhAQKQ8w/+OQXWdt1pEF6t/0D+x3mPYWq2lhlUbchZ
BYywcGN6Z/yFZQrZovJABZVnB+CXlUlx8DGqQN+Lj9+8HLko/P75ErTWHfuiscpS
wRJIN5dVeZ4f1RImEa8PjQf3c+n+B/ft9hq28yaR58C9vBQwAWOPVL0/4n4unNAV
49odg/IKJM9sdSF+6sVwgWNfuacRcZ5/jXtkDFXIIyJzKl6r45r3HmTkbgRdxqpU
p1aOIsXa7fciN+UK+eiw5jruzJsKHaJtBdISsMWbPdVBFjsDVZmhsdOMv2RZMPo6
2V78OQ4g7pJHSMZsaWQ/vvD3PuHxZm9qglJcdGnL6jNk8OXkKzxXaGDn/SHjYFTu
c8keR1KYu+U5r5RmTiihavFPpN3zefS5W5o5IyLvEZkApRCngDFitq4t2tRfDbfT
zV1JZWz7/bqtoY0zdaZ3gFwxXxh8FMw/LCnsjKkBQ7etlvnvcW2IPssd9rTIV0+4
9CmA2EaYIiXAwGoFzLbbPoKf0a+6tB38oHanBrRBZuTzu9mKHZvyefQa0j2+1KOp
iiCmrK49/APXfp4IUu284r2dPUqAu33LtomxwFbNLaPDZFWgQ9qPjafJBO3L8Y/9
HlFe46Jo5tL7YAEq/UyKpDYWxVcUiDZ40z2w/WKq+v9JjmUZMm+jonXHa9Nq0cQn
YlE9bxtEac8=
=5eSh
-----END PGP SIGNATURE-----
