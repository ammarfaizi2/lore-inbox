Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTFFXqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTFFXol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:44:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54405 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262371AbTFFXoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:44:25 -0400
Date: Fri, 06 Jun 2003 16:46:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 781] New: NMI watchdog lockup on reboot 
Message-ID: <35020000.1054943214@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



http://bugme.osdl.org/show_bug.cgi?id=781

           Summary: NMI watchdog lockup on reboot
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: ak@suse.de
         Submitter: johnstul@us.ibm.com


Distribution:  SLES8 AMD64 
Hardware Environment: Dual-proc AMD64 melody box.  
Software Environment: 2.5.70 
Problem Description: 
Frequently when rebooting 2.5.70, the NMI Watchdog fires reporting the following: 
 
NMI Watchdog detected LOCKUP on CPU0, registers: 
CPU 0                                            
Pid: 0, comm: swapper Not tainted 
RIP: 0010:[<ffffffff8011bbc2>] <ffffffff8011bbc2>{.text.lock.smp+25} 
RSP: 0018:ffffffff80494ac8  EFLAGS: 00000086                         
RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000000 
RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffffff8011ba00 
RBP: ffffffff8010f8b0 R08: 0000000000000001 R09: 0000000000009400 
R10: 0000000000000001 R11: ffffffff804951c0 R12: 0000000000000000 
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000 
FS:  0000000000000000(0000) GS:ffffffff80490780(0000) knlGS:0000000000000000 
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b                            
CR2: 0000002a9556a000 CR3: 0000000000101000 CR4: 00000000000006a0 
                                                                  
Call Trace: <EOE> <IRQ> <ffffffff8011ba00>{stop_this_cpu+0} 
<ffffffff8011ba49>{smp_send_stop+25}  
       <ffffffff80118af9>{machine_restart+9} <ffffffff8010f8b0>{default_idle+0}  
       <ffffffff8011bab0>{smp_call_function_interrupt+64}                       
       <ffffffff8010f8b0>{default_idle+0} <ffffffff80112023>{call_function_interrupt+99}  
        <EOI> <ffffffff801320b0>{thread_return+0} <ffffffff8010f8d7>{default_idle+39}  
       <ffffffff8010f8b0>{default_idle+0} <ffffffff8010f972>{cpu_idle+34}  
       <ffffffff804a7862>{start_kernel+418}                                
Process swapper (pid: 0, stackpage=ffffffff803d6e20) 
Stack: ffffffff8011ba00 0000000000000000 ffffffff00000000 0000000000000000  
       0000000000000001 ffffffff8011ba49 00000000fffffffd ffffffff80118af9  
       0000000000000000 ffffffff8010f8b0                                    
Call Trace:<IRQ> <ffffffff8011ba00>{stop_this_cpu+0} 
<ffffffff8011ba49>{smp_send_stop+25}  
       <ffffffff80118af9>{machine_restart+9} <ffffffff8010f8b0>{default_idle+0}  
       <ffffffff8011bab0>{smp_call_function_interrupt+64}                       
       <ffffffff8010f8b0>{default_idle+0} <ffffffff80112023>{call_function_interrupt+99}  
        <EOI> <ffffffff801320b0>{thread_return+0} <ffffffff8010f8d7>{default_idle+39}  
       <ffffffff8010f8b0>{default_idle+0} <ffffffff8010f972>{cpu_idle+34}  
       <ffffffff804a7862>{start_kernel+418}                                
                                             
Code: 7e f5 e9 53 fd ff ff 66 66 66 90 66 66 66 48 83 ec 08 be e8  
console shuts up ...                                               
                     
Disabling the nmi watchdog results in a silent hang rather then the watchdog report.  
 
This problem has also been reported by Bryan O'Sullivan on discuss@x86-64.org.  
 
Steps to reproduce: 
1. Boot w/ 2.5.70 
2. /sbin/init 6  and repeat until it occurs.

