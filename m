Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSGWQZQ>; Tue, 23 Jul 2002 12:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSGWQZQ>; Tue, 23 Jul 2002 12:25:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14092 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318133AbSGWQZP>; Tue, 23 Jul 2002 12:25:15 -0400
Date: Tue, 23 Jul 2002 09:29:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
In-Reply-To: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0207230918090.5645-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, I don't disagree, but "out_cast" reads like "outcast" to me, which
has a totally different meaning than the one you want to imply.

I'd rather call it "container_struct()" or something like that, which at
least to me sounds more natural.

The difference is that in "out_cast()" you try to describe the operation
you're doing. Which is to me not very important or interesting (never mind
the confusion with a real word meaning something totally different).

In contrast, "container_struct()" tries to describe what the _result_ is,
not how we got there. And I think that's the much more important part,
especially when reading the code. You don't care how you get the result,
but you do care abotu what the result actually _means_.

And no, I'm not married to the "container_struct()" name. But any name we
come up with should have that kind of flavor to it, I feel. I think you
can more easily explain something like

	#define to_pci_dev(n) \
		container_struct(struct device, n, struct pci_dev, dev)

by telling somebody "the 'struct device' is contained within the 'struct
pci_dev', and 'to_pci_dev' converts from 'struct device' to the
container". You can explain it at a _conceptual_ level without having to
worry about what the implementation is. And that kind of conceptual notion
is always good.

While in contrast, to explain "out_cast()" you're already starting off at
a low-level compiler implementation level.

Maybe "member_to_container()" would be even better?

		Linus

