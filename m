Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWGITbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWGITbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWGITbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:31:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30483 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161071AbWGITbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:31:43 -0400
Date: Sun, 9 Jul 2006 20:31:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Albert Cahalan <acahalan@gmail.com>
Cc: ray-gmail@madrabbit.org, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Opinions on removing /proc/tty?
Message-ID: <20060709193133.GA32457@flint.arm.linux.org.uk>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>,
	ray-gmail@madrabbit.org, Jon Smirl <jonsmirl@gmail.com>,
	Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
	linux-kernel@vger.kernel.org
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com> <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com> <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com> <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com> <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 03:26:19PM -0400, Albert Cahalan wrote:
> There are 16 tty major numbers (as of the Linux 1.1 kernel,
> or thereabouts) with 256 minors each, and the names are 8
> characters long. That makes for a 32 KiB file; procps will
> verify the length. Major numbers are to be stored in the
> following order:
> 
> 2,3,4,5,19,20,22,23,24,25,32,33,46,47,48,49
> 
> The structure is thus like this:
> 
> char psdevtab[16][256][8]

So it basically breaks on 2.x kernels because (eg) you don't include major
204 as a tty major.  Plus, if you insist that there are only N tty major
numbers, you break as soon as another tty major gets added.

Try again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
