Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbTLFISy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbTLFISy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:18:54 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:45966 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264962AbTLFISx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:18:53 -0500
Date: Sat, 6 Dec 2003 09:18:49 +0100
From: cheuche+lkml@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found
Message-ID: <20031206081848.GA4023@localnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <3FD1199E.2030402@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD1199E.2030402@gmx.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 12:49:50AM +0100, Prakash K. Cheemplavam wrote:
> 
> So gals and guys, try disabling cpu disconnect in bios and see whether 
> aopic now runs stable.
> 
Yes that fix it. Well time will tell but I cannot make it crash with
hdparm -tT or cat /dev/hda so far. I'm dumping hda to /dev/null right
now.

After testing to make it crash, I used athcool to reenable CPU
disconnect, and guess what, test after that just crashed the box.
You found the problem, congratulations.

If you experience crashes with apic and your bios does not have such
option, try athcool at
http://members.jcom.home.ne.jp/jacobi/linux/softwares.html
Its purpose is to *enable* cpu disconnect but can also disable it. Your
best bet is to run it to disable cpu disconnect the soonest possible at
boot.

On the other hand, it isn't the cause of IRQ7 rogue interrupts. As I
initially suspected, it seems now totally unrelated. The ACPI override
handling may be buggy ? Since putting back the timer on IO-APIC-edge
solves it.

Nevertheless this is still a problem, other chipsets for Athlon
processors seems to be able to have cpu disconnect and ioapic enabled
without any crashes. But so far I don't see any thermal differences, I'm
happy with that.

Mathieu
