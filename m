Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277217AbRJDUfU>; Thu, 4 Oct 2001 16:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277216AbRJDUfL>; Thu, 4 Oct 2001 16:35:11 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:20151 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S277212AbRJDUe4>; Thu, 4 Oct 2001 16:34:56 -0400
Date: Thu, 4 Oct 2001 21:35:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ian Thompson <ithompso@stargateip.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I jump to non-linux address space?
Message-ID: <20011004213523.D14538@flint.arm.linux.org.uk>
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBEEGJCAAA.ithompso@stargateip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBEEGJCAAA.ithompso@stargateip.com>; from ithompso@stargateip.com on Wed, Oct 03, 2001 at 06:10:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 06:10:31PM -0700, Ian Thompson wrote:
> My kernel is running from RAM, and I want to jump to an address in ROM
> (which unfortunately, the kernel doesn't seem to know anything about).

Ok, its like you're rebooting, correct?

> I don't plan on trying to resume the kernel after doing this.  However,
> I'm getting a prefetch abort.

That's because your address range for the ROM isn't mapped - when Linux
starts on ARM, it unmaps virtually everything, and remaps only the address
ranges it wants to use.

> How can I pass execution to this address?  Do I have to turn off the MMU?

Essentially, you have 2 choices:

1. Turn off the MMU.
2. insert a 1:1 physical to virtual mapping for the ROM and call the code.
   (with interrupts disabled).

Which one works depends on what the ROM code requires.

There is an example of (1) in the current ARM kernel sources - the RiscPC
port uses this method to reboot - we can't activate the hardware reset line
on these machines, so our only option is to use this method.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

