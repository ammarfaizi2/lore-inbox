Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTFTADf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTFTADe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:03:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30986 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262029AbTFTADa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:03:30 -0400
Date: Thu, 19 Jun 2003 17:16:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Nuno Silva <nuno.silva@vgertech.com>
cc: Samphan Raruenrom <samphan@thai.com>, Vojtech Pavlik <vojtech@suse.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crusoe's persistent translation on linux?
In-Reply-To: <3EF24F1A.1040009@vgertech.com>
Message-ID: <Pine.LNX.4.44.0306191707000.1987-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jun 2003, Nuno Silva wrote:
> 
> This raises a new question. How about a port of Linux to the "VLIW" so 
> that we can skip x86 "code morphing" interelly?

The native crusoe code - even if it was documented and available - is not 
very conductive to general-purpose OS stuff. It has no notion of memory 
protection, and there's no MMU for code accesses, so things like kernel 
modules simply wouldn't work.

> I'm sure that 1GHz would benefit from it. Is it possible, Linus?

The translations are usually _better_ than statically compiled native 
code (because the whole CPU is designed for speculation, and the static 
compilers don't know how to do that), and thus going to native mode is not 
necessarily a performance improvement.

So no, it wouldn't really benefit from it, not to mention that it's not
even an option since Transmeta has never released enough details to do it
anyway. Largely for simple security concerns - if you start giving
interfaces for mucking around with the "microcode", you could do some
really nasty things. 

Process startup is slightly slower due to the translation overhead, but
that doesn't matter for the kernel anyway (so a native kernel wouldn't
much help). And we do cache translations in memory, even across
invocations. I suspect the reason large builds are slower are due to slow
memory and/or occasionally overflowing the translation cache.

			Linus

