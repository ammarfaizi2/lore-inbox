Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264897AbSJWMMf>; Wed, 23 Oct 2002 08:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSJWMMf>; Wed, 23 Oct 2002 08:12:35 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:29896 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S264897AbSJWMM2> convert rfc822-to-8bit; Wed, 23 Oct 2002 08:12:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Wed, 23 Oct 2002 22:27:47 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021018145204.GG23930@dualathlon.random> <200210222048.05592.harisri@bigpond.com> <20021022145528.GW19337@dualathlon.random>
In-Reply-To: <20021022145528.GW19337@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210232227.47721.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Wednesday 23 October 2002 00:55, Andrea Arcangeli wrote:
> something like this will apply cleanly, if every patch is self contained
> as it should, it will compile correctly too:
>
> 	rm ../2.4.20pre11aa1/*.bz2
> 	gzip -d ../2.4.20pre11aa1/*.gz
> 	for i in ../2.4.20pre11aa1/[0123]*; patch -p1 < $i; done

Thanks that is neat.

I was able to trigger few oops with [0123]* patches.

ksymoops 2.4.5 on i686 2.4.20-pre11aa1-0123.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre11aa1-0123/ (default)
     -m /boot/System.map-2.4.20-pre11aa1-0123 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 23 21:23:22 localhost kernel: Unable to handle kernel paging request at 
virtual address c463b440
Oct 23 21:23:22 localhost kernel: c01485d1
Oct 23 21:23:22 localhost kernel: *pde = 045fe163
Oct 23 21:23:22 localhost kernel: Oops: 0003
Oct 23 21:23:22 localhost kernel: CPU:    0
Oct 23 21:23:22 localhost kernel: EIP:    0010:[<c01485d1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 23 21:23:22 localhost kernel: EFLAGS: 00010282
Oct 23 21:23:22 localhost kernel: eax: c463b440   ebx: c463b440   ecx: 
c5938080   edx: 00000296
Oct 23 21:23:22 localhost kernel: esi: c6a6f6c8   edi: c6a6f680   ebp: 
00000001   esp: c85d1f18
Oct 23 21:23:22 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 23 21:23:22 localhost kernel: Process bonobo-activati (pid: 795, 
stackpage=c85d1000)
Oct 23 21:23:22 localhost kernel: Stack: c01a492d c158f2dc 00000000 c6a6f6c8 
c01de68b c463b440 00000000 00000217 
Oct 23 21:23:22 localhost kernel:        c158e480 c463b440 c5706b50 c158e200 
c5706a40 c6cf4140 c01de987 c6a6f680 
Oct 23 21:23:22 localhost kernel:        00000000 c01a236c c5706b50 c5706a40 
c01a2949 c5706b50 c641f3c0 00000000 
Oct 23 21:23:22 localhost kernel: Call Trace:    [<c01a492d>] [<c01de68b>] 
[<c01de987>] [<c01a236c>] [<c01a2949>]
Oct 23 21:23:22 localhost kernel:   [<c0136782>] [<c0134e6d>] [<c0134eee>] 
[<c010737f>]
Oct 23 21:23:22 localhost kernel: Code: ff 0b 0f 94 c0 84 c0 0f 84 8f 00 00 00 
8d 73 18 39 73 18 74 


>>EIP; c01485d1 <dput+11/110>   <=====

>>eax; c463b440 <END_OF_CODE+66e505/????>
>>ebx; c463b440 <END_OF_CODE+66e505/????>
>>ecx; c5938080 <END_OF_CODE+196b145/????>
>>esi; c6a6f6c8 <END_OF_CODE+2aa278d/????>
>>edi; c6a6f680 <END_OF_CODE+2aa2745/????>
>>esp; c85d1f18 <END_OF_CODE+4604fdd/????>

Trace; c01a492d <sk_free+2d/60>
Trace; c01de68b <unix_release_sock+11b/1d0>
Trace; c01de987 <unix_release+27/30>
Trace; c01a236c <sock_release+5c/60>
Trace; c01a2949 <sock_close+39/60>
Trace; c0136782 <fput+102/130>
Trace; c0134e6d <filp_close+4d/80>
Trace; c0134eee <sys_close+4e/60>
Trace; c010737f <system_call+33/38>

Code;  c01485d1 <dput+11/110>
00000000 <_EIP>:
Code;  c01485d1 <dput+11/110>   <=====
   0:   ff 0b                     decl   (%ebx)   <=====
Code;  c01485d3 <dput+13/110>
   2:   0f 94 c0                  sete   %al
Code;  c01485d6 <dput+16/110>
   5:   84 c0                     test   %al,%al
Code;  c01485d8 <dput+18/110>
   7:   0f 84 8f 00 00 00         je     9c <_EIP+0x9c>
Code;  c01485de <dput+1e/110>
   d:   8d 73 18                  lea    0x18(%ebx),%esi
Code;  c01485e1 <dput+21/110>
  10:   39 73 18                  cmp    %esi,0x18(%ebx)
Code;  c01485e4 <dput+24/110>
  13:   74 00                     je     15 <_EIP+0x15>

Oct 23 21:23:22 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c4c6a360
Oct 23 21:23:22 localhost kernel: c0137103
Oct 23 21:23:22 localhost kernel: *pde = 04c001e3
Oct 23 21:23:22 localhost kernel: Oops: 0002
Oct 23 21:23:22 localhost kernel: CPU:    0
Oct 23 21:23:22 localhost kernel: EIP:    0010:[<c0137103>]    Not tainted
Oct 23 21:23:22 localhost kernel: EFLAGS: 00013286
Oct 23 21:23:22 localhost kernel: eax: c4c6a340   ebx: 00000000   ecx: 
c916b940   edx: c025ec44
Oct 23 21:23:22 localhost kernel: esi: c916b940   edi: c1ee3930   ebp: 
c1ee3cc0   esp: c1c11e54
Oct 23 21:23:22 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 23 21:23:22 localhost kernel: Process kjournald (pid: 136, 
stackpage=c1c11000)
Oct 23 21:23:22 localhost kernel: Stack: 00000000 c01379e8 c916b940 00000000 
c916b940 c1ee3450 c0169b7e c916b940 
Oct 23 21:23:22 localhost kernel:        0000002d c1c11ea8 000002fa ffffffff 
c1c10000 dffceaf4 00000000 00000000 
Oct 23 21:23:22 localhost kernel:        00000000 00000000 c1ca2c40 c1b72540 
000002fa c90e1640 c90e15c0 c8576a40 
Oct 23 21:23:22 localhost kernel: Call Trace:    [<c01379e8>] [<c0169b7e>] 
[<c011350b>] [<c016bf5c>] [<c016be00>]
Oct 23 21:23:22 localhost kernel:   [<c010576e>] [<c016be20>]
Oct 23 21:23:22 localhost kernel: Code: 89 48 20 8b 02 89 48 24 ff 04 9d 50 ec 
25 c0 0f b7 41 08 01 


>>EIP; c0137103 <__insert_into_lru_list+43/60>   <=====

>>eax; c4c6a340 <END_OF_CODE+c9d405/????>
>>ecx; c916b940 <END_OF_CODE+519ea05/????>
>>edx; c025ec44 <lru_list+0/c>
>>esi; c916b940 <END_OF_CODE+519ea05/????>
>>edi; c1ee3930 <[md].bss.end+216dd1/2273521>
>>ebp; c1ee3cc0 <[md].bss.end+217161/2273521>
>>esp; c1c11e54 <_end+1997e04/1a32030>

Trace; c01379e8 <__refile_buffer+58/70>
Trace; c0169b7e <journal_commit_transaction+105e/11c0>
Trace; c011350b <schedule+15b/240>
Trace; c016bf5c <kjournald+13c/1d0>
Trace; c016be00 <commit_timeout+0/10>
Trace; c010576e <kernel_thread+2e/40>
Trace; c016be20 <kjournald+0/1d0>

Code;  c0137103 <__insert_into_lru_list+43/60>
00000000 <_EIP>:
Code;  c0137103 <__insert_into_lru_list+43/60>   <=====
   0:   89 48 20                  mov    %ecx,0x20(%eax)   <=====
Code;  c0137106 <__insert_into_lru_list+46/60>
   3:   8b 02                     mov    (%edx),%eax
Code;  c0137108 <__insert_into_lru_list+48/60>
   5:   89 48 24                  mov    %ecx,0x24(%eax)
Code;  c013710b <__insert_into_lru_list+4b/60>
   8:   ff 04 9d 50 ec 25 c0      incl   0xc025ec50(,%ebx,4)
Code;  c0137112 <__insert_into_lru_list+52/60>
   f:   0f b7 41 08               movzwl 0x8(%ecx),%eax
Code;  c0137116 <__insert_into_lru_list+56/60>
  13:   01 00                     add    %eax,(%eax)

Oct 23 21:23:22 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c51c0098
Oct 23 21:23:22 localhost kernel: c0119a10
Oct 23 21:23:22 localhost kernel: *pde = 050001e3
Oct 23 21:23:22 localhost kernel: Oops: 0000
Oct 23 21:23:22 localhost kernel: CPU:    0
Oct 23 21:23:22 localhost kernel: EIP:    0010:[<c0119a10>]    Not tainted
Oct 23 21:23:22 localhost kernel: EFLAGS: 00013206
Oct 23 21:23:22 localhost kernel: eax: 00000000   ebx: c51c0000   ecx: 
c193f000   edx: 00000000
Oct 23 21:23:22 localhost kernel: esi: c1c10000   edi: 0000006a   ebp: 
0000000b   esp: c1c11d08
Oct 23 21:23:22 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 23 21:23:22 localhost kernel: Process kjournald (pid: 136, 
stackpage=c1c11000)
Oct 23 21:23:22 localhost kernel: Stack: c1587bb8 c193f040 c1c10000 00000000 
c1c10000 0000006a 0000000b c0119f00 
Oct 23 21:23:22 localhost kernel:        c1c10000 00000002 c1c11e20 00000002 
0000006a c1c10000 c01079f2 0000000b 
Oct 23 21:23:22 localhost kernel:        c01edc4a 00000002 4942412e c01123c4 
c01edc4a c1c11e20 00000002 c0276784 
Oct 23 21:23:22 localhost kernel: Call Trace:    [<c0119f00>] [<c01079f2>] 
[<c01123c4>] [<c019bc12>] [<c0137cab>]
Oct 23 21:23:22 localhost kernel:   [<c018f4ec>] [<c018f8d5>] [<c018fac5>] 
[<c01120b0>] [<c0107470>] [<c0137103>]
Oct 23 21:23:22 localhost kernel:   [<c01379e8>] [<c0169b7e>] [<c011350b>] 
[<c016bf5c>] [<c016be00>] [<c010576e>]
Oct 23 21:23:22 localhost kernel:   [<c016be20>]
Oct 23 21:23:22 localhost kernel: Code: 39 b3 98 00 00 00 0f 84 85 02 00 00 8b 
5b 50 81 fb 00 80 21 


>>EIP; c0119a10 <exit_notify+20/300>   <=====

>>ebx; c51c0000 <END_OF_CODE+11f30c5/????>
>>ecx; c193f000 <_end+16c4fb0/1a32030>
>>esi; c1c10000 <_end+1995fb0/1a32030>
>>esp; c1c11d08 <_end+1997cb8/1a32030>

Trace; c0119f00 <do_exit+210/260>
Trace; c01079f2 <die+72/80>
Trace; c01123c4 <do_page_fault+314/5d0>
Trace; c019bc12 <do_rw_disk+4b2/5c0>
Trace; c0137cab <create_buffers+6b/e0>
Trace; c018f4ec <ide_wait_stat+bc/130>
Trace; c018f8d5 <start_request+1b5/250>
Trace; c018fac5 <ide_do_request+c5/1c0>
Trace; c01120b0 <do_page_fault+0/5d0>
Trace; c0107470 <error_code+34/3c>
Trace; c0137103 <__insert_into_lru_list+43/60>
Trace; c01379e8 <__refile_buffer+58/70>
Trace; c0169b7e <journal_commit_transaction+105e/11c0>
Trace; c011350b <schedule+15b/240>
Trace; c016bf5c <kjournald+13c/1d0>
Trace; c016be00 <commit_timeout+0/10>
Trace; c010576e <kernel_thread+2e/40>
Trace; c016be20 <kjournald+0/1d0>

Code;  c0119a10 <exit_notify+20/300>
00000000 <_EIP>:
Code;  c0119a10 <exit_notify+20/300>   <=====
   0:   39 b3 98 00 00 00         cmp    %esi,0x98(%ebx)   <=====
Code;  c0119a16 <exit_notify+26/300>
   6:   0f 84 85 02 00 00         je     291 <_EIP+0x291>
Code;  c0119a1c <exit_notify+2c/300>
   c:   8b 5b 50                  mov    0x50(%ebx),%ebx
Code;  c0119a1f <exit_notify+2f/300>
   f:   81 fb 00 80 21 00         cmp    $0x218000,%ebx

Oct 23 21:23:22 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c54bc098
Oct 23 21:23:22 localhost kernel: c0119a10
Oct 23 21:23:22 localhost kernel: *pde = 054001e3
Oct 23 21:23:22 localhost kernel: Oops: 0000
Oct 23 21:23:22 localhost kernel: CPU:    0
Oct 23 21:23:22 localhost kernel: EIP:    0010:[<c0119a10>]    Not tainted
Oct 23 21:23:23 localhost kernel: EFLAGS: 00013206
Oct 23 21:23:23 localhost kernel: eax: 00000000   ebx: c54bc000   ecx: 
00000000   edx: 00000000
Oct 23 21:23:23 localhost kernel: esi: c1c10000   edi: 000001c0   ebp: 
0000000b   esp: c1c11bbc
Oct 23 21:23:23 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 23 21:23:23 localhost kernel: Process kjournald (pid: 136, 
stackpage=c1c11000)
Oct 23 21:23:23 localhost kernel: Stack: 00000020 00000400 c1c10000 00000000 
c1c10000 000001c0 0000000b c0119f00 
Oct 23 21:23:23 localhost kernel:        c1c10000 00000000 c1c11cd4 00000000 
000001c0 c1c10000 c01079f2 0000000b 
Oct 23 21:23:23 localhost kernel:        c01edc4a 00000000 24548924 c01123c4 
c01edc4a c1c11cd4 00000000 33323130 
Oct 23 21:23:23 localhost kernel: Call Trace:    [<c0119f00>] [<c01079f2>] 
[<c01123c4>] [<c0185ba9>] [<c0185ba9>]
Oct 23 21:23:23 localhost kernel:   [<c0185ba9>] [<c01167bf>] [<c0185ba9>] 
[<c0185ba9>] [<c01120b0>] [<c0107470>]
Oct 23 21:23:23 localhost kernel:   [<c0119a10>] [<c0119f00>] [<c01079f2>] 
[<c01123c4>] [<c019bc12>] [<c0137cab>]
Oct 23 21:23:23 localhost kernel:   [<c018f4ec>] [<c018f8d5>] [<c018fac5>] 
[<c01120b0>] [<c0107470>] [<c0137103>]
Oct 23 21:23:23 localhost kernel:   [<c01379e8>] [<c0169b7e>] [<c011350b>] 
[<c016bf5c>] [<c016be00>] [<c010576e>]
Oct 23 21:23:23 localhost kernel:   [<c016be20>]
Oct 23 21:23:23 localhost kernel: Code: 39 b3 98 00 00 00 0f 84 85 02 00 00 8b 
5b 50 81 fb 00 80 21 


>>EIP; c0119a10 <exit_notify+20/300>   <=====

>>ebx; c54bc000 <END_OF_CODE+14ef0c5/????>
>>esi; c1c10000 <_end+1995fb0/1a32030>
>>esp; c1c11bbc <_end+1997b6c/1a32030>

Trace; c0119f00 <do_exit+210/260>
Trace; c01079f2 <die+72/80>
Trace; c01123c4 <do_page_fault+314/5d0>
Trace; c0185ba9 <vt_console_print+59/310>
Trace; c0185ba9 <vt_console_print+59/310>
Trace; c0185ba9 <vt_console_print+59/310>
Trace; c01167bf <__call_console_drivers+5f/70>
Trace; c0185ba9 <vt_console_print+59/310>
Trace; c0185ba9 <vt_console_print+59/310>
Trace; c01120b0 <do_page_fault+0/5d0>
Trace; c0107470 <error_code+34/3c>
Trace; c0119a10 <exit_notify+20/300>
Trace; c0119f00 <do_exit+210/260>
Trace; c01079f2 <die+72/80>
Trace; c01123c4 <do_page_fault+314/5d0>
Trace; c019bc12 <do_rw_disk+4b2/5c0>
Trace; c0137cab <create_buffers+6b/e0>
Trace; c018f4ec <ide_wait_stat+bc/130>
Trace; c018f8d5 <start_request+1b5/250>
Trace; c018fac5 <ide_do_request+c5/1c0>
Trace; c01120b0 <do_page_fault+0/5d0>
Trace; c0107470 <error_code+34/3c>
Trace; c0137103 <__insert_into_lru_list+43/60>
Trace; c01379e8 <__refile_buffer+58/70>
Trace; c0169b7e <journal_commit_transaction+105e/11c0>
Trace; c011350b <schedule+15b/240>
Trace; c016bf5c <kjournald+13c/1d0>
Trace; c016be00 <commit_timeout+0/10>
Trace; c010576e <kernel_thread+2e/40>
Trace; c016be20 <kjournald+0/1d0>

Code;  c0119a10 <exit_notify+20/300>
00000000 <_EIP>:
Code;  c0119a10 <exit_notify+20/300>   <=====
   0:   39 b3 98 00 00 00         cmp    %esi,0x98(%ebx)   <=====
Code;  c0119a16 <exit_notify+26/300>
   6:   0f 84 85 02 00 00         je     291 <_EIP+0x291>
Code;  c0119a1c <exit_notify+2c/300>
   c:   8b 5b 50                  mov    0x50(%ebx),%ebx
Code;  c0119a1f <exit_notify+2f/300>
   f:   81 fb 00 80 21 00         cmp    $0x218000,%ebx


1 warning issued.  Results may not be reliable.


When I tried to see if I can trigger the oops with only 0* patches, I couldn't 
compile the kernel. Here is the standard error stream of 'make dep clean ; 
make bzImage' :

module.c:7:28: linux/rcupdate.h: No such file or directory
module.c: In function `free_module':
module.c:1082: warning: implicit declaration of function `synchronize_kernel'
make[2]: *** [module.o] Error 1
make[1]: *** [first_rule] Error 2
make: *** [_dir_kernel] Error 2

BTW I heard DaveM mentioning about AMD only bugs appearing during 2.4.20-pre 
series, I am not sure about -aa series though. I thought of testing the 
-aa/radeon/agpgart on my friend's computer which is an Intel P-III/VIA 
Chipset mother board.

Thanks for your help.
-- 
Hari
harisri@bigpond.com

