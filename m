Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSLIRtP>; Mon, 9 Dec 2002 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSLIRtP>; Mon, 9 Dec 2002 12:49:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20749 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265886AbSLIRtL>; Mon, 9 Dec 2002 12:49:11 -0500
Date: Mon, 9 Dec 2002 09:57:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jim Houston <jim.houston@ccur.com>
cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DF4D7B1.7A037B25@ccur.com>
Message-ID: <Pine.LNX.4.44.0212090955390.10925-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 9 Dec 2002, Jim Houston wrote:
>
> Either I'm missing something or this is broken if there is ever
> more than one restart function involved.  You save the arguments
> to the register state that gdb saves but not the restart function
> address.  In the nested case this would call one restart function
> with the arguments of another.

That's true. Scratch this patch - it's too painful on ia64 anyway, and it
doesn't nest correctly in the first place. We'd need to save off the
"restarted system call number" in user space too to get proper nesting,
just saving the arguments isn't enough.

So we're just going to have to live with the fact that restarting doesn't
nest. I think the gdb example by Daniel was interesting, but perhaps not
all that important ;)

		Linus

