Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317996AbSGLU2N>; Fri, 12 Jul 2002 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317997AbSGLU2M>; Fri, 12 Jul 2002 16:28:12 -0400
Received: from calhau.terra.com.br ([200.176.3.20]:20930 "EHLO
	calhau.terra.com.br") by vger.kernel.org with ESMTP
	id <S317996AbSGLU2K>; Fri, 12 Jul 2002 16:28:10 -0400
Date: Fri, 12 Jul 2002 17:30:39 -0300
From: Christian Reis <kiko@async.com.br>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd/reiserfs oopsen in 2.4.18-ac2
Message-ID: <20020712173039.C4385@blackjesus.async.com.br>
References: <20020712165337.A757@anthem.async.com.br> <Pine.LNX.4.33.0207121607470.8654-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0207121607470.8654-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Fri, Jul 12, 2002 at 04:11:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 04:11:41PM -0400, Mark Hahn wrote:
> > Anybody seen this happen with them? This is a moderately-loaded
> > Athlon1.4G with 512M and 512M swap, which serves NFS to around 20
> 
> any reason to think this isn't bad power, hot cpu, bad ram?
> athlons of that era certainly had those problems a lot,
> and your two oopses look suspicious like hardware corruption
> (the first, someone has tried to load eax with a pointer,
> but got text instead.  and the second someone probably did
> 28(ebx), which was not supposed to be null...)

This box has been online for a couple of months now, and this is the
first time. The only thing new has been the new tape drive. I do agree
it may be the power supply, however. I've attached the output run
through ksymoops anyway, just in case somebody's seen this before.

> try running memtest86 overnight, and if that works, compiling 
> the kernel in a loop for a few hours...

Yep, will do tonight.

Ksymoops follow:

ksymoops 2.4.5 on i686 2.4.18-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-ac3/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0214ba0, System.map says c0150400.  Ignoring ksyms_base entry
Jul 12 01:54:55 anthem kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
Jul 12 01:54:55 anthem kernel: c01431be
Jul 12 01:54:55 anthem kernel: *pde = 00000000
Jul 12 01:54:55 anthem kernel: Oops: 0000
Jul 12 01:54:55 anthem kernel: CPU:    0
Jul 12 01:54:55 anthem kernel: EIP:    0010:[find_inode+30/96]    Not tainted
Jul 12 01:54:55 anthem kernel: EFLAGS: 00010207
Jul 12 01:54:55 anthem kernel: eax: dff8ee00   ebx: 00000000   ecx: 0000000f   edx: 00001327
Jul 12 01:54:55 anthem kernel: esi: 00000000   edi: c018f500   ebp: dff8ee00   esp: ca845e28
Jul 12 01:54:55 anthem kernel: ds: 0018   es: 0018   ss: 0018
Jul 12 01:54:55 anthem kernel: Process tar (pid: 7902, stackpage=ca845000)
Jul 12 01:54:55 anthem kernel: Stack: ca845ea0 c018f500 00001327 df20e800 c01435f7 df20e800 00001327 dff8ee00 
Jul 12 01:54:55 anthem kernel:        c018f500 ca845e80 ca845ea0 ca845f04 ca845ee0 00000000 dff8ee00 c018f547 
Jul 12 01:54:55 anthem kernel:        df20e800 00001327 c018f500 ca845e80 ca845ea0 00000001 00001316 c018b307 
Jul 12 01:54:55 anthem kernel: Call Trace: [reiserfs_find_actor+0/32] [iget4+71/208] [reiserfs_find_actor+0/32] [reiserfs_iget+39/112] [reiserfs_find_actor+0/32] 
Jul 12 01:54:55 anthem kernel: Code: 39 53 28 75 24 8b 54 24 14 39 93 9c 00 00 00 75 18 85 ff 74 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; dff8ee00 <_end+1fc58b1c/20c87d1c>
>>edx; 00001327 Before first symbol
>>edi; c018f500 <reiserfs_find_actor+0/20>
>>ebp; dff8ee00 <_end+1fc58b1c/20c87d1c>
>>esp; ca845e28 <_end+a50fb44/20c87d1c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 53 28                  cmpl   %edx,0x28(%ebx)
Code;  00000003 Before first symbol
   3:   75 24                     jne    29 <_EIP+0x29> 00000029 Before first symbol
Code;  00000005 Before first symbol
   5:   8b 54 24 14               movl   0x14(%esp,1),%edx
Code;  00000009 Before first symbol
   9:   39 93 9c 00 00 00         cmpl   %edx,0x9c(%ebx)
Code;  0000000f Before first symbol
   f:   75 18                     jne    29 <_EIP+0x29> 00000029 Before first symbol
Code;  00000011 Before first symbol
  11:   85 ff                     testl  %edi,%edi
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before first symbol


1 warning issued.  Results may not be reliable.


ksymoops 2.4.5 on i686 2.4.18-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-ac3/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0214ba0, System.map says c0150400.  Ignoring ksyms_base entry
Jul 12 16:28:03 anthem kernel: Unable to handle kernel paging request at virtual address 5f796f72
Jul 12 16:28:03 anthem kernel: 5f796f72
Jul 12 16:28:03 anthem kernel: *pde = 00000000
Jul 12 16:28:03 anthem kernel: Oops: 0000
Jul 12 16:28:03 anthem kernel: CPU:    0
Jul 12 16:28:03 anthem kernel: EIP:    0010:[<5f796f72>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 12 16:28:03 anthem kernel: EFLAGS: 00010206
Jul 12 16:28:03 anthem kernel: eax: 5f796f72   ebx: c93f42c0   ecx: c93f42d0   edx: c93f42d0
Jul 12 16:28:03 anthem kernel: esi: 4003b0b8   edi: c1ab3040   ebp: 00002964   esp: c16b5f7c
Jul 12 16:28:03 anthem kernel: ds: 0018   es: 0018   ss: 0018
Jul 12 16:28:03 anthem kernel: Process kswapd (pid: 4, stackpage=c16b5000)
Jul 12 16:28:03 anthem kernel: Stack: c0143727 c93f42c0 c630e6d8 c630e6c0 c93f42c0 c0141766 c93f42c0 000001d0 
Jul 12 16:28:03 anthem kernel:        c02b0900 00000000 000003c6 c0141a4b 00003fae c0129938 00000006 000001d0 
Jul 12 16:28:03 anthem kernel:        000001d0 00000376 c02b0900 00000000 0008e000 c0129c1e 000001d0 00010f00 
Jul 12 16:28:03 anthem kernel: Call Trace: [iput+55/416] [prune_dcache+198/320] [shrink_dcache_memory+27/48] [do_try_to_free_pages+24/384] [kswapd+254/768] 
Jul 12 16:28:03 anthem kernel: Code:  Bad EIP value.


>>EIP; 5f796f72 Before first symbol   <=====

>>eax; 5f796f72 Before first symbol
>>ebx; c93f42c0 <_end+90bdfdc/20c87d1c>
>>ecx; c93f42d0 <_end+90bdfec/20c87d1c>
>>edx; c93f42d0 <_end+90bdfec/20c87d1c>
>>esi; 4003b0b8 Before first symbol
>>edi; c1ab3040 <_end+177cd5c/20c87d1c>
>>ebp; 00002964 Before first symbol
>>esp; c16b5f7c <_end+137fc98/20c87d1c>


1 warning issued.  Results may not be reliable.

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
