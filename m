Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313731AbSETAqs>; Sun, 19 May 2002 20:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315238AbSETAqr>; Sun, 19 May 2002 20:46:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12036 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313731AbSETAqq>; Sun, 19 May 2002 20:46:46 -0400
Date: Sun, 19 May 2002 17:47:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.44.0205191736420.10180-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205191742130.10180-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 May 2002, Linus Torvalds wrote:
>
> No, that's just a missed thing (for a while I thought I could use "nr" for
> "freed", so I changed the code and forgot to add back the free'd).

That reminds me - we should increment the rss for page directories now on
the allocation path, because we will decrement rss for them when we free
them (and because it's the right thing to do anyway, I guess - better
resource tracking).

The other alternative is to make separate versions of "tlb_remove_page()":
one that decrements RSS, one that doesn't (and the latter would be used
for page directories).

Finally, I haven't really heard anything back from the "strange" VM
architectures (ie sparc v8 and PPC) other than Davem's buy-in that the
basic approach should work ok for them.

		Linus

