Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSHPHRN>; Fri, 16 Aug 2002 03:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSHPHRN>; Fri, 16 Aug 2002 03:17:13 -0400
Received: from web12407.mail.yahoo.com ([216.136.173.134]:21521 "HELO
	web12407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318237AbSHPHRM>; Fri, 16 Aug 2002 03:17:12 -0400
Message-ID: <20020816072109.53259.qmail@web12407.mail.yahoo.com>
Date: Fri, 16 Aug 2002 00:21:09 -0700 (PDT)
From: Amol Lad <dal_loma@yahoo.com>
Subject: SMP boot query
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Lets assume, boot processor has done all its
initialization and is booting the second processor. 
In do_boot_cpu(), it calls fork_by_hand() and creates
an idle task for cpu#2 . 
It then iniliazes all relevant fields of 'idle' task
for cpu#2.
It also does following
start_eip = setup_trampoline();
stack_start.esp = (void *) (1024 + PAGE_SIZE + (char
*)idle);

After doing lot of APIC related stuff, it sends
Startup IPI to cpu#2 to start booting from start_eip .


cpu#2, from trampoline code jumps to startup_32 and
from there to initialize_secondary. 

initialize_secondary is

        asm volatile(
                "movl %0,%%esp\n\t"
                "jmp *%1"
                :
                :"r" (current->thread.esp),"r"
(current->thread.eip));

Now my questions
1] what is trampoline ?
2] I did not understood, how 'current' above is set to
  new idle task created in fork_by_hand (is some magic
done in start_stack.esp ?? )

-- Amol



__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
