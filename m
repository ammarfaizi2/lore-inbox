Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUHHJ25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUHHJ25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 05:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUHHJ25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 05:28:57 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:54539 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S265232AbUHHJ2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 05:28:55 -0400
From: crow@old-fsckful.ath.cx
Date: Sun, 8 Aug 2004 09:28:53 +0000
To: Pavel Machek <pavel@ucw.cz>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.8-rc2-mm2] swsusp results on a hp compaq nx7000
Message-ID: <20040808092853.GC26305@old-fsckful.ath.cx>
References: <20040804120303.GA1828@final-judgement.ath.cx> <20040806201107.GD30518@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806201107.GD30518@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 10:11:07PM +0200, Pavel Machek wrote:
> Hi!
> 
> > trying to get swsusp running on my hp compaq nx7000, I've noticed
> > following problems:
> > * echo 'platform' > /sys/power/disk
> >   creates a syslog message: switching to platform, but a
> >   cat /sys/power/disk
> >   still says firmware. Other comments regard disk-writes by 'shutdown'
> >   driver
> > * system calls acpi_*_shutdown to shutdown, but it's rebooting instead
> >   of doing a system shutdown
> > * locking with regard to preemption seems so be broken
> > * ohci1394 seems to generate sporadic OOPs on resume (could be
> >   preemption related)
> > * synaptics touchpad (PS/2 driver) stops working after resume
> >   (sporadic, could also be preemption related)
> > * the AGP port driver suspends, but system is a lot slower (e.g. xterm
> >   scrolling) after resuming
> > * enabled DRI drivers (radeon) doesn't work. I'm able to move the mouse
> >   after resuming for a short time, after that the system locks up hard.
> >   (the screen is generating snow crash even while moving the mouse).
> >   The same behaviour can be observered when suspending/resuming from
> >   vt, the computer crashes with the same symptoms after switchting to X
> >   after resuming. This happens with the in kernel drm driver as with
> >   the latest x.org dri drivers (X in question is x.org 6.7).
> > * radeonfb gives a "radeonfb: resumed" message on suspending. This may
> >   be correct (if you suspend the driver and resume it afterwards to
> >   display more on-screen), but it is a rather disturbing message.
> > 
> > After all swsusp is a lot more useable compared to last time ?'ve tested
> > it. It is useable as "suspend if battery power gets low" - measure, but
> > rather unuseable for me for other things, as (normal 2D-) graphics
> > operations crawl after resuming. thanks for the good work.
> > 
> Ugh, I was offline for a week and it will take me few days to catch
> up. This is valuable feedback, and you probably do want to mail it to
> lkml and Patrick Mochel.
> 
> If you have time results with preempt disabled would be nice,
> too.

After i got some unreproduceable hangups on system boot I disabled preempt.
It may take some time until some of the problems (i.e. ohci1394) resurface.

> psmouse.proto=bare might help with synaptics.

will try that soon, but it rather seems to be some kind of strange interaction
with other modules..

	--Andreas
