Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSEMBIX>; Sun, 12 May 2002 21:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSEMBIW>; Sun, 12 May 2002 21:08:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48400 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315461AbSEMBIU>; Sun, 12 May 2002 21:08:20 -0400
Date: Sun, 12 May 2002 18:08:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: wrose@loislaw.com, <linux-kernel@vger.kernel.org>
Subject: Re: Segfault hidden in list.h
In-Reply-To: <20020512.175021.50367158.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0205121805220.15392-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 May 2002, David S. Miller wrote:
>
>    If the coder doesn't lock his data structures, it doesn't matter _what_
>    order we execute the list modifications in - different architectures will
>    do different thing with inter-CPU memory ordering, and trying to order
>    memory accesses on a source level is futile.
>
> However, if the list manipulation had some memory barriers
> added to it...

That would just make _those_ much slower, with some very doubtful end
results.

Show me numbers, and show me readable source, and show me a proof that the
memory ordering actually works, and I may consider lockless algorithms
worthwhile. As it is, they are damn fragile and require more care that I
personally care to expect out of 99.9% of all programmers.

And I'm sure as hell not going to put any lockless stuff in functions
meant for "normal human consumption". If we create list macros like that,
they had better be called "lockless_list_add_be_damn_careful_about_it()"
rather than "list_add()".

		Linus

