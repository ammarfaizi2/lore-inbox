Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289273AbSBJEV0>; Sat, 9 Feb 2002 23:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSBJEVR>; Sat, 9 Feb 2002 23:21:17 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:24027 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S289270AbSBJEVF>; Sat, 9 Feb 2002 23:21:05 -0500
Message-ID: <3C65F54A.D81ED990@didntduck.org>
Date: Sat, 09 Feb 2002 23:21:30 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202091335340.1196-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 9 Feb 2002, Andrew Morton wrote:
> > >
> >
> > Is better, except the filename gets expanded multipe times into
> > the object file.  How about:
> >
> > #define BUG()                   \
> >         asm(    "ud2\n"         \
> >                 "\t.word %0\n"  \
> >                 "\t.long %1\n"  \
> >                  : : "i" (__LINE__), "i" (__FILE__))
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
>                         Linus

Note that if you're going to do this you may want to use another vector
(ie. int $0x82) instead of the undefined opcode.  That way you know for
certain that there will be valid debugging info following.

-- 

						Brian Gerst
