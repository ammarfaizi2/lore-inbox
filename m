Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTEJRZe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTEJRZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:25:34 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:18216 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264451AbTEJRZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:25:32 -0400
From: Jos Hulzink <josh@stack.nl>
To: Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: Sat, 10 May 2003 21:41:57 +0200
User-Agent: KMail/1.5
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030510025634.GA31713@averell> <20030510161529.GB29271@mail.jlokier.co.uk>
In-Reply-To: <20030510161529.GB29271@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305102141.57860.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 May 2003 18:15, Jamie Lokier wrote:
> I just did some Googling and found that there examples of DOS code
> fragments using both vectors.  Also, the original IBM BIOS (as they
> say) had a long jump at the vector, which is presumably one of the
> many de facto ABIs which real mode programmers grew to depend on.

The 16 byte code space is very small, and usually only contains that LONG jump 
to an usable address space.

When the vector f000:fff0 is used, we can survive BIOSes that use relative 
jumps with negative offsets or indirect short jumps instead.

When the vector ffff:0000 is used, the code segment effectively contains only 
16 bytes (or someone must abuse the 8086 wraparound), can't think of negative 
offset short jumps there. As the code is read-only in this early stage, (BIOS 
code is RW after the BIOS copied itself to RAM) self modifying code (which 
uses absolute addressing) can be excluded too.

Okay... now, as 386 and newer cpus need a far jump to unlock A20-A31, I think 
it is safe to assume all BIOSes will do a far jump as soon as possible, which 
means it doesn't matter which vector is used.

For the sake of bad behaving BIOSes however, I'd vote for the f000:fff0 
vector, unless someone can hand me a paper that says it is wrong.

Jos
