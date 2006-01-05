Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWAEIPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWAEIPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWAEIPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:15:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60645 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932120AbWAEIPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:15:08 -0500
Date: Thu, 5 Jan 2006 09:15:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
In-Reply-To: <20060105045212.GA15789@redhat.com>
Message-ID: <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In my quest to get better debug data from users in Fedora bug reports,
>I came up with this patch.  A majority of users don't have serial
>consoles, so when an oops scrolls off the top of the screen,
>and locks up, they usually end up reporting a 2nd (or later) oops
>that isn't particularly helpful (or worse, some inconsequential
>info like 'sleeping whilst atomic' warnings)

Here's something interesting too:
Sometimes, an oops is even longer than 25 rows, and the usual user
does not have
 - VGA mode with a lot of lines (because it's hard to read)
 - FB mode with a lot of lines (slow, and it's also hard to read)

Is it be possible to change the VGA mode to 80x43/80x50/80x60
during protected mode?

>With this patch, if we oops, there's a pause for a two minutes..
>which hopefully gives people enough time to grab a digital camera
>to take a screenshot of the oops.
>
It would be ideal to have something like BSD's "dump to predefined 
block device on oops", so extraction of oops logs requires neither 
pen-and-paper nor a digital camera. Requires another partition that
can be used for it, though.


>The one case this doesn't catch is the problem of oopses whilst
>in X. Previously a non-fatal oops would stall X momentarily,
>and then things continue. Now those cases will lock up completely
>for two minutes. Future patches could add some additional feedback
>during this 'stall' such as the blinky keyboard leds, or periodic speaker beeps.
>
Oh yes, include Stas Sergeev's PCSP patch and play a WAV telling "your box 
just crashed, wait two minutes for uh ... an oops you can't grab 
either"(*).

(*) If the oops is longer than 25 lines, ... you can't even use scrollback 
because scrollback is cleared when you change consoles. X runs by default 
on tty7, and the kernel dumps it somewhere else. (And even if it dumped to 
tty7 directly, you would not see it.)


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
