Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUACEqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 23:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUACEqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 23:46:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:12195 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262598AbUACEqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 23:46:46 -0500
Date: Fri, 2 Jan 2004 20:46:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040103040013.A3100@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl>
 <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net>
 <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl>
 <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>
 <20040103040013.A3100@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jan 2004, Andries Brouwer wrote:
> 
> > Note that one reason I didn't much like the 64-bit versions is that not 
> > only are they bigger, they also encourage insanity. Ie you'd find SCSI 
> > people who want to try to encode device/controller/bus/target/lun info 
> > into the device number. 
> 
> Weak. "We don't want this power that has good uses because it also
> can be used stupidly." That is not Unix-style.

No.

That's not the argument: the argument is that the _only_ thing that 64-bit 
stuff can be used for is stupid things.

For everything else, a 32-bit dev_t is sufficient.

And the UNIX way is definitely: "do one thing, and do it well" and "small
is beautiful". It has _never_ been "overdesign everything to accomodate
stupidity".

You may have confused UNIX with Multics. Where overdesign was the rule, 
not the exception.

> > We should resist any effort that makes the numbers "mean" something. They 
> > are random cookies. Not "unique identifiers", and not "addresses".
> 
> Random cookies? I prefer "arbitrary" over "random". The value plays no role
> at all, but it must be unique, preferably stable across reboots.

Don't use "unique". It has way too many connotations of _true_ uniqieness 
in computer science.

And the operative word in "preferably stable across reboots" is
"preferably". Because it basically cannot be in the general case (it 
can't be unique for things that aren't enumerable, and clearly a lot of 
things aren't), and thus nothing must ever _assume_ it is.

And the thing is, to break those wrong assumptions (that are true in many
common cases, but are _not_ true in the rare general case), we may have to
actively do things that are "silly" on purpose. For example, for 
debugging, we start the "jiffies" counter not at zero, but at -300. That's 
patently _silly_, but it was very useful in finding the cases where the 
rare general case was not handled correctly.

Similarly, I'll probably advocate at some point (when distributions are
using udev) that we purposefully try to make device numbers _unstable_
across reboots, to find cases that do the wrong thing and have things
hardcoded. Exactly to find and fix them, so that the distribution works 
correctly even when things aren't enumerable.

(As to examples of inumerable devices, iSCSI comes to mind. As does pretty 
much anything else that is connected over IP - you can't even enumerate 
according to path or IP, since those may change too).

		Linus
