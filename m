Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318967AbSICXHV>; Tue, 3 Sep 2002 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318972AbSICXHV>; Tue, 3 Sep 2002 19:07:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55820 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318967AbSICXHU>; Tue, 3 Sep 2002 19:07:20 -0400
Date: Tue, 3 Sep 2002 16:14:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "David S. Miller" <davem@redhat.com>, <phillips@arcor.de>,
       <wli@holomorphy.com>, <rml@tech9.net>, <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
In-Reply-To: <20020903231330.C6848@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.33.0209031610200.10759-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Jamie Lokier wrote:
> 
>      1. struct list
>      2. struct list_node
> 
> With these two types, `list_add' et al. can actually _check_ that you
> got the arguments the right way around.

Well, the thing is, one of the _advantages_ of "struct list_head" is 
exactly the fact that the implementation is 100% agnostic about whether a 
list entry is the head, or just part of the list.

This was actually _the_ major design goal for me. I know the "struct
list_head" interfaces are kind of weird (some people initially really
didn't like the fact that you had to use magic macros to convert from
lists to the containing structures etc, and it's funny to think that a few
years ago that list structure was considered "strange"), but the fact that 
any list entry can be the head of the list was very important.

Some uses of list_head uses "traditional" heads for the linked lists (as
heads for hashing etc), while many others just build up the list of all
entries, and each entry is a head in its own right and there is no
"external head" at all.

That's important. And you'd lose that if list_add() and friends tried to 
distinguish between a list head and a list entry.

		Linus

