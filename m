Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265621AbUAFE2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUAFE2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:28:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33437 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265621AbUAFE2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:28:32 -0500
Date: Tue, 6 Jan 2004 04:28:31 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040106042831.GI4176@parcelfarce.linux.theplanet.co.uk>
References: <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051522390.5737@home.osdl.org> <20040106005944.GH4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401051714420.2170@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051714420.2170@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 05:17:20PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 6 Jan 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > Cute.  There's a little issue of, say it, meaningful relationship between
> > sda and sda4, completely lost that way.  And _that_ has nothing to do with
> > device enumeration.
> 
> Oh, don't look too closely at some pseudo-code, it's not like the code
> would actually do that for a minor number. But for things like major
> number allocation for disk devices, it might not be too far off. And we 
> migth even want to start off the minors at some "random" offset (obviously 
> while keeping the alignment right for the partition handling)

True, but...  Let me put it that way - entire area is a minefield and
I would really like to avoid nasty surprises from "obvious" patches,
what with having just spent 4 months dealing with the fallout from one
such beast.

Let's clean the things up first; then it will be easier to see what can
and should be done.  Sure thing, reducing amount of places that deal with
device numbers is a good thing.  Let's see how far we can get it, what
obstacles still remain (and during 2.5 a _lot_ of them had been killed)
and what is needed to remove the rest.

Once they are gone (and that will be one-by-one, keeping the list of
things to grep for and checking the results of greps as we go) - then
we'll have cleaner playing field for any experiments in that area.
_And_ there will be less temptation to play the bundling games for
everyone involved (cf. devfs disaster, aka. "my glorious idea allows
to do $NEEDED_THING that way; merge the entire thing and nevermind
the fact that doing $NEEDED_THING essentially the same way is possible
without the rest of patch and can be split out of it").
