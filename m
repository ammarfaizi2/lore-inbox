Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTKEQ1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTKEQ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 11:27:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:22985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262973AbTKEQ1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 11:27:48 -0500
Date: Wed, 5 Nov 2003 08:27:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt <dirtbird@ntlworld.com>
cc: herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re:[MOUSE] Alias for /dev/psaux
In-Reply-To: <3FA91493.7060009@ntlworld.com>
Message-ID: <Pine.LNX.4.44.0311050818240.11208-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Nov 2003, Matt wrote:
>
> had excatly the same problem moving to test9-mm1, way i fixed it was to 
> pass the options "psmouse_rate=60 psmouse_resolution=200" to the kernel 
> at boot (these were the old defaults).

Can you guys test passing in "psmouse_noext=1" instead?

The thing is, the psmouse initialization in 2.4.x does _nothing_. Nada. 
Zilch. Zero. And it obviously works fine. So the 2.6.x code is apparently 
just _crap_.

The extended psmouse detection code will try different things, and one 
thing in particular is that the Logitech magic ID matching sets the 
resolution to zero, while the IntelliMouse thing sets the rate to 80.

I don't know what the proper thing to do is, but I'm pretty certain that
the current mouse initialization has got to go. It clearly breaks setups
that worked fine in 2.4.x, and the 2.6.x doesn't actually have any
_advantages_ that I can tell. Maybe Vojtech can inform us.

Passing in "psmouse_noext=1" gets you close to 2.4.x behaviour.

		Linus

