Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSKKBp5>; Sun, 10 Nov 2002 20:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265331AbSKKBp5>; Sun, 10 Nov 2002 20:45:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22543 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265326AbSKKBp4>; Sun, 10 Nov 2002 20:45:56 -0500
Date: Sun, 10 Nov 2002 17:51:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
In-Reply-To: <20021111012150.GO22031@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0211101747420.12703-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Nov 2002, William Lee Irwin III wrote:
> 
> Then the options have been mangled and it doesn't do this right anymore,
> with the net result that there's no way to turn off TSC synch ever. I've
> narrowed this down to config options setting CONFIG_X86_TSC for at least for
> all cpu revisions > 586

But that's the point. If you specify that you have a CPU > 586, then you 
specify at compile-time that you have TSC.

If your TSC is broken, then you shouldn't do that. You should compile for 
"generic x86" (386), and then say "notsc".

(Yeah, it should work for i486 too, but in general it's the "generic 386"  
that should work on all machines because it doesn't assume anything about
the capabilities of the machine).

But considering that we don't use the static TSC knowledge very much any
more, you might want to remove CONFIG_X86_TSC altogether, though, and
replace its uses with run-time checks. We've done that with a lot of the
other config stuff earlier (SSE/XMM) because the static compiled options
are just too inconvenient and not worth the maintenance hassles..

		Linus

