Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSIJTdX>; Tue, 10 Sep 2002 15:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSIJTdX>; Tue, 10 Sep 2002 15:33:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28587 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318060AbSIJTdW>;
	Tue, 10 Sep 2002 15:33:22 -0400
Date: Tue, 10 Sep 2002 12:29:53 -0700 (PDT)
Message-Id: <20020910.122953.123339054.davem@redhat.com>
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, david-b@pacbell.net,
       mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
References: <1031683480.31787.107.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The way I see it, FATAL() is the only thing that really should escape
from my local tree and end up ever being a permanent fixture of the
code that is in the standard sources.

The other WARN/DEBUG variants seem, at least to me, to be a prime
candidate for unmaintained clutter.

Also, another big win of OHSHIT(), or BUG_ON() or whatever you
want to call it is that the thing is so cheap.  Both in terms
of space (no strings, no calls with varags arguments, 1 instruction)
and time (a cycle or two).

With these DEBUG/WARN/FATAL things with the strings, I am much less
likely to ever add them to code I am writing.  Simply because I'll
say "hmmm that's expensive, the check isn't that important"

On the other hand I do recognize your user side arguments.

But to counter the "BUG with locks freezes box" argument, 9 times out
of 10 the thing that you are BUG()'ing on will freeze up the box
anyways with the same locks held when some other thread of execution
derefences some bad pointer created by, or as a side effect of, the
erroneous state.
