Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTEEHil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 03:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTEEHil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 03:38:41 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:3591 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262023AbTEEHii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 03:38:38 -0400
Date: Mon, 5 May 2003 09:51:19 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
Message-ID: <20030505075118.GA352@codeblau.de>
References: <20030504173956.GA28370@codeblau.de> <20030504194451.GA29196@codeblau.de> <1052079133.27465.14.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052079133.27465.14.camel@rth.ninka.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake David S. Miller (davem@redhat.com):
> > Here is the ksymoops output.  The taint came from the nvidia kernel
> > module, X was not running, so the module did not do anything at the
> > time.
> Not true, if it got loaded it did something.

> Either reproduce without the nvidia module loaded, or take
> your report to nvidia.

Thank you for this stunning display of unprofessionalism and zealotry.
People like you keep free software alive.


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
Unable to handle kernel paging request at virtual address d2f83908
c014e30f
*pde = 06608067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014e30f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: d2f81000   ebx: 00000000   ecx: 00000a42   edx: c5920000
esi: c5a2f4e8   edi: c5921f64   ebp: 00000000   esp: c5921f24
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c015fabd c0124bc0 c5950680 c5a2f4e0 c5921f60 c5921f64 00000000 
       c015fb9a 00000001 c5a2f4e8 c5921f60 c5921f64 c5920000 c5920000 00000000 
       00000000 bffff808 00000000 c5a2f4e0 00000001 c015fd60 00000001 c5a2f4e0 
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

Unable to handle kernel paging request at virtual address d2f81000
c011e1fd
*pde = 06608067
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c011e1fd>]    Not tainted
EFLAGS: 00010246
eax: d2f81000   ebx: ffffffff   ecx: 00000001   edx: 00000000
esi: 00000000   edi: c597e900   ebp: 00000001   esp: c5921de0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c5950680 c597e900 00000000 c5950680 c5950680 c011edc4 c595ae20 
       c595ae20 00000a9a 00000001 c5920000 c5921ef0 c5950680 00000383 c010a2fc 
       0000000b c033dc76 00000000 00000001 00000000 00000000 c0117e3a c033dc76 
Call Trace: [<c011edc4>]  [<c010a2fc>]  [<c0117e3a>]  [<c0136561>]  [<c0136561>]  [<c01366a0>]  [<c0117cf0>]  [<c0109cd5>]  [<c012007b>]  [<c014e30f>]  [<c015fabd>]  [<c0124bc0>]  [<c015fb9a>]  [<c015fd60>]  [<c015df65>]  [<c015f0f0>]  [<c0109279>] 
Code: 87 14 b0 85 d2 75 0c 46 d1 eb 75 e7 eb bd 90 8d 74 26 00 89 

>>EIP; c011e1fd <put_files_struct+4d/e0>   <=====
Trace; c011edc4 <do_exit+144/400>
Trace; c010a2fc <die+ec/f0>
Trace; c0117e3a <do_page_fault+14a/45e>
Trace; c0136561 <buffered_rmqueue+b1/150>
Trace; c0136561 <buffered_rmqueue+b1/150>
Trace; c01366a0 <__alloc_pages+a0/2d0>
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
