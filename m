Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSE3UBl>; Thu, 30 May 2002 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSE3UBl>; Thu, 30 May 2002 16:01:41 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:2769 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S316856AbSE3UBi>; Thu, 30 May 2002 16:01:38 -0400
Message-ID: <3CF6843C.6090101@oracle.com>
Date: Thu, 30 May 2002 21:57:48 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.19 OOPS in pcmcia setup code
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

decoded oops follows, 100% reproducable.

Dell Latitude CPxJ750GT, PIII-750, Xircom RBEM56G100-TX,
  kernel compiled with GCC 3.1. NB, 2.5.18 compiled with
  GCC 3.1 works fine.

I tried recompiling with RH7.3 GCC but I still get an oops
  on boot - I can't decode it since it scrolls maybe a dozen
  screenfuls before stopping, so here's the GCC 3.1 one:


ksymoops 2.4.4 on i686 2.5.18.  Options used
       -v /usr/src/linux-2.5.19/vmlinux (specified)
       -K (specified)
       -L (specified)
       -o /lib/modules/2.5.19 (specified)
       -m /boot/System.map-2.5.19 (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c02cd3db>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: cff57720   ebx: c13b69ec   ecx: c13b6800   edx: c0207846
esi: c02f6794   edi: c13b6800   ebp: c13b6800   esp: cff5bb18
ds: 0018   es: 0018   ss: 0018
Stack: 0000000b 00000003 0000000b c13b6800 00026572 00038001 115dffff 00000000
         00000000 00000000 00000000 cff57720 00000000 00000000 00000000 00000002
         00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c02043c7>] [<c020430f>] [<c0204286>] [<c0205ad7>] [<c0204c9a>]
              [<c0120290>] [<c011d7e2>] [<c011d7c5>] [<c0207f50>] [<c0105000>] [<c011d6c7>]
              [<c0105000>] [<c0105081>] [<c0105000>] [<c01057de>] [<c0105060>]
Code: 62 6f 72 61 74 6f 72 79 00 54 72 69 54 65 63 68 00 54 65 78

  >>EIP; c02cd3db <timer_bug_msg+227db/2b9a0>   <=====
Trace; c02043c7 <unreset_socket+a7/140>
Trace; c020430f <reset_socket+4f/60>
Trace; c0204286 <setup_socket+b6/f0>
Trace; c0205ad7 <pcmcia_register_client+277/2a0>
Trace; c0204c9a <pcmcia_bind_device+8a/f0>
Trace; c0120290 <process_timeout+0/10>
Trace; c011d7e2 <register_proc_table+b2/130>
Trace; c011d7c5 <register_proc_table+95/130>
Trace; c0207f50 <ds_event+0/90>
Trace; c0105000 <_stext+0/0>
Trace; c011d6c7 <register_sysctl_table+67/90>
Trace; c0105000 <_stext+0/0>
Trace; c0105081 <init+21/190>
Trace; c0105000 <_stext+0/0>
Trace; c01057de <kernel_thread+2e/40>
Trace; c0105060 <init+0/190>
Code;  c02cd3db <timer_bug_msg+227db/2b9a0>
00000000 <_EIP>:
Code;  c02cd3db <timer_bug_msg+227db/2b9a0>   <=====
     0:   62 6f 72                  bound  %ebp,0x72(%edi)   <=====
Code;  c02cd3de <timer_bug_msg+227de/2b9a0>
     3:   61                        popa
Code;  c02cd3df <timer_bug_msg+227df/2b9a0>
     4:   74 6f                     je     75 <_EIP+0x75> c02cd450 <timer_bug_msg+22850/2b9a0>
Code;  c02cd3e1 <timer_bug_msg+227e1/2b9a0>
     6:   72 79                     jb     81 <_EIP+0x81> c02cd45c <timer_bug_msg+2285c/2b9a0>
Code;  c02cd3e3 <timer_bug_msg+227e3/2b9a0>
     8:   00 54 72 69               add    %dl,0x69(%edx,%esi,2)
Code;  c02cd3e7 <timer_bug_msg+227e7/2b9a0>
     c:   54                        push   %esp
Code;  c02cd3e8 <timer_bug_msg+227e8/2b9a0>
     d:   65 63 68 00               arpl   %bp,%gs:0x0(%eax)
Code;  c02cd3ec <timer_bug_msg+227ec/2b9a0>
    11:   54                        push   %esp
Code;  c02cd3ed <timer_bug_msg+227ed/2b9a0>
    12:   65                        gs
Code;  c02cd3ee <timer_bug_msg+227ee/2b9a0>
    13:   78 00                     js     15 <_EIP+0x15> c02cd3f0 <timer_bug_msg+227f0/2b9a0>


--alessandro

   "the hands that build / can also pull down
     even the hands of love"
                              (U2, "Exit")


