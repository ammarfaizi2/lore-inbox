Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131760AbQLJAVz>; Sat, 9 Dec 2000 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132132AbQLJAVf>; Sat, 9 Dec 2000 19:21:35 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:30605 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S131760AbQLJAV1>; Sat, 9 Dec 2000 19:21:27 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Keith Owens <kaos@ocs.com.au>
cc: root@chaos.analogic.com, Brian Gerst <bgerst@didntduck.org>,
        Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Message-ID: <802569B0.0082FA4C.00@d06mta06.portsmouth.uk.ibm.com>
Date: Sat, 9 Dec 2000 23:46:34 +0000
Subject: Re: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I agree, I've changed my mind about the use of a task gate for NMI - Intel
recommend an interrupt gate for a very good reason - NMI's are queued until
the IRET so using an interrup gate for NMI (and keeping interrupts
disabled) will guarantee that NMIs are handled serially.

I think our use of a trap gate for NMI in OS/2 was probably not the best
idea.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Keith Owens <kaos@ocs.com.au> on 08/12/2000 22:34:49

Please respond to Keith Owens <kaos@ocs.com.au>

To:   root@chaos.analogic.com
cc:   Richard J Moore/UK/IBM@IBMGB, Brian Gerst <bgerst@didntduck.org>,
      Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
      linux-kernel@vger.kernel.org
Subject:  Re: Why is double_fault serviced by a trap gate?




On Fri, 8 Dec 2000 07:58:06 -0500 (EST),
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>Too many people just want to argue without even reading what they
>are arguing against. Again, I implied nothing. I said;
>
> (1) User traps, CPL3, stack for trap is in CPL0.
> (2) CPL0 has stack-fault (bad ring zero code, bad memory).
> (3) CPL0 traps, using faulted stack, double fault.
> (4) There is no stack-trick, including a call-gate  to another
>  "environment" (complete with its previously-reserved stack),
>  that will ever get you back to (2), much less to (1).

Nobody thinks that a stack overflow is recoverable - for that process.
By the time you overflow, the struct task at the bottom of the kernel
stack has been overwritten so the process is dead, gone to make its
maker, it is pushing up daisies.  The rest of the system may or may not
recover, depending on the resources that the dead process is still
holding and the links between processes.

Changing the stack overflow to a trap gate will give us diagnostics on
the failing task instead of an immediate triple fault and reboot.
Diagnostics are useful.  If the system can recover afterwards then that
is a bonus but it is not guaranteed.  The process is always unrecoverable.

I am not convinced that using a trap gate for NMI is a good idea, the
NMI watchdog kicks in too often for my liking.  Using a trap gate for a
debugger would be worthwhile, I have always been worried about the
amount of stack that kdb uses.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
