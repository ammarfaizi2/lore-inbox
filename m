Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVCNRSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVCNRSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVCNRSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:18:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7353 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261630AbVCNRRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:17:37 -0500
Date: Mon, 14 Mar 2005 12:17:23 -0500
From: Dave Jones <davej@redhat.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Pavel Machek <pavel@ucw.cz>, David Lang <david.lang@digitalinsight.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050314171722.GC1799@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Pavel Machek <pavel@ucw.cz>,
	David Lang <david.lang@digitalinsight.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503140855.18446.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 08:55:18AM -0800, Jesse Barnes wrote:
 > On Monday, March 14, 2005 12:37 am, Pavel Machek wrote:
 > > Perhaps we could have a rule like
 > >
 > > "non-experimental driver may only print out one line per actual
 > > device?"
 > >
 > > (and perhaps: dmesg output for boot going okay should fit on one screen).
 > >
 > > Or perhaps we should have warnings-like regression testing.
 > >
 > > "New kernel 2.8.17 came: 3 errors, 135 warnings, 1890 lines of dmesg
 > > junk".
 > >         Pavel
 > 
 > We already have the 'quiet' option, but even so, I think the kernel is *way* 
 > too verbose.  Someone needs to make a personal crusade out of removing 
 > unneeded and unjustified printks from the kernel before it really gets better 
 > though...

As long as the patches to remove/quiten various texts go through the
various subsystem maintainers, this shouldn't be a problem, though
I imagine there will be some resistance to some parts.

One of the biggest offenders is ACPI. On my desktop, that alone
accounts for 10% of the messages since boot.

(12:05:09:davej@delerium:~)$ dmesg -s 128000 | grep ^ACPI | wc -l
50
(12:05:18:davej@delerium:~)$ dmesg -s 128000 | wc -l
500

On SMP there's way too much noise.
We could do some checks in the CPU init code to not print any
of the init junk if its the same as the boot CPU.
That should be fairly trivial, and would reduce quite a few messages.

Of the 500 messages in my dmesg scrollback right now, 412 of them
are unique. Removing some of this duplication sounds like an
excellent place to begin.

Another way to save some text could be to cluster multiple lines
so that instead of..

ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.

we have

ACPI: IRQs 0,2,9 used by override.

(Whatever the hell that message means anyway -- this one just used
 as an example).

		Dave


