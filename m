Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289766AbSBKOrz>; Mon, 11 Feb 2002 09:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289811AbSBKOrq>; Mon, 11 Feb 2002 09:47:46 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:27525 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S289766AbSBKOrd>; Mon, 11 Feb 2002 09:47:33 -0500
Message-ID: <3C67D9CB.2030806@oracle.com>
Date: Mon, 11 Feb 2002 15:48:43 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: [BUG] Panic in 2.5.4 during bootup after POSIX conformance testing by UNIFIX
In-Reply-To: <Pine.LNX.4.30.0202111453330.28560-200000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> hi all
> 
> My 3.5.4 panics right after reporting 'POSIX conformance testing by
> UNIFIX'.

Very similar one here, also happens after POSIX banner - ksymoops
  output follows:

ksymoops 2.4.1 on i686 2.5.4-pre2.  Options used
      -v /usr/src/linux/vmlinux (specified)
      -K (specified)
      -L (specified)
      -o /lib/modules/2.5.4 (specified)
      -m /boot/System.map-2.5.4 (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c0116850>]     Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c029c480   ebx: 00000001   ecx: c02b2000   edx: 00000000
esi: c02e7500   edi: 00000000   ebp: c02b3f98   esp: c02b3f80
ds: 0018   es: 0018   ss: 0018
Stack: 0008e000 c01076dd c029c480 c02b2000 c02b3fd4 c0105000 0008e000 c0108eea
        00010400 c0105060 00000000 c02b3fd4 c0105000 0008e000 00000001 c02e0018
        00000018 00000078 c010729d 00000010 00000206 0000ffd3 c02b2000 c0105011
Call Trace: [<c01076dd>] [<c0105000>] [<c0108eea>] [<c0105060>] [<c0105000>] [<c010729d>] [<c0105011>] [<c0105060>]
Code: 0f 0b e9 06 fd ff ff e8 24 00 00 00 eb f2 89 f6 8b 41 08 83

 >>EIP; c0116850 <schedule+330/360>   <=====
Trace; c01076dd <sys_clone+1d/30>
Trace; c0105000 <_stext+0/0>
Trace; c0108eea <work_resched+5/16>
Trace; c0105060 <init+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010729d <kernel_thread+1d/30>
Trace; c0105011 <rest_init+11/60>
Trace; c0105060 <init+0/1c0>
Code;  c0116850 <schedule+330/360>
00000000 <_EIP>:
Code;  c0116850 <schedule+330/360>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0116852 <schedule+332/360>
    2:   e9 06 fd ff ff            jmp    fffffd0d <_EIP+0xfffffd0d> c011655d <schedule+3d/360>
Code;  c0116857 <schedule+337/360>
    7:   e8 24 00 00 00            call   30 <_EIP+0x30> c0116880 <preempt_schedule+0/30>
Code;  c011685c <schedule+33c/360>
    c:   eb f2                     jmp    0 <_EIP>
Code;  c011685e <schedule+33e/360>
    e:   89 f6                     mov    %esi,%esi
Code;  c0116860 <schedule+340/360>
   10:   8b 41 08                  mov    0x8(%ecx),%eax
Code;  c0116863 <schedule+343/360>
   13:   83 00 00                  addl   $0x0,(%eax)


> 
> ksymoops info is below
> 
> roy
> --
> ksymoops 2.4.3 on i686 2.4.17.  Options used
>      -v ../linux/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.17/ (default)
>      -m ../linux/System.map (specified)
> 
> No modules in ksyms, skipping objects
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c01147ff>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010082
> eax: 0000001b   ebx: c0294000   ecx: fffff76c   edx: 00000894
> esi: c02ce100   edi: 00000000   ebp: c0295f94   esp: c0295f74
> ds: 0018   es: 0018   ss: 0018
> Stack: c0239d79 00000298 c0294000 c0295fd0 00000000 00000078 c0295f9c c0280d20
>        0004e000 c0108bea 00010f00 00000078 c0105070 c0295fd0 00000000 0004e000
>        00000001 00000018 00000018 00000078 c010719f 00000010 00000206 00038000
> Call Trace: [<c0108bea>] [<c0105070>] [<c010719f>] [<c0105000>] [<c0105012>]
>    [<c0105070>]
> Code: 0f 0b 83 c4 08 fa b8 00 e0 ff ff 21 e0 ff 40 10 f6 40 13 04
> 
> 
>>>EIP; c01147fe <schedule+6e/2e0>   <=====
>>>
> Trace; c0108bea <work_resched+6/16>
> Trace; c0105070 <init+0/160>
> Trace; c010719e <kernel_thread+1e/40>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105012 <rest_init+12/70>
> Trace; c0105070 <init+0/160>
> Code;  c01147fe <schedule+6e/2e0>
> 00000000 <_EIP>:
> Code;  c01147fe <schedule+6e/2e0>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0114800 <schedule+70/2e0>
>    2:   83 c4 08                  add    $0x8,%esp
> Code;  c0114802 <schedule+72/2e0>
>    5:   fa                        cli
> Code;  c0114804 <schedule+74/2e0>
>    6:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
> Code;  c0114808 <schedule+78/2e0>
>    b:   21 e0                     and    %esp,%eax
> Code;  c011480a <schedule+7a/2e0>
>    d:   ff 40 10                  incl   0x10(%eax)
> Code;  c011480e <schedule+7e/2e0>
>   10:   f6 40 13 04               testb  $0x4,0x13(%eax)
> 
>  <0>Kernel panic: Attempted to kill the idle task!

--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")

