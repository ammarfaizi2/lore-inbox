Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSKJTZY>; Sun, 10 Nov 2002 14:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265109AbSKJTZX>; Sun, 10 Nov 2002 14:25:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58376 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265094AbSKJTZX>; Sun, 10 Nov 2002 14:25:23 -0500
Date: Sun, 10 Nov 2002 11:31:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: vojtech@ucw.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
In-Reply-To: <20021110191822.GA1237@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0211101127460.9581-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Nov 2002, Pavel Machek wrote:
> 
> I believe you need to *store* last value given to userland.

But that's trivially done: it doesn't even have to be thread-specific, so 
it can be just a global entry anywhere in the process data structures.

This is just a random sanity check thing, after all. It doesn't have to be 
system-global or even per-cpu. The only really important thing is that 
"gettimeofday()" should return monotonically increasing data - and if it 
doesn't, the vsyscall would have to ask why (sometimes it's fine, if 
somebody did a settimeofday, but usually it's a sign of trouble).

But yes, it's certainly a lot more complex than just doing it in a 
controlled system call environment. Which is why I think vsyscalls are 
eventually not worth it.

			Linus

