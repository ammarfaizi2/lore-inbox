Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUCTWXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbUCTWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:23:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63236 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263555AbUCTWXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:23:45 -0500
Date: Sat, 20 Mar 2004 22:23:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jaroslav Kysela <perex@suse.cz>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320222341.J6726@flint.arm.linux.org.uk>
Mail-Followup-To: Jaroslav Kysela <perex@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz> <20040320160911.B6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>; from perex@suse.cz on Sat, Mar 20, 2004 at 08:44:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 08:44:44PM +0100, Jaroslav Kysela wrote:
> Yes, I'm sorry about that, but the ->nopage usage was requested by Jeff
> Garzik and we're not gurus for the VM stuff. Because we're probably first
> starting using of this mapping scheme, it resulted to problems.

Well, I've been told to effectively screw my idea by David Woodhouse,
so may I make the radical suggestion that rm -rf linux/sound would
also fix the problem.  No, didn't think that was acceptable either.

Ok, so, how the fsck do we fix the sound drivers?  How do we mmap()
memory provided by dma_alloc_coherent() into user space portably?

It appears from what David Woodhouse has been going on about, even
providing an architecture dma_coherent_to_page() interface isn't
acceptable.

If we can't answer that question, we might as well remove ALSA and
OSS from the kernel because they are abusing existing kernel
interfaces in ways which can not be solved.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
