Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266017AbUAEXOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAEXOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:14:14 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:49420 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266018AbUAEXNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:13:44 -0500
Date: Tue, 6 Jan 2004 00:13:26 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040106001326.A1128@pclin040.win.tue.nl>
References: <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401051224480.2153@home.osdl.org>; from torvalds@osdl.org on Mon, Jan 05, 2004 at 12:38:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:38:54PM -0800, Linus Torvalds wrote:

> Have you even _tried_ udev?

Yes, and it works reasonably well. I have version 012 here.
Some flaws will be fixed in 013 or so. Some difficulties are of a
more fundamental type, not so easy to fix. But udev is an entirely
different discussion. Some other time.

> In particular, the kernel should never have policy encoded in it, and 
> naming of a device is about pretty much nothing _but_ policy.

Of course. But this is not about naming.

The kernel invents device numbers, and user space names.

Now compare our setups:

dev_t lbt_devno(void) { return random(); }

dev_t aeb_devno(char *s) { dev_t d = hash(s); while (inuse(d)) d++; return d; }

An earlier fragment of the discussion was concerned with the fact
that random(); is a bad idea. Something reproducible is better.

Let us abbreviate the above function f. Some driver determines that
a disk has serial number A809ADGC. Another driver determines that
some device was produced by HP but otherwise has no opinion.
A third driver has no stable information at all about the device.
They assign device numbers f("A809ADGC"), f("HP"), f("").

What is the result? Yes, device numbers are cookies, but a reasonable
attempt has been made to make the device numbers stable.
No guarantees anywhere - this is best effort. Better than no effort.

And this information helps udev. It may make a callout superfluous,
or even give udev information that cannot be obtained from userspace.

Andries

