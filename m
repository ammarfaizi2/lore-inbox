Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVA1R4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVA1R4C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVA1RyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:54:23 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38602 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261491AbVA1RvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:51:03 -0500
Message-ID: <41FA7BA3.7010100@comcast.net>
Date: Fri, 28 Jan 2005 12:51:31 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	 <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>	 <1106848051.5624.110.camel@laptopd505.fenrus.org>	 <41F92D2B.4090302@comcast.net>	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>	 <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com> <1106856178.5624.128.camel@laptopd505.fenrus.org> <41F94B5A.2030301@comcast.net> <41FA74CA.2030303@grupopie.com>
In-Reply-To: <41FA74CA.2030303@grupopie.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Paulo Marques wrote:
> John Richard Moser wrote:
> 
>> In other words, no :)
>>
>> Here's self-exploiting code to discover its own return address offset
>> and exploit itself.  It'll lend some insight into how this stuff works.
> 
> 
> I really shouldn't feed the trolls, but this must be the most silly
> piece of code I saw on this mailing list in a very long time (and there
> have been some good examples over time).
> 
> The stack randomization doesn't prevent some sort of attacks (like
> return into libc, etc.) and given a small randomization it might be
> possible to write an exploit with a long sequence of NOP's and a return
> address somewhere in there (the attacker wouldn't know exactly where,
> but it wouldn't matter anyway). If we are able to write 'N' NOP's then
> we get a 'N'/64k chance that the exploit works.

And the stack is a few megs, so you can write 64k of NOPs.  ;)

> 
> Your code doesn't show any of this kinds of attacks. It just shows that
> if you're able to run code then.... you're able to run code?
> 

The guy wanted to know how buffer overflows worked, so I showed him a
self-exploiting buffer overflow.  He didn't come in saying "I've got 500
years of experience writing buffer overflows, how would this stop it?"

It at least shows a buffer of length X overflowing into the return
pointer and changing it to address A of another function.  That's all I
wanted to do.

Interestingly enough, I used this code in real life for a test for the
IBM Stack Smash Protector.  It made a neat regression test.  The code
overflows into the return pointer and sets it to payload() 100% of the
time, even in the presence of NX protection and full ASLR (PaX' 256M or
(amd64) 64GiB, this 64k, or the HT 8k).  It DOES trigger SSP, which
halts the payload.

> What are you going to show next? That you can steal your own car? Are
> you going to blame the car manufacturer's for that?
> 

No, though it'd be interesting to show my car stealing itself :)

> As it was already pointed out this is a step into implementing a larger
> randomization, so that things don't break all at once. Even a large
> stack randomization is just another layer of protection, as there are
> still attacks that it doesn't prevent.... Duh.
> 
>> [...]         /*find the distance between a and myret*/
>>         for (i = (void*)a; *(void**)i != myret; i++) {
>>             distance++;
>>         }
> 
> 
> And this must be "la piece de resistance". Some very obfuscated (and
> inefficient) way to do a simple unsigned subtraction...
> 

Yeah, but I hate warnings.  It works without all the fancy casting, but
the compiler is like "OMFG WARNING WARNING DANGER WILL ROBINSON
ARITHMETIC ON POINTERS DR SMITH WANTS TO MOLEST YOU WARNING WARNING"

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+nujhDd4aOud5P8RAtc+AJ9t2EaQWQujOe3fyf/vg4jzUK9/TQCeMzBJ
Cjn/NUFS9+oxPJnU3u4XAsE=
=Vc2s
-----END PGP SIGNATURE-----
