Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132550AbRCZTXd>; Mon, 26 Mar 2001 14:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRCZTXX>; Mon, 26 Mar 2001 14:23:23 -0500
Received: from f67.law14.hotmail.com ([64.4.21.67]:51974 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S132550AbRCZTXM>;
	Mon, 26 Mar 2001 14:23:12 -0500
X-Originating-IP: [12.44.186.158]
From: "Dinesh Nagpure" <fatbrrain@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: hooking APIC timer doesnt work?
Date: Mon, 26 Mar 2001 11:22:26 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F67E8NpqhNPPzQT456U0000bad6@hotmail.com>
X-OriginalArrivalTime: 26 Mar 2001 19:22:26.0500 (UTC) FILETIME=[17781040:01C0B62A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I am trying to use the LAPIC timer to generate interrupt for some kernel 
profiling work I am doing...but the timer ISR isnt invoking atall....here is 
what I have done....
1)Initialized a interrupt gate  modifying the trap_init function in traps.c 
to use vector 0x32
        set_intr_gate(0x32,&inthtooltimer);

2) Added a handler in entry.s

ENTRY(inthtooltimer)
        pushl %eax
        SAVE_ALL
        movl %esp,%edx
        pushl $0
        pushl %edx
        call SYMBOL_NAME(do_inthtooltimer)
        addl $8,%esp
        RESTORE_ALL

3) Added a high level C function do_inthtooltimer in traps.c with all proper 
asmlinkage declerations and all

4) In my driver module I initialize the LAPIC timer register for
ONE_SHOT, NOT_MASKED, VECTOR32 and SEND_PENDING as given in the intel 
architecture manual and also set the divide config register to divide by 
1....and the initial count register is also set...

Problem is my timer handler isnt getting called atall...

I am disabling the SMP support and APIC support options in menuconfig

I assume rest of the APIC initialization is done properly because I am 
instrumenting the APIC Performance Counter interrupt also for delivery mode 
NMI and it seems to be getting called properly as I see /proc/interrupts 
showing increment in NMI count..

Am i missing out something...
Thanks
Dinesh
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

