Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbQLHRHn>; Fri, 8 Dec 2000 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132356AbQLHRHe>; Fri, 8 Dec 2000 12:07:34 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:34229 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S132355AbQLHRHP>; Fri, 8 Dec 2000 12:07:15 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: root@chaos.analogic.com
cc: Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Message-ID: <802569AF.005B3839.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 8 Dec 2000 16:34:52 +0000
Subject: Re: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Actually what you are pointing out here is the differing needs for
differing uses. Real-time, embedded systems etc have different requirements
or at lest different priorities to enterprise usage. I'm coming from the
enterprise server angle - the Linux/390 type of use and high end IA32
Server.

I'll certainly add the double-fault hander to my list of RAS stuff. I'm not
so convinced about NMI being a task gate.

Richard


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


"Richard B. Johnson" <root@chaos.analogic.com> on 08/12/2000 15:04:19

Please respond to root@chaos.analogic.com

To:   Richard J Moore/UK/IBM@IBMGB
cc:
Subject:  Re: Why is double_fault serviced by a trap gate?




On Fri, 8 Dec 2000 richardj_moore@uk.ibm.com wrote:

>
>
> I really think you're taking very negative position - I have seen this
> technique deployed on onther Intel based operating systems. I don't see
why
> Linux shouldn't step up to that. If one is careful the double-fault can
be
> handled to the extent that other kernel services (or a subset of them)
are
> callable and we may be even take a crash dump. I agree that the current
> thread will die and possibly the system will may have to be closed down.
>
>
> Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).
>

If you have a "survival patch" for some recent kernel, or if you
develop one, I will certainly try to help getting it to work. However,
I have been in the "been there, done that.." position trying to
keep a critical system (CAT Scanner) up long enough to complete
a scan after a HV Arc caused bad things to happen (a few single-bit
errors in memory). And I didn't have to worry about all the tasks
that exist in a desktop OS. My OS for the scanner had tasks that were
known at compile-time!

The solution found was checkpointed task code (for restarting where
it left off), and restarting the kernel by:

o    Get paging OFF
o    Fix up a temporary flat-mode environment.
o    Get new kernel code from NVRAM.
o    Reload/restart kernel
o    Start tasks.

What I learned might be helpful.

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
