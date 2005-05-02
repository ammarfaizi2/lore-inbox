Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVEBQxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVEBQxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVEBQvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:51:01 -0400
Received: from one.firstfloor.org ([213.235.205.2]:48355 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261483AbVEBQtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:49:16 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86_64] how worried should I be about MCEs?
References: <4273E7B1.6020500@myrealbox.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 02 May 2005 18:49:12 +0200
In-Reply-To: <4273E7B1.6020500@myrealbox.com> (Andy Lutomirski's message of
 "Sat, 30 Apr 2005 13:16:49 -0700")
Message-ID: <m1d5s9y3nb.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> Every now and then, after rebooting, the kernel notices some
> MCEs. Should I be worried about this?


>
> (mcelog attached)
>
> Thanks,
> Andy
>
>
> MCE 0
> CPU 0 0 data cache from boot or resume
> ADDR 480b0c84df48
>    Data cache ECC error (syndrome c8)

These are harmless. I have one machine that generates them too.
I think they happen because the BIOS either does something
incorrectly while booting the POSting the CPU or these are
expected and it forgets to clear them. Only a few BIOS
seem to do it, so it is probably a BIOS bug. 

You see them because the MCE code logs boot MCEs now.
That is because it is the only way to log MCEs that 
cause the system to reboot is to log them after the reboot.

Some of the bit combinations are clearly non sensical, like
corrected ECC error with error uncorrected and the Address
is bogus.

I have been pondering to add some filter to remove
these bogus MCEs, but I have not come up with 
a good heuristic yet. Perhaps ignore all MCEs at resume
with addresses that are beyond the physical memory.
But that would not have caught the last one.

-Andi

[intentional full quote for Mark]

>         bit46 = corrected ecc error
>         bit57 = processor context corrupt
>         bit61 = error uncorrected
>         bit62 = error overflow (multiple errors)
> STATUS f66440000000438d MCGSTATUS 0
> MCE 1
> CPU 0 1 instruction cache from boot or resume
> ADDR 75e2bb87ec57f8e0
>    Instruction cache ECC error
>         bit32 = err cpu0
>         bit33 = err cpu1
>         bit35 = res3
>         bit43 = res11
>         bit45 = uncorrected ecc error
>         bit46 = corrected ecc error
>         bit55 = res23
>         bit56 = res24
>         bit57 = processor context corrupt
>         bit59 = misc error valid
>         bit61 = error uncorrected
>         bit62 = error overflow (multiple errors)
> STATUS ffe4681bd0e45d81 MCGSTATUS 0
> MCE 2
> CPU 0 3 load/store unit from boot or resume
> MISC 8005003b8005003b
>         bit57 = processor context corrupt
>         bit59 = misc error valid
>         bit61 = error uncorrected
>         bit62 = error overflow (multiple errors)
> STATUS fa0000000000d0c5 MCGSTATUS 0
> MCE 3
> CPU 0 4 northbridge from boot or resume
> ADDR 102000020
>    Northbridge ECC error
>    ECC syndrome = 0
>         bit32 = err cpu0
>         bit33 = err cpu1
>         bit40 = error found by scrub
>         bit45 = uncorrected ecc error
>         bit57 = processor context corrupt
>         bit61 = error uncorrected
> STATUS b600215300001e0f MCGSTATUS 0
