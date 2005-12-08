Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVLHKyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLHKyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 05:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVLHKyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 05:54:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932069AbVLHKyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 05:54:36 -0500
Date: Thu, 8 Dec 2005 10:54:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jason Dravet <dravet@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051208105425.GA28397@flint.arm.linux.org.uk>
Mail-Followup-To: Jason Dravet <dravet@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY103-F5E97636877B8723077572DF420@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F5E97636877B8723077572DF420@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:02:03PM -0600, Jason Dravet wrote:
> >As for your 64 VT tty device nodes - these "devices" are created
> >dynamically when the device node is opened.  The act of opening the
> >device node is defined to be the creation event.  If the device node
> >did not exist, there would be no way to create _any_ virtual terminals.
>
> I thought there were only 7 tty devices (Ctrl-F1 to Ctrl-F7) for local 
> system login?  Ctrl-F7 being for Xwindows.  Did I miss something?

If you look in the "init" configuration file, /etc/inittab, you'll
see lines similar to these:

1:2345:respawn:/sbin/mingetty tty1
2:2345:respawn:/sbin/mingetty tty2
3:2345:respawn:/sbin/mingetty tty3
4:2345:respawn:/sbin/mingetty tty4
5:2345:respawn:/sbin/mingetty tty5
6:2345:respawn:/sbin/mingetty tty6

Once "init" has finished bringing up the rest of the system, it will
execute the mingetty commands, asking mingetty to open the first 6 ttys.
This opening of each tty creates the virtual console, at which point
you can switch to it.

If you add:

7:2345:respawn:/sbin/mingetty tty7
8:2345:respawn:/sbin/mingetty tty8

then you'll have login prompts on ctrl-f1 to ctrl-f8, and X will be
on tty9 (ctrl-f9).

You could even ask another program to send its output to /dev/tty12,
which you'll be able to view via ctrl-f12 - eg, I do this with the
system logger on some of my systems.  At that point, you'll have
login prompts on tty1 to tty8, X on tty9 and something else on tty12.

(Note: you could comment out some of the mingetty lines in inittab,
but you should always leave at least one, in case something happens
with X and you need an alternative way to log in.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
