Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314264AbSEBE51>; Thu, 2 May 2002 00:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314265AbSEBE50>; Thu, 2 May 2002 00:57:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38161 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314264AbSEBE50>; Thu, 2 May 2002 00:57:26 -0400
Date: Wed, 1 May 2002 21:56:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.12: remove VALID_PAGE
In-Reply-To: <Pine.LNX.4.21.0205020101440.23113-100000@serv>
Message-ID: <Pine.LNX.4.44.0205012153310.2272-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 May 2002, Roman Zippel wrote:
> > [ pte_pfn ]
>
> Do you have an example, where that would be useful?



> I know these are special cases, but this covers everything that's
> currently needed.

.. but the _design_ is bad (limited usability anywhere else). And my
suggested interface is actually likely to generate better code, ie instead
of having two tests (one inside "pte_valid_page()", and one on the return
value), you'd only have one (in "valid_pfn()").

The whole notion of "pte_valid_page()" is horrible: you're doing two
_completely_ different things in the function - validation and "pte->page"
conversion. That's bad programming.

		Linus

