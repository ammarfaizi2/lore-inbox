Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSEaRbE>; Fri, 31 May 2002 13:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSEaRbD>; Fri, 31 May 2002 13:31:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4622 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316397AbSEaRbD>; Fri, 31 May 2002 13:31:03 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: do_mmap
Date: Fri, 31 May 2002 17:30:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ad8bvv$3tr$1@penguin.transmeta.com>
In-Reply-To: <Pine.GSO.4.05.10205311456070.10633-100000@mausmaki.cosy.sbg.ac.at> <1022855243.12888.410.camel@irongate.swansea.linux.org.uk>
X-Trace: palladium.transmeta.com 1022866254 32712 127.0.0.1 (31 May 2002 17:30:54 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 31 May 2002 17:30:54 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1022855243.12888.410.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>On Fri, 2002-05-31 at 14:00, Thomas 'Dent' Mirlacher wrote:
>> and the checks in various places are really strange. - well some
>> places check for:
>> 	o != NULL
>> 	o > -1024UL
>
>"Not an error". Its relying as some other bits of code do actually that
>the top mappable user address is never in the top 1K of the address
>space
>
>> is it possible to have 0 as a valid address? - if not, this should
>> be the return on errors.
>
>SuS explicitly says that 0 is not a valid mmap return address.

But if so, SuS is _very_ _very_ wrong.

The fact is, if you use something like vm86 mode, you absolutely _need_
to be able to explicitly mmap at address 0. 

So it is correct (and in fact there is no other sane way to do it) to
say

	addr = mmap(NULL, 1024*1024,
		PROT_READ | PROT_WRITE ,
		MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED,
		-1, 0);

and if SuS says that mmap must not return NULL for this case, then SuS
is so full of sh*t that it's not worth worrying about.

In short, under Linux 0 _is_, and will always be (at least on x86) a
perfectly valid return address from mmap() and friends. It's only going
to be returned when you explicitly ask for it with MAP_FIXED, but it
absolutely is a valid return.

		Linus
		Linus
