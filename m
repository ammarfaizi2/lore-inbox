Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbTKERgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTKERgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:36:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:61574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263039AbTKERgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:36:48 -0500
Date: Wed, 5 Nov 2003 09:36:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Matt <dirtbird@ntlworld.com>, <herbert@gondor.apana.org.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
In-Reply-To: <20031105170217.GA27752@ucw.cz>
Message-ID: <Pine.LNX.4.44.0311050920080.11208-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Nov 2003, Vojtech Pavlik wrote:
> 
> Regarding removing all extension support from the psmouse driver in the
> kernel, well, then we can ditch the input core completely, because the
> only way to make your mouse wheel work will be to let X access the PS/2
> port directly again, with all the problems that causes.

The alternative approach is to _not_ try to autodetect and leave it in a
sane default state - or at least leaving the detection to a minimum, but
having sane ways of letting the user set the thing.

As an example, the old psaux driver allowed the user to _send_ to the
mouse, not just receive. That made it possible for user mode to autodetect
the mouse, and set the settings. The input-mode mouse driver totally drops
that feature - which forces the kernel to get it right.

That's a very fragile design: making feedback impossible means that you
have to always get it right - which in turn tends to be fundamentally
impossible (ie new mice etc). And right now we force the user to make the
choice at _boot_ time, which means that the installer can't even ask the
user.

Also, some of the autodetect code is less intrusive. For example, if the
mouse driver decides it's a Logitech mouse, it will have set the
resolution down to zero, but it will have left the reporting rate at the
default.

In contrast, an unrecognized mouse will have gone through the intellimouse
test, which will have set the rate down to 80 (in addition to having the
resolution set down to the lowest setting by the Logitech detect code). So
now some mice get even _worse_ behaviour. Or at least different.

Right now we can't make big changes, but it would be good to think about 
the issues.

And we could make the defaults a bit nicer and less likely to screw up.

		Linus

