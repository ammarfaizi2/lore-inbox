Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289324AbSBJHNo>; Sun, 10 Feb 2002 02:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289326AbSBJHNe>; Sun, 10 Feb 2002 02:13:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26886 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289324AbSBJHNV>; Sun, 10 Feb 2002 02:13:21 -0500
Message-ID: <3C661D89.8070202@zytor.com>
Date: Sat, 09 Feb 2002 23:13:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202092322310.11734-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> __BASE_FILE__ is not useful.
> 
> Remember: when we have a BUG in a header file, we need to get the HEADER
> file, not the base file.
> 
> __BASE_FILE__ only works for .c files.
> 
> And .c files aren't the problem anyway (ie if we didn't have BUG()
> statements in header files, we wouldn't have problems anyway).
> 


What we'd really like is something like:

/* foo.h */
#ifndef _FOO_H
#define _FOO_H
#define _FILE_REF __fileref_foo_h

[...]

#undef _FILE_REF
#endif /* _FOO_H */

... and have an automatically generated library (.a file) with all these 
strings that could be pulled in as necessary -- but only one instance of 
each.  However, doing this without compiler support seems ugly in the 
extreme.

Of course, if the linker would fold strings for us then it would be a 
helluva lot easier...

	-hpa


