Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753554AbWKLX6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbWKLX6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 18:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbWKLX6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 18:58:16 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27151 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1753553AbWKLX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 18:58:15 -0500
Date: Sun, 12 Nov 2006 23:58:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: 7eggert@gmx.de, akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061112235806.GC31624@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@it.uu.se>, 7eggert@gmx.de,
	akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
References: <200611122240.kACMeS7l005120@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611122240.kACMeS7l005120@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 11:40:28PM +0100, Mikael Pettersson wrote:
> The bug occurs regardless of whether I leave the floppy disc in the drive
> during suspend or not. 2.6.19-rc5 (vanilla and with Ingo's suspend/resume
> hooks) fails the following use case as well:
> 
> 1. boot
> 2. insert floppy disc
> 3. tar tvf /dev/fd0 (works)
> 4. manually eject floppy disc
> 5. suspend, later resume 
> 6. insert floppy disc
> 7. tar tvf /dev/fd0 (fails with I/O errors)
> 8. tar tvf /dev/fd0 (works)
> 
> Like Ingo said, something happens to the HW during suspend and we
> need to figure out how to reinitialise the HW and the driver so that
> things work immediately after resume.

Now this is interesting - I know there's been a long standing bug with
kernels on my Thinkpad which behave in a similar way to your description
above.  Basically whenever I change the disk in the drive I tend to need
_two_ goes to do anything with it - the first mostly always fails with
IO errors.

I've not bothered to report it because it runs a _very_ old 2.6 kernel
and upgrading the machine to something modern would be extremely painful
(read - would need new hard drive, and probably more RAM than the laptop
can take.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
