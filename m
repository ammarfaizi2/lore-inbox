Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRCaAQb>; Fri, 30 Mar 2001 19:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131750AbRCaAQV>; Fri, 30 Mar 2001 19:16:21 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:25605 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131742AbRCaAQR>;
	Fri, 30 Mar 2001 19:16:17 -0500
Date: Sat, 31 Mar 2001 02:15:14 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Recent problems with APM and XFree86-4.0.1
Message-ID: <20010331021514.A6784@pcep-jamie.cern.ch>
In-Reply-To: <20010325164003.6131@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010325164003.6131@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, Mar 25, 2001 at 06:40:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> There is a problem with the power management code for console.c
> 
> The current code calls do_blank_screen(0); on PM_SUSPEND, and
> unblank_screen() on PM_RESUME.
> 
> The problem happens when X is the current display while putting the
> machine to sleep. The do_blank_screen(0) code will do nothing as
> the console is not in KD_TEXT mode.
> However, unblank_screen has no such protection. That means that
> on wakeup, the cursor timer & console blank timers will be re-enabled
> while X is frontmost, causing the blinking cursor to be displayed on
> top of X, and other possible issues.

On that theme of power management with X problems, I have been having
trouble with my laptop crashing when the lid is closed, instead of
suspending as it used to.  The laptop is a Toshiba Satellite 4070CDT.

The problem appeared around the time I updated the XFree86-4 package to
Red Hat 7's latest update, but I also updated to kernel 2.4.2 around
the same time so I'm not sure of the cause.

Until recently, closing the lid caused the machine to beep three times,
sync data to disk and suspend, then opening the lid resumed.  This
worked with or without X displaying.

Now if I switch to a text console and then suspend, it is fine.

If I have X displaying, closing the lid causes the machine to
beep... and beep and beep.  About half the time it does suspend after
many more beeps than usual (e.g. 10 seconds pass before deciding to sync
to disk), and in that case it usually resumes ok but sometimes it
resumes and the machine is not responding to keyboard input.  When this
happens, a hard reboot is required.  (SysRq doesn't work).

The other half of the time it just beeps repeatedly forever.  Mouse
input doesn't work, nor does keyboard.  Curiously, SysRq-S-U-B still
syncs and reboots the machine with a clean disk from this state.

These effects might have something to do with APM in current kernels
and/or XFree86-4.0.1-1 from Red Hat 7 updates.  Has anyone observed
similar recent problems?

-- Jamie
