Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbULEMOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbULEMOx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 07:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbULEMOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 07:14:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6925 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261295AbULEMOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 07:14:51 -0500
Date: Sun, 5 Dec 2004 12:14:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3
Message-ID: <20041205121446.B25743@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200412041903.55583.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200412041903.55583.david-b@pacbell.net>; from david-b@pacbell.net on Sat, Dec 04, 2004 at 07:03:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 07:03:55PM -0800, David Brownell wrote:
> > From:       Martin Josefsson <gandalf () wlug ! westbo ! se>
> > Date:       2004-12-04 21:42:11
> > 
> > That's an usb2.0 bug, the ehci driver sleeps when it can't sleep.
> 
> Who changed it so that context was no longer allowed to sleep???

suspend and resume methods must be able to sleep because you may
need to talk to external hardware, wait for queues to drain, etc
which may in turn require kernel threads to run.

We must be able to sleep in suspend/resume methods.  PCMCIA requires
it, as do other subsystems.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
