Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268343AbRGWVS1>; Mon, 23 Jul 2001 17:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268353AbRGWVSI>; Mon, 23 Jul 2001 17:18:08 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:34063
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S268343AbRGWVRu>; Mon, 23 Jul 2001 17:17:50 -0400
Date: Mon, 23 Jul 2001 14:17:51 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010723141751.W6820@work.bitmover.com>
Mail-Followup-To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
	martizab@libertsurf.fr, rusty@rustcorp.com.au
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr>; from jerome.de-vivie@wanadoo.fr on Mon, Jul 23, 2001 at 11:06:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> The multiple version filesystem (mvfs) of ClearCase gives a
> transparent acces to the data. I found this feature cool, but the
> overall system is too complex. I would like to write an extension
> module for the linux kernel to handle version control in a simply way.

Having been through this a time or two, a few points to consider:

a) This is a hard area to get right.  I've done it twice, I told Linus that
   I could do it the second time in 6 months, and that was 3 years ago and
   we're up to 6 full time people working on this.  Your mileage may vary.
b) Filesystem support for SCM is really a flawed approach.  No matter how
   much you hate all SCM systems out there, shoving the problem into the
   kernel isn't the answer.  All that means is that you have an ongoing
   battle to keep your VFS up to date with the kernel.  Ask Rational
   how much fun that is...
c) If you have to do a file system, may I suggest that you clone the SunOS
   4.x TFS (translucent file system)?  It's a useful model, you "stack" a
   directory on top of a directory and you can see through to the underlying
   directory.  When you write to a file, the file is copied forward to the
   top directory.  So a hack attack is

   	mount -t TFS my_linux /usr/src/linux
	cd my_linux
	hack hack hack
	... many hours later
	cd ..
	umount my_linux
	find . -type f -print	# this is your list of modified files

   It's a cool thing but only semi needed - most serious programmers already
   know how to do the same thing with hard links.

More brains are better than less brains, so welcome to the SCM mess...
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
