Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUDDUc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 16:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUDDUc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 16:32:58 -0400
Received: from mail1.kontent.de ([81.88.34.36]:56742 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262752AbUDDUc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 16:32:56 -0400
Date: Sun, 4 Apr 2004 22:32:54 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.x] reboot fails on AMD Athlon System
Message-ID: <20040404203254.GA2780@kenny.sha-bang.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello *,

On my AMD Athlon System any version of Linux 2.6.x (including 2.6.5)
hangs when trying to reboot (or power off).  Any other OS (including
any Linux version up to 2.4.x) reboots the box like expected.

I posted this before, so a long version of the problem report can be
found here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107913498220501&w=2
 

After getting no helpful reply I decided to ignore the fact that I'm
no kernel-hacker and started digging in the sources.

What I found (or better: what I haven't found) is even more confusing
to me:  the system hangs exactly at the time when the reboot should
be triggered by mach_reboot().

I tracked it down to this very line by placing lots of printk() with
debugging messages into linux/arch/i386/kernel/reboot.c

The strange thing is: the code of mach_reboot() is line by line exactly
the same as used in Linux 2.4.24 which reboots the box w/o problems.

I even forced the kernel to use the alternative reboot method ("force
a triple fault" -- code same as in 2.4.x, too) but with no success.

The conclusion so far: the code that hangs is not changed in
comparison with Linux 2.4.24 which works for me, so the reason for the
failure must be elsewhere in the setup of the hardware environment.
Maybe in the apic disabling code, though it looks very similar to the
2.4.24 version, too.  Or in the setup of the AMD [Irongate/Viper]
chip-set?

As mentioned before I don't know anything about kernel-hacking or
the esoteric details of x86 platform, but maybe those of you who do,
can give me some useful hints on where to look further.

Please cc me in any reply, I'm not subscribed to the lkml.

cheers
sascha
-- 
Sascha Wilde  :  "I heard that if you play the Windows CD backward, you
              :  get a satanic message. But that's nothing compared to
              :  when you play it forward: It installs Windows...." 
              :  -- G. R. Gaudreau
