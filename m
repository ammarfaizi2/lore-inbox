Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTEDTcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTEDTcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 15:32:17 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:35332 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261562AbTEDTcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 15:32:11 -0400
Date: Sun, 4 May 2003 21:44:51 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
Message-ID: <20030504194451.GA29196@codeblau.de>
References: <20030504173956.GA28370@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504173956.GA28370@codeblau.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the ksymoops output.  The taint came from the nvidia kernel
module, X was not running, so the module did not do anything at the
time.


ksymoops 2.4.1 on i686 2.5.68.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.68/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
e100: eth0 NIC Link is Up 100 Mbps Full duplex
Unable to handle kernel NULL pointer dereference at virtual address 00000017
c014c95b
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014c95b>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: d241b000   ebx: 00000003   ecx: c037c450   edx: 00000003
esi: 00000405   edi: c3194620   ebp: 00000021   esp: c379bf60
ds: 007b   es: 007b   ss: 0068
Stack: c0341e60 c3194620 07ffffff 00000405 c3194620 00000021 c011e21c 00000003 
       c3194620 c3194620 00000000 4003c904 c37bad80 c011edc4 c319d780 c319d780 
       c379a000 c014d557 00000000 00200001 4003c904 c379a000 c011f0b3 00000000 
Call Trace: [<c011e21c>]  [<c011edc4>]  [<c014d557>]  [<c011f0b3>]  [<c0109279>] 
Code: 8b 43 14 85 c0 0f 84 9a 00 00 00 8b 43 10 31 ed 85 c0 74 45 

>>EIP; c014c95b <filp_close+1b/d0>   <=====
Trace; c011e21c <put_files_struct+6c/e0>
Trace; c011edc4 <do_exit+144/400>
Trace; c014d557 <sys_write+47/60>
Trace; c011f0b3 <sys_exit+13/20>
Trace; c0109279 <sysenter_past_esp+52/71>
Code;  c014c95b <filp_close+1b/d0>
00000000 <_EIP>:
Code;  c014c95b <filp_close+1b/d0>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c014c95e <filp_close+1e/d0>
   3:   85 c0                     test   %eax,%eax
Code;  c014c960 <filp_close+20/d0>
   5:   0f 84 9a 00 00 00         je     a5 <_EIP+0xa5>
Code;  c014c966 <filp_close+26/d0>
   b:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c014c969 <filp_close+29/d0>
   e:   31 ed                     xor    %ebp,%ebp
Code;  c014c96b <filp_close+2b/d0>
  10:   85 c0                     test   %eax,%eax
Code;  c014c96d <filp_close+2d/d0>
  12:   74 45                     je     59 <_EIP+0x59>

Unable to handle kernel paging request at virtual address d209bd38
c014e30f
*pde = 09a1b067
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c014e30f>]    Tainted: P  
EFLAGS: 00010287
eax: d209a000   ebx: 00000000   ecx: 0000074e   edx: c23e4000
esi: c21e8548   edi: c23e5f64   ebp: 00000000   esp: c23e5f24
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c015fabd c0124bc0 c23e3980 c21e8540 c23e5f60 c23e5f64 00000000 
       c015fb9a 00000001 c21e8548 c23e5f60 c23e5f64 c23e4000 c23e4000 00000000 
       00000000 bffff7c8 00000000 c21e8540 00000001 c015fd60 00000001 c21e8540 
Call Trace: [<c015fabd>]  [<c0124bc0>]  [<c015fb9a>]  [<c015fd60>]  [<c015df65>]  [<c015f0f0>]  [<c0109279>] 
Code: 8b 1c 88 85 db 74 03 ff 43 14 ff 4a 14 8b 42 08 83 e0 08 75 

>>EIP; c014e30f <fget+1f/40>   <=====
Trace; c015fabd <do_pollfd+2d/a0>
Trace; c0124bc0 <process_timeout+0/10>
Trace; c015fb9a <do_poll+6a/d0>
Trace; c015fd60 <sys_poll+160/260>
Trace; c015df65 <do_fcntl+d5/1c0>
Trace; c015f0f0 <__pollwait+0/d0>
Trace; c0109279 <sysenter_past_esp+52/71>
Code;  c014e30f <fget+1f/40>
00000000 <_EIP>:
Code;  c014e30f <fget+1f/40>   <=====
   0:   8b 1c 88                  mov    (%eax,%ecx,4),%ebx   <=====
Code;  c014e312 <fget+22/40>
   3:   85 db                     test   %ebx,%ebx
Code;  c014e314 <fget+24/40>
   5:   74 03                     je     a <_EIP+0xa>
Code;  c014e316 <fget+26/40>
   7:   ff 43 14                  incl   0x14(%ebx)
Code;  c014e319 <fget+29/40>
   a:   ff 4a 14                  decl   0x14(%edx)
Code;  c014e31c <fget+2c/40>
   d:   8b 42 08                  mov    0x8(%edx),%eax
Code;  c014e31f <fget+2f/40>
  10:   83 e0 08                  and    $0x8,%eax
Code;  c014e322 <fget+32/40>
  13:   75 00                     jne    15 <_EIP+0x15>

Unable to handle kernel paging request at virtual address d209a000
c011e1fd
*pde = 09a1b067
Oops: 0002 [#3]
CPU:    0
EIP:    0060:[<c011e1fd>]    Tainted: P  
EFLAGS: 00010246
eax: d209a000   ebx: ffffffff   ecx: 00000000   edx: 00000000
esi: 00000000   edi: c22f8380   ebp: 00000001   esp: c23e5de0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c23e3980 c22f8380 00000000 c23e3980 c23e3980 c011edc4 c2299e20 
       c2299e20 00001aee 00000001 c23e4000 c23e5ef0 c23e3980 0000009b c010a2fc 
       0000000b c033dc76 00000000 00000002 00000000 00000000 c0117e3a c033dc76 
Call Trace: [<c011edc4>]  [<c010a2fc>]  [<c0117e3a>]  [<c029ca2d>]  [<c029cb34>]  [<c010b7ed>]  [<c011c604>]  [<c0117cf0>]  [<c0109cd5>]  [<c012007b>]  [<c014e30f>]  [<c015fabd>]  [<c0124bc0>]  [<c015fb9a>]  [<c015fd60>]  [<c015df65>]  [<c015f0f0>]  [<c0109279>] 
Code: 87 14 b0 85 d2 75 0c 46 d1 eb 75 e7 eb bd 90 8d 74 26 00 89 

>>EIP; c011e1fd <put_files_struct+4d/e0>   <=====
Trace; c011edc4 <do_exit+144/400>
Trace; c010a2fc <die+ec/f0>
Trace; c0117e3a <do_page_fault+14a/45e>
Trace; c029ca2d <process_backlog+6d/100>
Trace; c029cb34 <net_rx_action+74/120>
Trace; c010b7ed <do_IRQ+fd/120>
Trace; c011c604 <__mmdrop+34/46>
Trace; c0117cf0 <do_page_fault+0/45e>
Trace; c0109cd5 <error_code+2d/38>
Trace; c012007b <sys_settimeofday+1b/f0>
Trace; c014e30f <fget+1f/40>
Trace; c015fabd <do_pollfd+2d/a0>
Trace; c0124bc0 <process_timeout+0/10>
Trace; c015fb9a <do_poll+6a/d0>
Trace; c015fd60 <sys_poll+160/260>
Trace; c015df65 <do_fcntl+d5/1c0>
Trace; c015f0f0 <__pollwait+0/d0>
Trace; c0109279 <sysenter_past_esp+52/71>
Code;  c011e1fd <put_files_struct+4d/e0>
00000000 <_EIP>:
Code;  c011e1fd <put_files_struct+4d/e0>   <=====
   0:   87 14 b0                  xchg   %edx,(%eax,%esi,4)   <=====
Code;  c011e200 <put_files_struct+50/e0>
   3:   85 d2                     test   %edx,%edx
Code;  c011e202 <put_files_struct+52/e0>
   5:   75 0c                     jne    13 <_EIP+0x13>
Code;  c011e204 <put_files_struct+54/e0>
   7:   46                        inc    %esi
Code;  c011e205 <put_files_struct+55/e0>
   8:   d1 eb                     shr    %ebx
Code;  c011e207 <put_files_struct+57/e0>
   a:   75 e7                     jne    fffffff3 <_EIP+0xfffffff3>
Code;  c011e209 <put_files_struct+59/e0>
   c:   eb bd                     jmp    ffffffcb <_EIP+0xffffffcb>
Code;  c011e20b <put_files_struct+5b/e0>
   e:   90                        nop    
Code;  c011e20c <put_files_struct+5c/e0>
   f:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c011e210 <put_files_struct+60/e0>
  13:   89 00                     mov    %eax,(%eax)

Unable to handle kernel paging request at virtual address d2728188
c014e30f
*pde = 08540067
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<c014e30f>]    Tainted: P  
EFLAGS: 00010283
eax: d2726000   ebx: 00000000   ecx: 00000862   edx: ca208000
esi: ca271c48   edi: ca209f64   ebp: 00000000   esp: ca209f24
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c015fabd c0124bc0 ca219360 ca271c40 ca209f60 ca209f64 00000000 
       c015fb9a 00000001 ca271c48 ca209f60 ca209f64 ca208000 ca208000 00000000 
       00000000 bffff7c8 00000000 ca271c40 00000001 c015fd60 00000001 ca271c40 
Call Trace: [<c015fabd>]  [<c0124bc0>]  [<c015fb9a>]  [<c015fd60>]  [<c015df65>]  [<c015f0f0>]  [<c0109279>] 
Code: 8b 1c 88 85 db 74 03 ff 43 14 ff 4a 14 8b 42 08 83 e0 08 75 

>>EIP; c014e30f <fget+1f/40>   <=====
Trace; c015fabd <do_pollfd+2d/a0>
Trace; c0124bc0 <process_timeout+0/10>
Trace; c015fb9a <do_poll+6a/d0>
Trace; c015fd60 <sys_poll+160/260>
Trace; c015df65 <do_fcntl+d5/1c0>
Trace; c015f0f0 <__pollwait+0/d0>
Trace; c0109279 <sysenter_past_esp+52/71>
Code;  c014e30f <fget+1f/40>
00000000 <_EIP>:
Code;  c014e30f <fget+1f/40>   <=====
   0:   8b 1c 88                  mov    (%eax,%ecx,4),%ebx   <=====
Code;  c014e312 <fget+22/40>
   3:   85 db                     test   %ebx,%ebx
Code;  c014e314 <fget+24/40>
   5:   74 03                     je     a <_EIP+0xa>
Code;  c014e316 <fget+26/40>
   7:   ff 43 14                  incl   0x14(%ebx)
Code;  c014e319 <fget+29/40>
   a:   ff 4a 14                  decl   0x14(%edx)
Code;  c014e31c <fget+2c/40>
   d:   8b 42 08                  mov    0x8(%edx),%eax
Code;  c014e31f <fget+2f/40>
  10:   83 e0 08                  and    $0x8,%eax
Code;  c014e322 <fget+32/40>
  13:   75 00                     jne    15 <_EIP+0x15>

Unable to handle kernel paging request at virtual address d2726000
c011e1fd
*pde = 08540067
Oops: 0002 [#5]
CPU:    0
EIP:    0060:[<c011e1fd>]    Tainted: P  
EFLAGS: 00010246
eax: d2726000   ebx: ffffffff   ecx: 00000001   edx: 00000000
esi: 00000000   edi: ca229dc0   ebp: 00000001   esp: ca209de0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 ca219360 ca229dc0 00000000 ca219360 ca219360 c011edc4 c9830320 
       c9830320 00001c02 00000001 ca208000 ca209ef0 ca219360 00000328 c010a2fc 
       0000000b c033dc76 00000000 00000004 00000000 00000000 c0117e3a c033dc76 
Call Trace: [<c011edc4>]  [<c010a2fc>]  [<c0117e3a>]  [<c010b7ed>]  [<c0136561>]  [<c01366a0>]  [<c011c604>]  [<c0117cf0>]  [<c0109cd5>]  [<c012007b>]  [<c014e30f>]  [<c015fabd>]  [<c0124bc0>]  [<c015fb9a>]  [<c015fd60>]  [<c015df65>]  [<c015f0f0>]  [<c0109279>] 
Code: 87 14 b0 85 d2 75 0c 46 d1 eb 75 e7 eb bd 90 8d 74 26 00 89 

>>EIP; c011e1fd <put_files_struct+4d/e0>   <=====
Trace; c011edc4 <do_exit+144/400>
Trace; c010a2fc <die+ec/f0>
Trace; c0117e3a <do_page_fault+14a/45e>
Trace; c010b7ed <do_IRQ+fd/120>
Trace; c0136561 <buffered_rmqueue+b1/150>
Trace; c01366a0 <__alloc_pages+a0/2d0>
Trace; c011c604 <__mmdrop+34/46>
Trace; c0117cf0 <do_page_fault+0/45e>
Trace; c0109cd5 <error_code+2d/38>
Trace; c012007b <sys_settimeofday+1b/f0>
Trace; c014e30f <fget+1f/40>
Trace; c015fabd <do_pollfd+2d/a0>
Trace; c0124bc0 <process_timeout+0/10>
Trace; c015fb9a <do_poll+6a/d0>
Trace; c015fd60 <sys_poll+160/260>
Trace; c015df65 <do_fcntl+d5/1c0>
Trace; c015f0f0 <__pollwait+0/d0>
Trace; c0109279 <sysenter_past_esp+52/71>
Code;  c011e1fd <put_files_struct+4d/e0>
00000000 <_EIP>:
Code;  c011e1fd <put_files_struct+4d/e0>   <=====
   0:   87 14 b0                  xchg   %edx,(%eax,%esi,4)   <=====
Code;  c011e200 <put_files_struct+50/e0>
   3:   85 d2                     test   %edx,%edx
Code;  c011e202 <put_files_struct+52/e0>
   5:   75 0c                     jne    13 <_EIP+0x13>
Code;  c011e204 <put_files_struct+54/e0>
   7:   46                        inc    %esi
Code;  c011e205 <put_files_struct+55/e0>
   8:   d1 eb                     shr    %ebx
Code;  c011e207 <put_files_struct+57/e0>
   a:   75 e7                     jne    fffffff3 <_EIP+0xfffffff3>
Code;  c011e209 <put_files_struct+59/e0>
   c:   eb bd                     jmp    ffffffcb <_EIP+0xffffffcb>
Code;  c011e20b <put_files_struct+5b/e0>
   e:   90                        nop    
Code;  c011e20c <put_files_struct+5c/e0>
   f:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c011e210 <put_files_struct+60/e0>
  13:   89 00                     mov    %eax,(%eax)


1 warning and 1 error issued.  Results may not be reliable.
