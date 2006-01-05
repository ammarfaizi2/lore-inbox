Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWAEKds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWAEKds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWAEKds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:33:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751095AbWAEKdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:33:47 -0500
Date: Thu, 5 Jan 2006 05:33:39 -0500
From: Dave Jones <davej@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060105103339.GG20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 09:15:02AM +0100, Jan Engelhardt wrote:

 > Here's something interesting too:
 > Sometimes, an oops is even longer than 25 rows, and the usual user
 > does not have
 >  - VGA mode with a lot of lines (because it's hard to read)
 >  - FB mode with a lot of lines (slow, and it's also hard to read)

See the other patch I sent which halves the amount of lines needed
for a backtrace on i386 (like x86-64 uses). This helps too.

 > Is it be possible to change the VGA mode to 80x43/80x50/80x60
 > during protected mode?

After an oops, we can't really rely on anything. What if the
oops came from the console layer, or a framebuffer driver?

 > >With this patch, if we oops, there's a pause for a two minutes..
 > >which hopefully gives people enough time to grab a digital camera
 > >to take a screenshot of the oops.
 > >
 > It would be ideal to have something like BSD's "dump to predefined 
 > block device on oops", so extraction of oops logs requires neither 
 > pen-and-paper nor a digital camera. Requires another partition that
 > can be used for it, though.

I dislike most of the disk dump patches that I've seen out there
because most of them rely on the system being in a decent enough
state to be able to write out blocks of data.

If I had any faith in the sturdyness of the floppy driver, I'd
recommend someone looked into a 'dump oops to floppy' patch, but
it too relies on a large part of the system being in a sane
enough state to write blocks out to disk.

 > (*) If the oops is longer than 25 lines, ... you can't even use scrollback 
 > because scrollback is cleared when you change consoles. X runs by default 
 > on tty7, and the kernel dumps it somewhere else. (And even if it dumped to 
 > tty7 directly, you would not see it.)

What to do about oopses whilst in X has been the subject of much
head-scratching for years now.  It's come up at least at the
last two kernel summits, and I'll hazard a guess it'll come up
again this year.  The amount of work necessary to make it all
work on both kernel side and X side isn't unsubstantial however,
so I wouldn't count on it working too soon.

Hmm, SuSE/Novell folks, doesn't NKLD take over an X display?
ISTR during a demo at last years OLS the presenter was flipping
in/out of the debugger between slides. Is there anything
useful there ?

		Dave

