Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316144AbSEJWKf>; Fri, 10 May 2002 18:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316145AbSEJWKe>; Fri, 10 May 2002 18:10:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316144AbSEJWKe>; Fri, 10 May 2002 18:10:34 -0400
Date: Fri, 10 May 2002 15:10:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() disassembly tweak
In-Reply-To: <Pine.LNX.4.21.0205102216160.3747-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0205101457120.22516-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 May 2002, Hugh Dickins wrote:
>
> Could we change the i386 BUG() macro slightly again?

If it wants to be changed, I'd actually personally prefer it to be changed
to take an explicit string instead of using the filename/linenr at all.

The filename/linenr one has the size problem (those absolute file names
are _long_), and sucks when you have slight kernel version skew and 
suddenly the information isn't obviously unambiguous at all.

It also sucks for inline functions or other users of BUG that would
potentially want to have different output.

In short, I suspect it would be nicer with 

	kernel BUG: release_task(current)

instead of

	kernel BUG at /home/torvalds/v2.5/linux/exit.c:59

(the exact point where the BUG happens _is_ given by the EIP, so in that
sense file and linenr are not actually all that useful. A descriptive
string would be more readable, and equally useful at pinpointing at a
source level).

		Linus

