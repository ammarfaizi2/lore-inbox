Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbRAIXdI>; Tue, 9 Jan 2001 18:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130346AbRAIXc5>; Tue, 9 Jan 2001 18:32:57 -0500
Received: from ns.sysgo.de ([213.68.67.98]:2552 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S130177AbRAIXcl>;
	Tue, 9 Jan 2001 18:32:41 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: ttabi@interactivesi.com
Date: Tue, 9 Jan 2001 23:57:52 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01011000323301.03050@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In article <20010109224454Z129835-400+2448@vger.kernel.org>,
	ttabi@interactivesi.com (Timur Tabi) writes:
> ** Reply to message from Robert Kaiser <rob@sysgo.de> on Tue, 9 Jan 2001
> 23:17:11 +0100
> 
> 
>> temp = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
>> 	*pte = temp;
>> 
>> where temp is declared "volatile pte_t". I inserted test-prints between the
>> above two lines. Accoding to that, the _first_ line , i.e. the evaluation of the
>> mk_pte_phys() macro is causing the crash!
> 
> In that case, it's either a compiler bug or a race condition.
> 
> Compiling this source file with the -S option will generate an assembly output.
> The output should be the same regardless of whether you use the temp variable or
> not.  That will answer the question as to what the cause is.  If you're lucky,
> it's a compiler bug, because they're easier to fix.
> 
> 
I thought that by declaring temp "volatile" I could force the compiler to not
optimize it away, i.e. make sure that the evaluation of the mk_pte_phys()
macro and the assignment to *pte indeed get seperated. Is this not the case ?

Anyway, the actual code I'm using has debug output in between the lines, so it
looks more like this:

	*((volatile unsigned char*)0xb8000) = '1';
	temp = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
	*((volatile unsigned char*)0xb8000) = '2';
	*pte = temp;
	*((volatile unsigned char*)0xb8000) = '3';

When the system crashes, just before the BIOS clears the screen, I can clearly
see a '2' in the upper left corner of the screen.

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
