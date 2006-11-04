Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752655AbWKDDtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbWKDDtK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 22:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbWKDDtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 22:49:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60421 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752655AbWKDDtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 22:49:07 -0500
Date: Sat, 4 Nov 2006 04:49:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hugh Dickins <hugh@veritas.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, Russell King <rmk@dyn-67.arm.linux.org.uk>,
       linux-serial@vger.kernel.org, linux-thinkpad@linux-thinkpad.org,
       Ernst Herzberg <earny@net4u.de>
Subject: 2.6.19-rc <-> ThinkPads, summary
Message-ID: <20061104034906.GO13381@stusta.de>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <20061101030126.GE27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101030126.GE27968@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can see, the 2.6.19-rc ThinkPad situation is still 
confusing and we don't even know how many different bugs we are 
chasing...

Below is all the information I have found, plus some questions for the 
four people who reported problems that might hopefully bring us nearer 
to solutions.


Michael S. Tsirkin:
- ThinkPad T60 not coming out of suspend to RAM
- broken by commit cf4c6a2f27f5db810b69dcb1da7f194489e8ff88
  ("i386: Factor out common io apic routing entry access")
- question: Did the post -rc4 arch/i386/kernel/io_apic.c changes fix it?


Ernst Herzberg:
- ThinkPad R50p: boot fail with (lapic && on_battery)
- kernel compiled without cardbus support works
- question: Does reverting  the bisected
            commit 1fbbac4bcb03033d325c71fc7273aa0b9c1d9a03 
            ("serial_cs: convert multi-port table to quirk table")
            fix the problem?
- question: Does reverting commit cf4c6a2f27f5db810b69dcb1da7f194489e8ff88
            ("i386: Factor out common io apic routing entry access") help?
- question: If yes, did the post -rc4 arch/i386/kernel/io_apic.c changes
            fix it?


Hugh Dickins:
- ThinkPad T43p
- booting with "noapic nolapic" didn't make any difference
- reverting commit cf4c6a2f27f5db810b69dcb1da7f194489e8ff88
  ("i386: Factor out common io apic routing entry access") didn't help
- question: Was your bisecting successful?


Martin Lorenz:
- ThinkPad X60: lose ACPI events after suspend/resume
                not every time, but roughly 3 out of 4 times
- question: Does reverting commit cf4c6a2f27f5db810b69dcb1da7f194489e8ff88
            ("i386: Factor out common io apic routing entry access")
            in -rc4 help?
- question: If yes, did the post -rc4 arch/i386/kernel/io_apic.c changes
            fix it?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

