Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTDUUw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTDUUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:52:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43789 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261962AbTDUUw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:52:57 -0400
Date: Mon, 21 Apr 2003 14:04:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
In-Reply-To: <20030421205333.GA13883@averell>
Message-ID: <Pine.LNX.4.44.0304211359430.17938-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Andi Kleen wrote:
>
> Ok fixed. I used the recommendations from the Hammer optimization
> manual, will hopefully work for Intel too.

They may _work_ for intel, but quite frankly they suck for most Intel (and 
probably non-intel too) CPU's. Using prefixes tends to almost always mess 
up the instruction decoders on most CPU's out there.

I _think_ most Intel chips have one generic decoder (which knows about
prefixes etc), and the rest only handle simple instructions.

Intel has some preferred sequence that I'd much rather use by default,
although we can obviously use a CONFIG_xxx option to switch between these
sequences.

I forget what the intel sequence is, but I think the multi-byte opcodes 
are something like "lea 0(%esi),%esi" rather than adding operand size 
prefixes to the nop.

Does anybody have the preferred Intel sequence somewhere?

			Linus

