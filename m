Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVDIGcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVDIGcx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 02:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVDIGcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 02:32:53 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:5036
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S261300AbVDIGcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 02:32:46 -0400
To: mingo@elte.hu, "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: davidm@hpl.hp.com
Subject: Re: [patch] sched: unlocked context-switches
References: <3R6Ir-89Y-23@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: Fri, 08 Apr 2005 23:32:45 -0700
In-Reply-To: <3R6Ir-89Y-23@gated-at.bofh.it> (Tony Luck's message of "Fri,
 08 Apr 2005 20:50:11 +0200")
Message-ID: <ugoecowjci.fsf@panda.mostang.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Tony:

 >> Ingo:

 >> tested on x86, and all other arches should work as well, but if an
 >> architecture has irqs-off assumptions in its switch_to() logic it
 >> might break. (I havent found any but there may such assumptions.)

 > The ia64_switch_to() code includes a section that can change a
 > pinned MMU mapping (when the stack for the new process is in a
 > different granule from the stack for the old process).  The code
 > beyond the ".map" label in arch/ia64/kernel/entry.S includes the
 > comment:

Also, there was a nasty dead-lock that could trigger if the
context-switch was interrupted by a TLB flush IPI.  I don't remember
the details offhand, but I'm pretty sure it had to do with
switch_mm(), so I suspect it may not be enough to disable irqs just
for ia64_switch_to().  Tread with care!

	--david
