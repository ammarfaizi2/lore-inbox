Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131195AbQLGXSe>; Thu, 7 Dec 2000 18:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130881AbQLGXSZ>; Thu, 7 Dec 2000 18:18:25 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:19730 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131195AbQLGXSO>;
	Thu, 7 Dec 2000 18:18:14 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: richardj_moore@uk.ibm.com
cc: Andi Kleen <ak@suse.de>, root@chaos.analogic.com,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate? 
In-Reply-To: Your message of "Thu, 07 Dec 2000 21:09:47 -0000."
             <802569AE.00747B7E.00@d06mta06.portsmouth.uk.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 09:47:42 +1100
Message-ID: <5464.976229262@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000 21:09:47 +0000, 
richardj_moore@uk.ibm.com wrote:
>In summary I'd say the lack of a task gate is at the very least an
>oversight, if not a bug.
>
>If no one else wants to do it I'll see if I can code up the task gates for
>the double-fault and NMI.

If you overflow the kernel stack then you have already scribbled on the
process state at the low end of the kernel stack pages.  The process is
definitely not recoverable but you might not even be able to recover
the machine.  Corrupt p_opptr and friends, thread_group or pidhash and
other processes can be affected when they follow the chains.  However
being able to report the error is a good start, even if you cannot
recover.

If you add task gates, assign enough stack space for debuggers.  kdb
does a lot of work when NMI detects a hung cpu and needs stack space to
do that work.  A good option is to dedicate a set of process entries
for per cpu task gates, say processes 2-NR_CPUS+1 are dedicated to task
gates.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
