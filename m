Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbTCRBMU>; Mon, 17 Mar 2003 20:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbTCRBMT>; Mon, 17 Mar 2003 20:12:19 -0500
Received: from holomorphy.com ([66.224.33.161]:46556 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262083AbTCRBMS>;
	Mon, 17 Mar 2003 20:12:18 -0500
Date: Mon, 17 Mar 2003 17:22:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
Message-ID: <20030318012247.GU20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20030316213516.GM20188@holomorphy.com> <Pine.LNX.4.44.0303170719410.15476-100000@localhost.localdomain> <20030317070334.GO20188@holomorphy.com> <3E761124.8060402@colorfullife.com> <20030318001405.GS20188@holomorphy.com> <20030318004850.GT20188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318004850.GT20188@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 07:17:08PM +0100, Manfred Spraul wrote:
>>> Could you check if the attached test app triggers the NMI oopser?

On Mon, Mar 17, 2003 at 04:14:05PM -0800, William Lee Irwin III wrote:
>> Sure, no problem.

On Mon, Mar 17, 2003 at 04:48:50PM -0800, William Lee Irwin III wrote:
> Gee, this is bright. I think I remember why I haven't done testing of
> tasklist_lock NMI oopses for several releases now.
[...]
> timer doesn't work through the IO-APIC - disabling NMI Watchdog!
> ...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for unknown reason 35 on CPU 0.

NMI_LOCAL_APIC should not care whether the timer works through IO-APIC's.

--- linux-2.5.64/arch/i386/kernel/io_apic.c.orig	Mon Mar 17 17:19:02 2003
+++ linux-2.5.64/arch/i386/kernel/io_apic.c	Mon Mar 17 17:19:08 2003
@@ -1990,7 +1990,7 @@ static inline void check_timer(void)
 	}
 	printk(" failed.\n");
 
-	if (nmi_watchdog) {
+	if (nmi_watchdog == NMI_IO_APIC) {
 		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling NMI Watchdog!\n");
 		nmi_watchdog = 0;
 	}
