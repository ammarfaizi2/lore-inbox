Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbTHaWsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbTHaWsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:48:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:47290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263032AbTHaWsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:48:25 -0400
Date: Sun, 31 Aug 2003 15:48:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>, <jun.nakajima@intel.com>
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take
 2
In-Reply-To: <20030831222414.GA29923@codepoet.org>
Message-ID: <Pine.LNX.4.44.0308311541520.28947-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 31 Aug 2003, Erik Andersen wrote:
>
> Been there done that, got the scars to prove it.  do_div() is a
> macro that acts sortof like the ISO C99 lldiv(3) function.

No.

You missed a very important part of do_div() - it has _totally_ different 
numerical range than a regular /, % or lldiv() call.

All of /, % and lldiv() work on 64-bit numbers. do_div() DOES NOT!

do_div() very much is all about:

	***   32-bit divisor  ***

which also implies that the remainder is 32-bit.

And the fact is, such a division is a lot faster than a full 64-bit 
division. On a _lot_ of architectures, but notably so on x86.

It is _not_ a 64-bit divide, and that's not only important, it's the 
whole _reason_d'etre_ for the whole function. See?

So by continually confusing it with a 64-bit divide (either by confusing 
it with lldiv() or those horrible gcc internal __{div|mod}di3u things), 
you miss the whole point of the function.

		Linus
 

