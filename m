Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSA3Un5>; Wed, 30 Jan 2002 15:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290586AbSA3Unr>; Wed, 30 Jan 2002 15:43:47 -0500
Received: from mta22-acc.tin.it ([212.216.176.75]:5822 "EHLO fep22-svc.tin.it")
	by vger.kernel.org with ESMTP id <S290575AbSA3Ung>;
	Wed, 30 Jan 2002 15:43:36 -0500
Message-ID: <3C585B2B.A22569C8@iname.com>
Date: Wed, 30 Jan 2002 21:44:27 +0100
From: Luca Montecchiani <m.luca@iname.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: marcelo@conectiva.com.br
Subject: [oops] 2.4.18-pre7 vm/fs related oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've getting this oops extracting with dd small block
of data ( 4mbytes ) from a large file ( 1.5 gbytes )
this is on a vanilla 2.4.18-pre7 with ext2 without any 
esoteric patch.
The only way to read the entire file is to disable the
swap with swapoff -a.
I've 128Mytes + 256 of swap.

PS: I've just get the same oops with 2.4.18pre2-ide.

too bad :(

ksymoops 2.4.1 on i586 2.4.18-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b819>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 0000004c   ebx: c02625a0   ecx: c0262588   edx: 000055af
esi: c1156bc0   edi: 00000000   ebp: 00000001   esp: c51c5e90
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 2242, stackpage=c51c5000)
Stack: c02626fc 000000e1 00000000 000000e0 000045af 00000286 00000000 c0262588
       c012ba6b 000001d2 c6b74eb0 0001332b c125e834 c0262588 c02626f8 000001d2
       c01517ec c012b860 0000000f c0124daa 0000001c c6632ae0 0001330f 00000020
Call Trace: [<c012ba6b>] [<c01517ec>] [<c012b860>] [<c0124daa>] [<c0125343>]
   [<c0125598>] [<c0125afa>] [<c0125a1c>] [<c0130266>] [<c0106bf3>]
Code: 0f 0b 8b 46 18 a8 80 74 02 0f 0b 89 f0 eb 18 47 83 c5 0c 83

>>EIP; c012b819 <rmqueue+17d/1ac>   <=====
Trace; c012ba6b <__alloc_pages+a7/15c>
Trace; c01517ec <ext2_get_block+0/3fc>
Trace; c012b860 <_alloc_pages+18/1c>
Trace; c0124daa <page_cache_read+72/c0>
Trace; c0125343 <generic_file_readahead+10b/148>
Trace; c0125598 <do_generic_file_read+1e8/420>
Trace; c0125afa <generic_file_read+7e/190>
Trace; c0125a1c <file_read_actor+0/60>
Trace; c0130266 <sys_read+8e/c4>                                                                
Trace; c0106bf3 <system_call+33/40>                                                             
Code;  c012b819 <rmqueue+17d/1ac>                                                               
00000000 <_EIP>:                                                                                
Code;  c012b819 <rmqueue+17d/1ac>   <=====                                                      
   0:   0f 0b                     ud2a      <=====                                              
Code;  c012b81b <rmqueue+17f/1ac>                                                               
   2:   8b 46 18                  mov    0x18(%esi),%eax                                        
Code;  c012b81e <rmqueue+182/1ac>                                                               
   5:   a8 80                     test   $0x80,%al                                              
Code;  c012b820 <rmqueue+184/1ac>                                                               
   7:   74 02                     je     b <_EIP+0xb> c012b824 <rmqueue+188/1ac>                
Code;  c012b822 <rmqueue+186/1ac>                                                               
   9:   0f 0b                     ud2a                                                          
Code;  c012b824 <rmqueue+188/1ac>                                                               
   b:   89 f0                     mov    %esi,%eax                                              
Code;  c012b826 <rmqueue+18a/1ac>                                                               
   d:   eb 18                     jmp    27 <_EIP+0x27> c012b840 <rmqueue+1a4/1ac>              
Code;  c012b828 <rmqueue+18c/1ac>                                                               
   f:   47                        inc    %edi                                                   
Code;  c012b829 <rmqueue+18d/1ac>                                                               
  10:   83 c5 0c                  add    $0xc,%ebp                                              
Code;  c012b82c <rmqueue+190/1ac>                                                               
  13:   83 00 00                  addl   $0x0,(%eax)                                            
                                                                                                
                                                                                                
1 warning issued.  Results may not be reliable.    
-- 
----------------------------------------------------------
Luca Montecchiani <m.luca@iname.com>          ICQ:17655604
http://www.geocities.com/montecchiani
Registered Linux user # 255707
-------------------=(Linux since 1995)=-------------------
