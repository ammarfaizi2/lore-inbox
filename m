Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPIzN>; Sat, 16 Dec 2000 03:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLPIzE>; Sat, 16 Dec 2000 03:55:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129183AbQLPIys>; Sat, 16 Dec 2000 03:54:48 -0500
Date: Sat, 16 Dec 2000 00:23:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Barry K. Nathan" <barryn@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13pre2 - netfilter modiles compile failure
In-Reply-To: <200012160806.AAA32686@pobox.com>
Message-ID: <Pine.LNX.4.10.10012160015521.11822-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Barry K. Nathan wrote:
> 
> Ok, I tried that, and I tried Andrew Morton's patch as well. Both patches
> fix the module case, but not the in-kernel case. With Linus' patch, the
> in-kernel case fails with the error message in my previous mail.

Ok, the guy who made the netfilter Makefile was probably on some really
interesting and probably highly illegal drugs when he wrote it. My fairly
direct conversion to new-style Makefiles failed because there are some
semantic differences that don't translate well.

The first question that pops to mind is, of course, "Where can _I_ get
some of thos drugs?".

The second question is "Hmm.. ipfwadm_core.o seems to show up in multiple
places, I wonder why?"

I suspect that you should remove "ipfwadm_core.o" too from
"ip_nf_compat-objs", because it's already part of "ipfwadm-objs", and we
don't want to link it in twice.

So "ip_nf_compat-objs" should really just be

	ip_nf_compat-objs := ip_fw_compat.o ip_fw_compat_redir.o ip_fw_compat_masq.o

which looks much saner at least for the built-in case (ie no duplicate
object files in the multi-lists, and the multi-lists have sane entries).

Does that work for you?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
