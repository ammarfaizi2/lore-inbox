Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292851AbSBVMeF>; Fri, 22 Feb 2002 07:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292852AbSBVMd4>; Fri, 22 Feb 2002 07:33:56 -0500
Received: from E0-IBE.r.miee.ru ([194.226.0.89]:22034 "EHLO ibe.miee.ru")
	by vger.kernel.org with ESMTP id <S292851AbSBVMdr>;
	Fri, 22 Feb 2002 07:33:47 -0500
From: Samium Gromoff <root@ibe.miee.ru>
Message-Id: <200202221524.g1MFOMk08048@ibe.miee.ru>
Subject: OOPS in 2.4.17-12f
To: riel@surriel.com
Date: Fri, 22 Feb 2002 18:24:22 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.1 on i586 2.4.17-rmap12e.  Options used                            
     -V (default)                                                               
     -k /proc/ksyms (default)                                                   
     -l /proc/modules (default)                                                 
     -o /lib/modules/2.4.17-rmap12e/ (default)                                  
     -m /boot/System.map (default)                                              
                                                                                
Warning: You did not tell me where to find symbol information.  I will          
assume that the log matches the kernel and modules that are running             
right now and I'll use the default options above for symbol resolution.         
If the current kernel and/or modules do not match the log, you can get          
more accurate output by telling me the kernel version and where to find         
map, modules, ksyms etc.  ksymoops -h explains the options.                     

<snip random modules failures>

Oops: 0002                                                                      
CPU:    0                                                                       
EIP:    0010:[<c0139484>]    Not tainted                                        
Using defaults from ksymoops -t elf32-i386 -a i386                              
EFLAGS: 00010246                                                                
eax: 00000000   ebx: c0fad740   ecx: c0fad740   edx: 00000800                   
esi: c0fad740   edi: c0fad740   ebp: 00000000   esp: c1731e20                   
ds: 0018   es: 0018   ss: 0018                                                  
Process cc1 (pid: 444, stackpage=c1731000)                                      
Stack: c013a1f8 c0fad740 c013bdc6 c0d515a0 c046d000 c0d515a0 00000000 c1076bac  
       00000000 c0c5e6c0 c0fad740 00001000 c013a2af c0fad740 c10141cc c046d000  
       0034cc00 00000001 c0132ced c10141cc 00000000 00000001 c10141cc 002a3000  
Call Trace: [<c013a1f8>] [<c013bdc6>] [<c013a2af>] [<c0132ced>] [<c013272a>]    
   [<c0125387>] [<c0138c69>] [<c0127f8c>] [<c011734d>] [<c011b449>] [<c31a319a>]
   [<c010841a>] [<c01085a8>] [<c011b5ef>] [<c0106fd3>]                          
Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 e9 5a ff ff ff 8d 76               
                                                                                
>>EIP; c0139484 <__remove_from_queues+14/30>   <=====                           
Trace; c013a1f8 <discard_buffer+78/90>                                          
Trace; c013bdc6 <try_to_free_buffers+c6/f0>                                     
Trace; c013a2af <discard_bh_page+3f/90>                                         
Trace; c0132ced <remove_exclusive_swap_page+6d/e0>                              
Trace; c013272a <free_page_and_swap_cache+2a/40>                                
Trace; c0125387 <zap_page_range+267/2c0>                                        
Trace; c0138c69 <fput+b9/e0>                                                    
Trace; c0127f8c <exit_mmap+bc/130>                                              
Trace; c011734d <mmput+2d/50>                                                   
Trace; c011b449 <do_exit+89/200>                                                
Trace; c31a319a <[sb_lib]sb_intr+aa/100>                                        
Trace; c010841a <handle_IRQ_event+3a/80>                                        
Trace; c01085a8 <do_IRQ+68/c0>                                                  
Trace; c011b5ef <sys_exit+f/10>                                                 
Trace; c0106fd3 <system_call+33/40>                                             
Code;  c0139484 <__remove_from_queues+14/30>                                    
00000000 <_EIP>:                                                                
Code;  c0139484 <__remove_from_queues+14/30>   <=====                           
   0:   89 02                     mov    %eax,(%edx)   <=====                   
Code;  c0139486 <__remove_from_queues+16/30>                                    
   2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)                        
Code;  c013948d <__remove_from_queues+1d/30>                                    
   9:   89 4c 24 04               mov    %ecx,0x4(%esp,1)                       
Code;  c0139491 <__remove_from_queues+21/30>                                    
   d:   e9 5a ff ff ff            jmp    ffffff6c <_EIP+0xffffff6c> c01393f0 <__
remove_from_lru_list+0/80>                                                      
Code;  c0139496 <__remove_from_queues+26/30>                                    
  12:   8d 76 00                  lea    0x0(%esi),%esi                         
                                                                                
                                                                                
11 warnings issued.  Results may not be reliable.                               

details: heavy VM load - two parallel builds on 40M ram

regards, Samium Gromoff
