Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTKHEyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 23:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTKHEyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 23:54:40 -0500
Received: from opersys.com ([64.40.108.71]:10763 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261567AbTKHEyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 23:54:38 -0500
Message-ID: <3FAC77C3.4070000@opersys.com>
Date: Fri, 07 Nov 2003 23:57:39 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: MachZ / MZ104 oddities
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm currently working with a MachZ-based MZ104 board with 8MB or RAM and
an 8MB DiskOnChip. I've been experiencing some very weird behavior with
that board and the explanations I've received up to here have only left
more unanswered questions ...

But first some background into what I've trying to do. Basically, as a
first part, I was building a bootable floppy for that system (lilo,
linux 2.4.22, busybox->statically linked to uClibc.) Usually this sort
of stuff is a piece of cake, but not this time. I've already described
what I witnessed in this thread:
http://www.busybox.net/lists/busybox/2003-November/009858.html
Basically, BusyBox was showing very odd behavior: not finding "/sbin/init"
when it really was there, printing out strings which would normally be
found in the kernel image. Trying that same boot floppy on a Pentium60
with the same amount of RAM worked just fine, but not on that system ...
I started suspecting some hardware problem.

A few phone calls later, I discovered that I wasn't the only person who
had witnessed this sort of stuff before. I learned that there are two
types of memory cards for this board: 16-bit and 32-bit. Systems using
32-bit ones did not have this odd behavior. Systems with 16-bit ones,
however, seem to have some weird problems happen with no regular pattern:
- Floppy problems (hangs)
- oops on insmods
- etc.
[ I won't elaborate, but the "just switch to a 32-bit memory" possibility
just isn't a card I can play here. ] Basically, when using one of those
16-bit memory card, the CPU operates much like a 386sx: multiplexing 32-bit
stuff in two 16-bit units. Switching between true 32-bit and the muxed
one is done on power-up with the CPU detecting the number of lines
connected to it (the CPU really does have 32 lines out however.)

Back to my initial problem, I began thinking of which parts of the kernel
would be susceptible to this sort of stuff. Having seen some bizarre
kernel PCI strings ending up somehow being printed in _user-space_ by
BusyBox, I thought the PCI subsystem was likely one those subsystem not
having had much of a test ride on an 386sx. Lucky guess or not, it just
happened that disabling the PCI subsystem entirely actually resulted in
a successful init.

Nevertheless, the system isn't entirely stable. When the floppy is mounted
as the rootfs, I get spurious hangs which seem to have no correlation
between each other ... Someone suggested DMA may be the problem ...

So basically, I'm wondering if anyone has seen something like this
before or if anyone has any suggestions. I realize that the kernel is
likely not receiving much testing on 386sx systems these days, and
maybe that's the problem. But it may just be that the silicon I'm working
with is broken, in which case any suggested workarounds would be welcome.

[ Note: I've tried 2.4.20, 2.4.21, and 2.4.22, and the problems happen
on all of them. ]

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

