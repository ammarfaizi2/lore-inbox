Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbQLGWPT>; Thu, 7 Dec 2000 17:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbQLGWPJ>; Thu, 7 Dec 2000 17:15:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8832 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129453AbQLGWOw>; Thu, 7 Dec 2000 17:14:52 -0500
Date: Thu, 7 Dec 2000 16:44:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: richardj_moore@uk.ibm.com
cc: Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <802569AE.00747B7E.00@d06mta06.portsmouth.uk.ibm.com>
Message-ID: <Pine.LNX.3.95.1001207163133.3136A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000 richardj_moore@uk.ibm.com wrote:

> 
> 
> Which surely we can on today's x86 systems. Even back in the days of OS/2
> 2.0 running on a 386 with 4Mb RAM we used a taskgate for both NMI and
> Double Fault. You need only a minimal stack - 1K, sufficient to save state
> and restore ESP to a known point before switching back to the main TSS to
> allow normal exception handling to occur.
> 
> There no architectural restriction that some folks have hinted at - as long
> as the DPL for the task gates is 3.
> 
[SNIPPED...]

Please refer to page 6-16, Inter486 Microprocessor Family Programmer's
Reference Manual.

The specifc text is: "The TSS does not have a stack pointer for a
privilege level 3 stack, because the procedure cannot be called by a less
privileged procedure. The stack for privilege level 3 is preserved by the
contents of SS and EIP registers which have been saved on the stack
of the privilege level called from level 3".

What this means is that a stack-fault in level 3 will kill you no
matter how cute you try to be. And, putting a task gate as call
procedure entry from a trap or fault is just trying to be cute.
It's extra code that will result in the same processor reset.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
