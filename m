Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVLUWuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVLUWuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVLUWuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:50:21 -0500
Received: from free.hands.com ([83.142.228.128]:54437 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S964908AbVLUWuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:50:20 -0500
Date: Wed, 21 Dec 2005 22:49:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ordering of suspend/resume for devices.  any clues, anyone?
Message-ID: <20051221224939.GI8496@lkcl.net>
References: <20051215143124.GD14978@lkcl.net> <20051221102109.GB1735@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221102109.GB1735@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

heya pavel,

thanks for the tip.  as it turns out, a function table was hacked-n
that back-link from the w100fb framebuffer resume function into the
LCD code.

in this way, it is possible to call functions in the LCD module
doing GPIO to start the power-up sequence required for the
LCD and backlight, wait a few ms, initialise the video chip
(in the w100fb code), then call _another_ set of functions in
the LCD module to finish off the initialisation.

not pretty, but there you go.

l.

On Wed, Dec 21, 2005 at 11:21:09AM +0100, Pavel Machek wrote:
> Hi!
> 
> > [hi, please kindly cc me direct as i am deliberately subscribed with
> > settings to not receive posts from this list, but if that is inconvenient
> > for you to cc me, don't worry i can always look up the archives
> > to keep track of replies, thank you.]
> > 
> > http://handhelds.org/moin/moin.cgi/BlueAngel
> > 
> > works.
> > 
> > am seeking some advice regarding power management - specifically
> > the ordering of devices "resume" functions being called.
> > 
> > we have an LCD, and an ATI chip.  switching on the LCD powers up
> > the ATI chip.
> > 
> > unfortunately, resume calls the ATI device initialisation
> > _before_ the LCD resume initialisation.  the ATI chip's
> > initialisation fails - naturally - because it's not even
> > powered up.
> 
> I'd say "make LCD system/platform device". That will init it first,
> shut it down last.
> 							Pavel
> 
> -- 
> Thanks, Sharp!

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
