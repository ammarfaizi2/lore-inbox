Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVJDJ2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVJDJ2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 05:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVJDJ2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 05:28:37 -0400
Received: from smtpa1.netcabo.pt ([212.113.174.16]:12209 "EHLO
	exch01smtp03.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751200AbVJDJ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 05:28:36 -0400
Message-ID: <43424B7C.9020508@rncbc.org>
Date: Tue, 04 Oct 2005 10:29:32 +0100
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: tsc_c3_compensate undefined since patch-2.6.13-rt13
References: <20050901072430.GA6213@elte.hu> <1125571335.15768.21.camel@localhost.localdomain> <20051003065032.GA23777@elte.hu>
In-Reply-To: <20051003065032.GA23777@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2005 09:28:24.0450 (UTC) FILETIME=[F7FB9620:01C5C8C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I'll take this late opportunity to report something that have been 
looking suspicious since 2.6.13-rt13, inclusive, about this symbol of 
tsc_c3_compensate being undefined and causing some noise on all kernel 
builds since then.

To put things in brief, here follows a small exchange that took place on 
the linux-audio-user list, regarding this thingie. Apparently for Mark, 
it was a kernel build showstopper.


Mark Knecht wrote:
 > Hi there,
 >   I have a newish AMD64 machine. NForce4 chipset. Asus A8N-E
 > motherboard. PCI-Express 16x graphics, etc. No matter what I try I've
 > been constantly stopped from building a 2.6.13 kernel with Ingo's rt14
 > patch.
 >
 > Here's the error message:
 >
 >  AS      arch/x86_64/lib/copy_user.o
 >   AS      arch/x86_64/lib/csum-copy.o
 >   CC      arch/x86_64/lib/csum-partial.o
 >   CC      arch/x86_64/lib/csum-wrappers.o
 >  CC      arch/x86_64/lib/dec_and_lock.o
 >  CC      arch/x86_64/lib/delay.o
 >   AS      arch/x86_64/lib/getuser.o
 >   AS      arch/x86_64/lib/putuser.o
 >  AS      arch/x86_64/lib/thunk.o
 >   CC      arch/x86_64/lib/usercopy.o
 >  AR      arch/x86_64/lib/lib.a
 >  GEN     .version
 >   CHK     include/linux/compile.h
 >   UPD     include/linux/compile.h
 >   CC      init/version.o
 >   LD      init/built-in.o
 >   LD      .tmp_vmlinux1
 > drivers/built-in.o(.text+0x24acc): In function `acpi_processor_idle':
 > : undefined reference to `tsc_c3_compensate'
 > make: *** [.tmp_vmlinux1] Error 1
 > lightning linux #
 >
 > The 2.6.13 kernel builds fine before I apply the patch but fails 
afterward.
 >
 > I do not find the error message
 >
 > undefined reference to `tsc_c3_compensate'
 >
 > in Google so maybe it's just me and my kernel config. I've attached
 > the config file zipped. I've tried some obvious stuff like completely
 > disabling ACPI, etc., but I haven't found anything that works yet.
 >
 > Thanks in advance for any ideas. This has held up my new AMD64 machine
 > being useful for a few weeks now.
 >

I'm spotting a very similar message when building 2.6.13.x-rt14, but as 
a module linkage warning, not a fatal build error.

Maybe that's because I try to configure _everything_ I can as a module, 
not as built-in. As this has been just a warning on the module install 
phase I got along and all seems to boot and run fine -- except for some 
acpi stuff e.g. I've lost thermal zone sensor on my laptop, but that 
didn't look like a big deal.

Yep, that's it... I found the exact messages in my attic, although from 
an erlier build:

WARNING: 
/lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/char/hangcheck-timer.ko 
needs unknown symbol do_monotonic_clock
WARNING: 
/lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/acpi/processor.ko needs 
unknown symbol tsc_c3_compensate


How about reporting to Ingo and/or the lkml? As you can see its not an 
AMD64 issue, because I don't have such a beast here.

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



