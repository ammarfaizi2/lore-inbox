Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTFPCbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 22:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTFPCbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 22:31:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33809 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263245AbTFPCbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 22:31:15 -0400
Date: Sun, 15 Jun 2003 19:44:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <rth@twiddle.net>, <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
In-Reply-To: <20030616002453.8A9B72C078@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306151939140.10415-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jun 2003, Rusty Russell wrote:
> 
> AFAICT, Roman's fix is correct; Richard admonished me in the past for
> such code, IIRC, but this one slipped through.

Roman's fix is fine, but the fact is, the original code was also fine. 
Yes, the C standard has all these rules about "within objects" for pointer 
differences, but the "objects" themselves can come from outside the 
compiler. As they did in this case.

(Yeah, I could see the compiler warning about cases it suspects might be 
separate objects, but the end result should still be the right one).

In general, I accept _local_ uglifications to work around compiler
problems. But I do not accept non-local stuff like making for ugly calling
conventions etc, which is why Andi's original patch was not acceptable to
me.

It turns out that the real bug was somewhere in the tool chain, and the 
linker should either honor alignment requirements or warn about them when 
it cannot. I suspect in this case the alignment requirement wasn't 
properly passed down the chain somewhere, I dunno. The problem is fixed, 
but for future reference please keep this in mind when working around 
compiler problems.

If worst comes to worst, we'll have notes about certain compiler versions 
just not working. It's certainly happened before.

		Linus

