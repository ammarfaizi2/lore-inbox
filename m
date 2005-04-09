Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVDIHQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDIHQa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 03:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVDIHQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 03:16:30 -0400
Received: from palrel11.hp.com ([156.153.255.246]:58092 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261303AbVDIHQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 03:16:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16983.33049.962002.335198@napali.hpl.hp.com>
Date: Sat, 9 Apr 2005 00:15:37 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: davidm@hpl.hp.com, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
In-Reply-To: <20050409070738.GA5444@elte.hu>
References: <3R6Ir-89Y-23@gated-at.bofh.it>
	<ugoecowjci.fsf@panda.mostang.com>
	<20050409070738.GA5444@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 9 Apr 2005 09:07:38 +0200, Ingo Molnar <mingo@elte.hu> said:

  Ingo> * David Mosberger-Tang <David.Mosberger@acm.org> wrote:

  >> > The ia64_switch_to() code includes a section that can change a
  >> > pinned MMU mapping (when the stack for the new process is in a
  >> > different granule from the stack for the old process).  The code
  >> > beyond the ".map" label in arch/ia64/kernel/entry.S includes the
  >> > comment:

  >> Also, there was a nasty dead-lock that could trigger if the
  >> context-switch was interrupted by a TLB flush IPI.  I don't
  >> remember the details offhand, but I'm pretty sure it had to do
  >> with switch_mm(), so I suspect it may not be enough to disable
  >> irqs just for ia64_switch_to().  Tread with care!

  Ingo> we'll see. The patch certainly needs more testing. Generally
  Ingo> we do switch_mm()'s outside of the scheduler as well, without
  Ingo> disabling interrupts.

Yes, of course.  The deadlock was due to context-switching, not
switch_mm() per se.  Hopefully someone else beats me to remembering
the details before Monday.

	--david
