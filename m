Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSBIUBN>; Sat, 9 Feb 2002 15:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSBIUBD>; Sat, 9 Feb 2002 15:01:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24585 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285424AbSBIUA4>; Sat, 9 Feb 2002 15:00:56 -0500
Message-ID: <3C657FDF.5070605@zytor.com>
Date: Sat, 09 Feb 2002 12:00:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011229
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202091335340.1196-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> On Sat, 9 Feb 2002, Andrew Morton wrote:
> 
>>Is better, except the filename gets expanded multipe times into
>>the object file.  How about:
>>
>>#define BUG()                   \
>>        asm(    "ud2\n"         \
>>                "\t.word %0\n"  \
>>                "\t.long %1\n"  \
>>                 : : "i" (__LINE__), "i" (__FILE__))
>>
> 
> Even better.
> 
> That way you can actually totally remove the "verbose bug" config option,
> because even the verbose BUG's aren't actually using up any noticeable
> amounts of space.
> 
> This is all assuming that gcc doesn't create the string for inline
> functions that aren't used, which it probably cannot, so maybe this
> doesn't work out.
> 


Since gcc wouldn't even *see* a macro it didn't use, I find it hard to 
imagine it would create anything.

However, you really want to do "asm volatile" rather than "asm"...

	-hpa


