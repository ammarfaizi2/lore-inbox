Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSBIUMq>; Sat, 9 Feb 2002 15:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSBIUMi>; Sat, 9 Feb 2002 15:12:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286893AbSBIUMW>;
	Sat, 9 Feb 2002 15:12:22 -0500
Message-ID: <3C658272.8C517D55@zip.com.au>
Date: Sat, 09 Feb 2002 12:11:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C6579DB.E93DAD92@zip.com.au> <Pine.LNX.4.33.0202091335340.1196-100000@home.transmeta.com>
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

gcc generally get it wrong - unreferenced strings still appear
in the object code from multiple usage patterns.  I think this
was fixed about six months ago.

But yes, the verbose BUG overhead is now six bytes per BUG, plus
a few bytes per file for the filename.  And it's my opinion that
the non-verbose BUG option is undesirable - it's making the
developers' job harder.  Seems that with this change, the reasons
for CONFIG_DEBUG_BUGVERBOSE are no longer with us, and it can
disappear.

-
