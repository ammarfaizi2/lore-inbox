Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTKESlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTKESlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:41:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:14764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263107AbTKESjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:39:55 -0500
Date: Wed, 5 Nov 2003 10:39:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Matt <dirtbird@ntlworld.com>, <herbert@gondor.apana.org.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
In-Reply-To: <20031105180035.GB27922@ucw.cz>
Message-ID: <Pine.LNX.4.44.0311051031450.11208-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Nov 2003, Vojtech Pavlik wrote:

> On Wed, Nov 05, 2003 at 09:36:28AM -0800, Linus Torvalds wrote:> 
> 
> > The alternative approach is to _not_ try to autodetect and leave it in a
> > sane default state - or at least leaving the detection to a minimum, but
> > having sane ways of letting the user set the thing.
> 
> Would sysfs be a sane enough way?

I suspect sysfs would be a _good_ way to do it. I'm sure it could be 
screwed up too, but I don't think it would necessarily be wrong to be able 
to do

	echo imps2 > /sys/class/input/mouse/1/protocol
	echo 200 > /sys/class/input/mouse/1/rate

or something similar.

> I still would prefer to have the autodetect be enabled, because it works
> for 99% of the cases and allow to set the mouse protocol manually
> (either boot time or via sysfs) for the troublesome cases.

I'm a big believer in having the "default behaviour" be as user-friendly 
as possible. I do not believe in the mantra "we should do as little as 
possible, and let the user set everything up".

> If psmouse.o is a module, the installer of course can ask the user. 

I think that's a failure. For one thing, you need the module to even _let_
the user select the mouse type: you can't seriously expect installers for
normal users to not run graphically and with a mouse already?

In general, module parameters are _always_ a sign of failure. I don't know
of a single one that can be considered a "good thing". They are sometimes
required, but they should be required only for hardware that is just very
fundamentally broken.

			Linus

