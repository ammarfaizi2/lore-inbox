Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbQKGWmY>; Tue, 7 Nov 2000 17:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129698AbQKGWmP>; Tue, 7 Nov 2000 17:42:15 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:20233 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129624AbQKGWmA>;
	Tue, 7 Nov 2000 17:42:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP 
In-Reply-To: Your message of "Tue, 07 Nov 2000 17:31:19 CDT."
             <Pine.LNX.3.95.1001107172159.198A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 09:41:54 +1100
Message-ID: <17401.973636914@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000 17:31:19 -0500 (EST), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>Also, I get some CPU watchdog timeout that I didn't ask for Grrr...
>
>Nov  7 17:17:54 chaos nmbd[115]:   Samba server CHAOS is now a domain master browser for workgroup LINUX on subnet 204.178.40.224 
>Nov  7 17:17:54 chaos nmbd[115]:    
>Nov  7 17:17:54 chaos nmbd[115]:   ***** 
>Nov  7 17:18:54 chaos kernel: NMI Watchdog detected LOCKUP on CPU0, registers: 
>Nov  7 17:18:54 chaos kernel: CPU:    0 
>Nov  7 17:19:01 chaos login: ROOT LOGIN ON tty2

Which means that one of the cpus is spinning for 5 seconds with
interrupts disabled.  CPU watchdogs are *good*.

>
>           CPU0       CPU1       
>  0:      10945      11869    IO-APIC-edge  timer
>  1:        419        393    IO-APIC-edge  keyboard
>  2:          0          0          XT-PIC  cascade
>  8:          0          0    IO-APIC-edge  rtc
> 10:       2990       2904   IO-APIC-level  eth0
> 11:       1066       1124   IO-APIC-level  BusLogic BT-958
> 13:          0          0          XT-PIC  fpu
>NMI:      22748      22748 
>LOC:      21731      22229 
>ERR:          0
>
>
>The NMI and LOC (timers) run faster than timer channel 0. This
>cannot be correct. Anybody know what this is and how to get
>rid of these CPU time stealers?

The timer is directed both as a normal interrupt 0 and as a broadcast
non maskable interrupt.  The NMI count on each cpu should be roughly
the sum of the interrupt 0 count across all cpus.

The NMI path is fairly fast so the overhead is small.  When it does
trip you have a problem, a cpu is spinning for far too long.  Extract
the NMI report from the log, run it through ksymoops and mail the
decoded result.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
