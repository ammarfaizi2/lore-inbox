Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbSJCWjj>; Thu, 3 Oct 2002 18:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSJCWjh>; Thu, 3 Oct 2002 18:39:37 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:5116 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261319AbSJCWjW>; Thu, 3 Oct 2002 18:39:22 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.51284.271547.70818@wombat.chubb.wattle.id.au>
Date: Fri, 4 Oct 2002 08:44:36 +1000
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Large Block Device patch part 5/4
CC: linux-kernel@vger.kernel.org
In-Reply-To: <453386441@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:

Russell> On Thu, Oct 03, 2002 at 03:49:33PM +1000,
Russell> peterc@gelato.unsw.edu.au wrote:
>> +#ifdef CONFIG_LBD extern u64 __udivdi3(u64, u64); extern u64
>> __umoddi3(u64, u64); +EXPORT_SYMBOL(__udivdi3);
>> +EXPORT_SYMBOL(__umoddi3); +#endif EXPORT_SYMBOL(md_size);
>> EXPORT_SYMBOL(register_md_personality);
>> EXPORT_SYMBOL(unregister_md_personality); @@ -3493,6 +3497,4 @@
>> EXPORT_SYMBOL(md_wakeup_thread); EXPORT_SYMBOL(md_print_devices);
>> EXPORT_SYMBOL(md_interrupt_thread); -EXPORT_SYMBOL(__udivdi3);
>> -EXPORT_SYMBOL(__umoddi3); MODULE_LICENSE("GPL");

Russell> These exports should be performed by the architecture not by
Russell> generic drivers.


1.  CONFIG_LBD is defined only for IA32 and PPC32.
2.  The exports are temporary until other stuff in the RAID code is
cleaned up.
3.  They're only used by the RAID code, and would be the same for all
architectures that use gcc, assuming that CONFIG_LBD were to be turned
on for those architectures.

Russell> Please move them into all architectures.

I'd rather remove them entirely, and am working on that.  In the
meantime, they'll stay (probably until Neil Brown gets back from
holiday next week and can help with my RAID problems)

Peter C
