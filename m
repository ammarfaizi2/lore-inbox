Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262864AbSJAVWF>; Tue, 1 Oct 2002 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbSJAVWF>; Tue, 1 Oct 2002 17:22:05 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:7583 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262864AbSJAVWE>;
	Tue, 1 Oct 2002 17:22:04 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Paul P Komkoff Jr <i@stingr.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Date: Tue, 1 Oct 2002 23:27:50 +0200
X-Mailer: KMail [version 1.3.2]
References: <20021001195914.GC6318@stingr.net>
In-Reply-To: <20021001195914.GC6318@stingr.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EMNBZ2GJXA2W13LL5Q2U"
Message-Id: <E17wUYa-0006Dl-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_EMNBZ2GJXA2W13LL5Q2U
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8bit

On Tuesday 01 October 2002 21:59, Paul P Komkoff Jr wrote:
> This is the stupidiest testcase I've done but it worth seeing (maybe)
> 
> We create 300000 files

How big are the files?

> named from 00000000 to 000493E0 in one directory, then delete it in order.

You probably want to try creating the files in random order as well.  A
program to do that is attached, use in the form:

    randfiles <basename> <count> y

where 'y' means 'print the names', for debugging purposes.

What did your delete command look like, "rm -rf" or "echo * | xargs rm"?

> Tests taken on ext3+htree and reiserfs. ext3 w/o htree hadn't
> evaluated because it will take long long time ...
> 
> both filesystems was mounted with noatime,nodiratime and ext3 was
> data=writeback to be somewhat fair ...
> 
> 	       	real 	      	user  		sys
> reiserfs:
> Creating: 	3m13.208s	0m4.412s	2m54.404s
> Deleting:	4m41.250s	0m4.206s	4m17.926s
> 
> Ext3:
> Creating:	4m9.331s	0m3.927s	2m21.757s
> Deleting:	9m14.838s	0m3.446s	1m39.508s
> 
> htree improved this a much but it still beaten by reiserfs. seems odd
> to me - deleting taking twice time then creating ...

Only 300,000 files, you haven't got enough to cause inode table thrashing,
though some kernels shrink the inode cache too agressively and that can
cause thrashing at lower numbers.  Maybe a bottleneck in the journal?

Not that anybody is going to complain about any of the above - it's still
running less than 1 ms/create, 2 ms/delete.  Still, it's slower than I'm
used to.

-- 
Daniel

--------------Boundary-00=_EMNBZ2GJXA2W13LL5Q2U
Content-Type: text/x-c;
  charset="koi8-r";
  name="randfiles.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="randfiles.c"

I2luY2x1ZGUgPHN0ZGxpYi5oPgoKI2RlZmluZSBzd2FwKHgsIHkpIGRvIHsgdHlwZW9mKHgpIHog
PSB4OyB4ID0geTsgeSA9IHo7IH0gd2hpbGUgKDApCgppbnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkKewoJaW50IG4gPSAoYXJnYyA+IDIpPyBzdHJ0b2woYXJndlsyXSwgMCwgMTApOiAw
OwoJaW50IGksIHNpemUgPSA1MCwgc2hvdyA9IGFyZ2MgPiAzICYmICFzdHJuY21wKGFyZ3ZbM10s
ICJ5IiwgMSk7CgljaGFyIG5hbWVbc2l6ZV07CglpbnQgY2hvb3NlW25dOwoKCWZvciAoaSA9IDA7
IGkgPCBuOyBpKyspIGNob29zZVtpXSA9IGk7Cglmb3IgKGkgPSBuOyBpOyBpLS0pIHN3YXAoY2hv
b3NlW2ktMV0sIGNob29zZVtyYW5kKCkgJSBpXSk7Cglmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKQoJ
ewoJCXNucHJpbnRmKG5hbWUsIHNpemUsICIlcyVpIiwgYXJndlsxXSwgY2hvb3NlW2ldKTsKCQlp
ZiAoc2hvdykgcHJpbnRmKCJjcmVhdGUgJXNcbiIsIG5hbWUpOwoJCWNsb3NlKG9wZW4obmFtZSwg
MDEwMCkpOwoJfQoJcmV0dXJuIDA7Cn0KCgo=

--------------Boundary-00=_EMNBZ2GJXA2W13LL5Q2U--
