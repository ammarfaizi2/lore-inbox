Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSIJSfl>; Tue, 10 Sep 2002 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSIJSfk>; Tue, 10 Sep 2002 14:35:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9737 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317945AbSIJSfj>; Tue, 10 Sep 2002 14:35:39 -0400
Date: Tue, 10 Sep 2002 11:40:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: jgarzik@mandrakesoft.com, <david-b@pacbell.net>,
       <mdharm-kernel@one-eyed-alien.net>, <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <20020910.111627.00809211.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209101132320.3280-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Sep 2002, David S. Miller wrote:
>    
>    IMO we should have ASSERT() and OHSHIT(),
> 
> I fully support the addition of an OHSHIT() macro.

Oh, please no. We'd end up with endless asserts in the networking layer, 
just because David would find it amusing. 

I can just see it now - code bloat hell.

And no, I still don't like ASSERT().

I think the approach should clearly spell what the trouble level is:

	DEBUG(x != y, "x=%d, y=%d\n", x, y);

	WARN(x != y, "crap happens: x=%d y=%d\n", x, y);

	FATAL(x != y, "Aiee: x=%d y=%d\n", x, y);

where the DEBUG one gets compiled out normally (or has some nice per-file
way of being enabled/disabled - a perfect world would expose the on/off in
devicefs as a per-file entity when kernel debugging is on), WARN continues
but writes a message (and normally does _not_ get compiled out), and FATAL
is like our current BUG_ON().

All would print out the filename and line number, the message, and the 
backtrace.

		Linus

