Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132248AbQLHXFk>; Fri, 8 Dec 2000 18:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132366AbQLHXFa>; Fri, 8 Dec 2000 18:05:30 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:39944 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132248AbQLHXFW>;
	Fri, 8 Dec 2000 18:05:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: richardj_moore@uk.ibm.com, Brian Gerst <bgerst@didntduck.org>,
        Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate? 
In-Reply-To: Your message of "Fri, 08 Dec 2000 07:58:06 CDT."
             <Pine.LNX.3.95.1001208075103.10812A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Dec 2000 09:34:49 +1100
Message-ID: <5114.976314889@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
