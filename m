Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSG3Rlx>; Tue, 30 Jul 2002 13:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSG3Rlx>; Tue, 30 Jul 2002 13:41:53 -0400
Received: from holomorphy.com ([66.224.33.161]:1971 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315431AbSG3Rlx>;
	Tue, 30 Jul 2002 13:41:53 -0400
Date: Tue, 30 Jul 2002 10:44:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Andi Kleen'" <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
Message-ID: <20020730174457.GB25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
	'Andi Kleen' <ak@suse.de>, linux-kernel@vger.kernel.org
References: <3FAD1088D4556046AEC48D80B47B478C0101F3B2@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F3B2@usslc-exch-4.slc.unisys.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 12:06:54PM -0500, Van Maren, Kevin wrote:
> It isn't obvious to me how to extend those queued to reader/writer
> locks if you have to allow recursive readers without incurring the
> same overhead of tracking which processors already have a reader lock.
> If you do want to trigger recursive rw_locks, simply change the header
> file to make them normal spinlocks.  Then whenever the kernel hangs,
> see where it is. Of course, this approach only finds all of them if
> you execute every code path.
> Does anyone want to chip in on why we need recursive r/w locks?  Or why it
> is hard to remove them?  It doesn't sound like they are used much.

The tasklist_lock is taken in interrupt context by sigio generation,
and read_locks on it are permitted to be interrupted by other read_locks,
where write_locks of it must mask interrupts locally to prevent deadlock.
I think IA64 performance monitor code does it in interrupt context too.

Older (2.4.x and 2.5.x-early) took the tasklist_lock in interrupt
context to compute the load average by traversing the list of all tasks.
My concern when I changed that was largely timeslice overrun.


Cheers,
Bill
