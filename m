Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283304AbRK2QSa>; Thu, 29 Nov 2001 11:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283302AbRK2QSU>; Thu, 29 Nov 2001 11:18:20 -0500
Received: from [212.18.232.186] ([212.18.232.186]:48911 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283294AbRK2QSJ>; Thu, 29 Nov 2001 11:18:09 -0500
Date: Thu, 29 Nov 2001 16:17:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Balbir Singh <balbir_soni@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011129161756.D6214@flint.arm.linux.org.uk>
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com>; from balbir_soni@yahoo.com on Thu, Nov 29, 2001 at 08:06:37AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 08:06:37AM -0800, Balbir Singh wrote:
> Let me make it clearer to you,
> 
> lets say I call rs_open() on /dev/ttyS0 and if it
> fails then I should not call rs_close() after a failed
> rs_open().

You don't call rs_open.  The tty layer does that for you.  The tty layer
also cleans up on close by calling the driver specific close function.

Yes I agree with you that it might not, but that is a 2.5 kernel issue,
not a 2.4 "lets do a massive change" issue.  The tty layer is complex
and messy, and we shouldn't go around randomly changing it in 2.4.

> Lets see what happens with your approach
> 
> 1. I call rs_open(), it fails, ref_count set to 1

Ok, so you're poking around in kernel code calling kernel functions that
were previously declared static and not visible to anything but the tty
layer.  That immediately makes your example invalid because you're not
following the rules that the tty layers lays down for opening tty devices.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

