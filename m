Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVGLWYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVGLWYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVGLWYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:24:13 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:28426 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262480AbVGLWXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:23:35 -0400
Message-ID: <42D450BE.70404@slaphack.com>
Date: Tue, 12 Jul 2005 18:22:38 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Stefan Smietanowski <stesmi@stesmi.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <200507120233.j6C2XODw030361@laptop11.inf.utfsm.cl> <42D35AE4.9000400@namesys.com>
In-Reply-To: <42D35AE4.9000400@namesys.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Horst von Brand wrote:
> 
> 
>>Hans Reiser <reiser@namesys.com> wrote:
>> 
>>
>>
>>>Stefan Smietanowski wrote:
>>>   
>>>
>>>
>>>>I think "..." and ".meta" both serve as a logical delimiter. However
>>>>some programs implement their own "..." which would make it clash with
>>>>them. Naturally if some program created a directory called .meta we're
>>>>equally screwed.
>>>>     
>>>>
>>
>> 
>>
>>
>>>I chose '....' (four dots) because it clashes with less, not three dots.
>>>   
>>>
>>
>>Is this some kind of "My dots are more than yours" contest?!
>>
>>/None/ of them is safe. ".meta", "...", "....", ".this.has.five.dots." are
>>all perfectly legal file (or directory) names, POSIXly. If any one of them
>>won't do, none will.

And, conversely, if any one of them makes sense, they all do.  Well,
with the exception that some of them have never, ever been used before,
and that's what we should be aiming for.  No conflicts with existing
programs, then new programs can be written to avoid conflicting with us.

> There is a long history of encroaching namespaces by creating new
> keywords in CS, and it is a survivable problem.

Agreed, but not one to be taken too lightly.

> Clearcase (the version control filesystem) is an excellent example. 
> They have special meanings for @ and some other common characters, and
> you have to learn how to escape those characters if you use them in
> Clearcase.

I like using @, though.  Without having to escape it.

That's why we're trying to find something that people won't actually
touch, especially since if we design it right, this will be the last
delimiter introduced at the fs/vfs level.

> It works, it makes users happy, in practice it is far less of a problem
> than one might think.  I think there were two or three times I had to
> remember how to escape things in 2 years of using it.....
> 
> Better to spend one's mind looking for bugs instead of this issue.....

.....if bugs were seen as such a big deal.

I think it's far easier to get into the kernel with something
ludicrously buggy than something which actually changes fundamental
behavior.  That is, you can put in an FS which actually corrupts data
(such as the old NTFS write support), so long as it doesn't break POSIX,
or cause other weird restrictions like "No files named 'metas'"

Now, if we can decide that we don't care about being in the vanilla
kernel, then we can just call it ".metas" or "lost+found" or whatever
and get to work on bug fixes and other much-needed features such as a
repacker.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQtRQvXgHNmZLgCUhAQJXWBAAlZggJQGNi2lEZh0MAqnz+rNVT1JYcY/b
adHgvVOZZNiJw2GmVjGLIiG5cqSqML1//f0+4XOxjYED2rbfOwBJiDqcq/0IsKPp
5JJflJV2uWkEZukJ+oA5mspfSeKof2N5egBoD1Ije079VBKXdjoN5Kprkbe4ZYZ2
+Yu+w3FpdcaGvSqVlTRHPWsS0je4z8ieh0u6ql+HNR4ze/hKwMw4nrb2sARW9NOQ
EZ8Ot5NDhVaxz9Rj72rLVuQrUZEF8b0ihkpmzTauVV/nysEGi33SPqYTF7nYGBnM
5mVY63uXG4zxmThMDpn+J/iofA/hS1fd1bY9tCgF1ZAPu9HrCTnVzKaTYoOq+ciD
sY0m7HEc49JfaiyZ/SJGH02WUH3JqLQAVGQftEkqAQLyYdVRbzdBHUVUR2i8hX2M
ofFLM6DGJgFK784PfO0sjNboQT5ay4B8js8NltdfytsOVwDzjMST7dZAWcnMgTZU
jrMCJuMYeYh8468fy1C9pCMUPahVXvmF4O5Xazt7m9HvV4lxRJIUDZsaR0Volg2K
OAQIO3rtT9heK/+/PaUuXX8RYwLQUlhdUmdHfdtjRiLtKRcbw/fYBOqjkgXZfOfy
RzyBgD463sVCVAE8qMbAVnnHNGKZ25tyRTYITiTZ2kfnIeURJawj2SZVmn5ezGQG
xRnI3+Ir5e0=
=moA6
-----END PGP SIGNATURE-----
