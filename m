Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264684AbTFLBUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbTFLBUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:20:33 -0400
Received: from inconnu.isu.edu ([134.50.8.55]:62099 "EHLO inconnu.isu.edu")
	by vger.kernel.org with ESMTP id S264684AbTFLBUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:20:24 -0400
Date: Wed, 11 Jun 2003 19:34:03 -0600 (MDT)
From: I Am Falling I Am Fading <skuld@anime.net>
X-X-Sender: skuld@inconnu.isu.edu
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org, <gregor.essers@web.de>
Subject: Re: Via KT400 and AGP 8x Support
In-Reply-To: <20030611094441.GE14706@suse.de>
Message-ID: <Pine.LNX.4.44.0306111922110.8476-100000@inconnu.isu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003, Dave Jones wrote:

> On Wed, Jun 11, 2003 at 02:28:24AM -0600, I Am Falling I Am Fading wrote:
> 
>  > I've had this problem as well.
>  > 
>  > What I've been able to do is to use a backport for one of the 2.4.21-pre*
>  > series, and move the code forward to the current 2.4.21-rc's .
> 
> That's not a proper fix. The agp code in 2.4.21pre supports the KT400
> only in AGP2.0 mode. When you put an AGP3.0 (x8) card in the slot,
> the chipset configures itself into AGP3 mode, and registers change
> meaning.
> 
>  > Here's info on the relevant patch:
>  > http://lists.insecure.org/lists/linux-kernel/2003/Mar/3999.html
> 
> Very, very dated now. Many fixes have gone into the agp code since
> 2.5.64, on which that backport is based.

I'm aware that it doesn't work right, unfortunately getting AGP3.0 working 
at all under the 2.4 kernel doesn't have any real solution, with the 
exception of nVidia's binary-only drivers for the nForce2. 

This solution at least initializes some stuff and allows me to use the ATI 
drivers for 2D acceleration on my KT400-based board, whcih didn't work 
before I applied that patch. Consequently, it's the best solution I have 
now for people who want to use their R3xx-series ATI cards on AGP3.0 
systems. 

The only other solution is to kick your card down into AGP 2.0 mode, which 
most BIOSes do not allow you to do in software. Instead what you have to 
do is cut/unsolder traces on your video card for the pins used for AGP 3.0 
detection. This is a near-permanent and horrible solution but it does get 
everything working. :-/ 

Dave, if you have a better solution for the 2.4 kernel I'd be very, very 
happy to see it. :-( Unfortunately I'm not a good enough coder to write 
proper AGP3.0 support for the 2.4 kernel myself, and can only shuffle 
other people's code around.

Someday 2.6 is going to fix all this but it's just not ready yet, and 
while it's fun to run a 2.5 kernel it's not something I would recommend to 
someone else (aside from this, it wouldn't fix his situation since the ATI 
binary-only drivers puke on 2.5).

I despair at the DRI project ever getting back in gear -- it's in horrible 
disarray and the development list is now 75% spam. Some good improvements 
came thanks to a donation from the Weather Channel, but it's not enough to 
provide comprehensive support. :-( Maybe there needs to be a "save DRI" 
fund. :-/

-----
James Sellman -- ISU CoE-CS/ISLUG Linux Lab Admin   |"Lum, did you just see
----------------------------------------------------| a hentai rabbit flying
skuld@inconnu.isu.edu      |   // A4000/604e/60 128M| through the air?"
skuld@anime.net            | \X/  A500/20 3M        |   - Miyake Shinobu

