Return-Path: <linux-kernel-owner+w=401wt.eu-S1753545AbWLRIxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbWLRIxq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 03:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbWLRIxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 03:53:45 -0500
Received: from ara.aytolacoruna.es ([195.55.102.196]:55950 "EHLO
	mx.aytolacoruna.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbWLRIxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 03:53:45 -0500
X-Greylist: delayed 1768 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 03:53:44 EST
Date: Mon, 18 Dec 2006 09:24:13 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Cc: ebtables-devel@lists.sourceforge.net
Subject: ebtables problems on 2.6.19.1
Message-ID: <20061218082413.GA11064@clandestino.aytolacoruna.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When trying to upgrade a machine from 2.6.18 to 2.6.19.1 I found that it
crashed when loading the ebtables rules on startup.

This is an example of the crash I get:

BUG: unable to handle kernel paging request at virtual address e081e004         
 printing eip:                                                                  
c0283da0                                                                        
*pde = 1fbcb067                                                                 
*pte = 00000000                                                                 
Oops: 0000 [#1]                                                                 
CPU:    0                                                                       
EIP:    0060:[<c0283da0>]    Not tainted VLI                                    
EFLAGS: 00010282   (2.6.19.1 #1)                                                
EIP is at translate_table+0x600/0xe90                                           
eax: e081df98   ebx: 0000000e   ecx: e081df98   edx: e081df98                   
esi: 00000028   edi: dfb37cec   ebp: e081d000   esp: dfb37c30                   
ds: 007b   es: 007b   ss: 0068                                                  
Process ebtables (pid: 609, ti=dfb36000 task=c14d1550 task.ti=dfb36000)         
Stack: e081df4c 00000024 e081b000 dfb37cec 00000020 00000000 00000010 00000000  
       00000000 00000fc8 00000f98 e081df98 00000044 00000110 00000001 00000001  
       00000110 00000138 00000000 00000000 e081d000 e081df98 00000005 00000010  
Call Trace:                                                                     
 [<c0284daf>] do_ebt_set_ctl+0x28f/0x6b0                                        
 [<c013132f>] __alloc_pages+0x4f/0x2e0                                          
 [<c023ef9d>] nf_sockopt+0xad/0x100                                             
 [<c023f03e>] nf_setsockopt+0x1e/0x30                                           
 [<c024aeac>] ip_setsockopt+0x12c/0xc50                                         
 [<c010cb20>] do_page_fault+0x0/0x640                                           
 [<c028a7e9>] error_code+0x39/0x40                                              
 [<c0115888>] current_fs_time+0x48/0x60                                         
 [<c01564ad>] touch_atime+0x5d/0xb0                                             
 [<c012d535>] do_generic_mapping_read+0x385/0x490                               
 [<c012c9b0>] file_read_actor+0x0/0x100                                         
 [<c012f4d0>] generic_file_aio_read+0xf0/0x220                                  
 [<c013132f>] __alloc_pages+0x4f/0x2e0                                          
 [<c012f1dd>] filemap_nopage+0x14d/0x350                                        
 [<c013788d>] unmap_vmas+0x29d/0x480                                            
 [<c013850e>] __handle_mm_fault+0x53e/0x630                                     
 [<c0139205>] free_pgtables+0x85/0xb0                                           
 [<c0226db3>] sock_common_setsockopt+0x23/0x30                                  
 [<c0224f0f>] sys_setsockopt+0x5f/0xb0                                          
 [<c02267e9>] sys_socketcall+0x209/0x280                                        
 [<c010cb20>] do_page_fault+0x0/0x640                                           
 [<c0102c8f>] syscall_call+0x7/0xb                                              
 [<c028007b>] br_stp_change_bridge_id+0xb/0x1a0                                 
 =======================                                                        
Code: 17 0f 83 a2 03 00 00 8b 4c 24 08 8b 5c 24 28 8b 7c 24 0c 8b 69 24 01 eb 89
 5c 24 2c 8b 44 24 2c 8b 54 24 2c 8b 5f 20 8b 4c 24 2c <8b> 40 6c 89 44 24 44 8b
 52 68 89 54 24 40 8b 01 85 c0 0f 84 3a                                         
EIP: [<c0283da0>] translate_table+0x600/0xe90 SS:ESP 0068:dfb37c30              

I've tried to find a subset of the rules that are causing this and I found
that to be very difficult as I have only got this to fail if I load the
ebtables rules at boot time, if I try to load them after the machine is
completely booted it works ok. 2.6.18 still works ok, both kernels have the
"same" config where posible and they are not SMP.

The machine that was having the failure was a PIII 1GHz, I have copied the
filesystem to a PIV 1.6Ghz where it also fails and where I can do tests and
access the console via serial port.

The machine is not being used as a brouter but only as a bridge firewall, it
has some ebtables rules to cut non IP stuff and then does all the work at
iptables level.

I don't know what other info to add here, tell me if you need any other
stuff to diagnose this or any testing here.

Regards...
-- 
Santiago García Mantiñán
