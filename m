Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLGXff>; Thu, 7 Dec 2000 18:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLGXf0>; Thu, 7 Dec 2000 18:35:26 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:34475 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S129267AbQLGXfR>; Thu, 7 Dec 2000 18:35:17 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: root@chaos.analogic.com
cc: Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Message-ID: <802569AE.007EC129.00@d06mta06.portsmouth.uk.ibm.com>
Date: Thu, 7 Dec 2000 23:03:40 +0000
Subject: Re: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You seem to be misunderstanding the point of the argument: R3 stack fault -
no problem - handled by trap gate for idt vector 12 - recovery is possible
if one wants to handle it. R0 stack fault - big problem, exception 12 is
converted to a double-fault, which is converted to a triple-fault because
vector 8 is a trap gate and not a task gate.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


"Richard B. Johnson" <root@chaos.analogic.com> on 07/12/2000 21:44:23

Please respond to root@chaos.analogic.com

To:   Richard J Moore/UK/IBM@IBMGB
cc:   Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
      linux-kernel@vger.kernel.org
Subject:  Re: Why is double_fault serviced by a trap gate?




On Thu, 7 Dec 2000 richardj_moore@uk.ibm.com wrote:

>
>
> Which surely we can on today's x86 systems. Even back in the days of OS/2
> 2.0 running on a 386 with 4Mb RAM we used a taskgate for both NMI and
> Double Fault. You need only a minimal stack - 1K, sufficient to save
state
> and restore ESP to a known point before switching back to the main TSS to
> allow normal exception handling to occur.
>
> There no architectural restriction that some folks have hinted at - as
long
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



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
