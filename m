Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUAULrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 06:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUAULrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 06:47:07 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:48217 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S262888AbUAULrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 06:47:01 -0500
Message-ID: <400E66AA.1020403@samwel.tk>
Date: Wed, 21 Jan 2004 12:46:50 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: Timothy Miller <miller@techsource.com>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating
 money to OSDL
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu> <4008509B.2060707@techsource.com> <200401171415.31645.bart@samwel.tk> <20040120192114.GA30755@citd.de>
In-Reply-To: <20040120192114.GA30755@citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> On Sat, Jan 17, 2004 at 02:15:31PM +0100, Bart Samwel wrote:
[...]
>>Let's take a look at the chances. 30 terabytes is, in a best-case scenario 
>>(with 512-byte blocks) about 6e10 blocks. That would be roughly 
>>6e10*6e10*(2**(-128)), or about 1e-17. With a hundred million machines, the 
>>chances of a collision would be about 1e-9, disregarding the fact that all 
>>these machines have a large chance of containing similar blocks -- their data 
>>isn't truly random, so some blocks have a larger chance of occurring than 
>>others. The data sets on the machines are probably reasonably static, so if 
>>the collision isn't found *at once* the chances of it occurring later are 
>>much smaller. So, even under the most positive assumptions, with a hundred 
>>million machines with 30 terabytes of storage each, it's extremely probable 
>>that you won't find a collision. (A 96-bit hash could have been broken with 
>>this setup however. :) )
> 
> There is one fundemental braino in the discussion.
> 
> Only HALF the bits are for preventing "accidental" collisions. (The
> "birthday" thing). The rest is for preventing to "brute force" an input
> that produces the same MD5.(*)

 From RFC-1321:

"It is conjectured that the difficulty of coming up with two messages
having the same message digest is on the order of 2^64 operations,
and that the difficulty of coming up with any message having a given
message digest is on the order of 2^128 operations."

So, they say it's on the order of 2^64 operations, whatever their 
definition of "operation" is. It probably means that they think you need 
to take the MD5 of something in the order of 2^64 random messages in 
order to have a reasonable chance of finding a duplicate. The RFC says 
nothing about half of the bits being for one purpose and the other for 
another; in the algorithm all bits seem to be processed in a similar way.

Let's see where they got their 2^64. If you've got 2^64 messages, you've 
got (with the same logic as above) approximately 2^64 * 2^64 * (1 / 
2^128) = 100% chance of a birthday collision. This seems to support the 
idea that the kind of analysis that I just did corresponds to the way 
they look at it.

 > *: AFAIR i read this in the specs of SHA1 (160 bits). So i guess this
 > is also true for MD5.

It might be that you took the "2^64 operations" as meaning "64 bits" (or 
2^80 as 80 bits, in the SHA1 case), while it now seems to be the result 
of a birthday-collision calculation. Not a surprising misinterpretation 
BTW, because the RFC doesn't specify at all where they got this number.

> Btw. I already had (a/the) MD5 collision(*2) in my life.

> *2: I had a direcory of about 1,5 Million images and "md5sum"med them to
> eliminate doubles. The Log-file, at one point, had the same md5sum as
> one of the pictures.

Wow! It might be that MD5 is not such a good hash function after all 
then. The security is of course purely based on the hashes of messages 
being very randomly distributed. If they really were, the chances of 
this happening to you would have been extremely slim (less than 1e-20). 
I think the more probable explanation is that MD5 hashes aren't truly 
randomly distributed after all. :)

-- Bart
