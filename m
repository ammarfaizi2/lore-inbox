Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTFEVBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbTFEVBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:01:09 -0400
Received: from web9607.mail.yahoo.com ([216.136.129.186]:28946 "HELO
	web9607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265125AbTFEU75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:59:57 -0400
Message-ID: <20030605211328.58022.qmail@web9607.mail.yahoo.com>
Date: Thu, 5 Jun 2003 14:13:28 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Swapoff w/regular file causes Oops
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030605173453.GA3291@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You didn't run that through ksymoops...

Did you try the program? Does it Oops for you? 

Here's the info from ksymoops:

>>EIP; c0149985 <path_release+15/30>   <=====
                                                           
                    
>>eax; c1ac6f84 <_end+171cf04/10462fe0>
>>ebx; ce261f90 <_end+deb7f10/10462fe0>
>>ecx; ffffffff <END_OF_CODE+2f685ba0/????>
>>edx; 00200246 Before first symbol
>>edi; ffffffea <END_OF_CODE+2f685b8b/????>
>>ebp; c503f4e0 <_end+4c95460/10462fe0>
>>esp; ce261f84 <_end+deb7f04/10462fe0>
                                                           
                    
Trace; c013a831 <sys_swapoff+191/260>
Trace; c013f2f0 <sys_open+70/80>
Trace; c0109103 <system_call+33/40>
                                                           
                    
Code;  c0149985 <path_release+15/30>
00000000 <_EIP>:
Code;  c0149985 <path_release+15/30>   <=====
   0:   ff 4a 28                  decl   0x28(%edx)  
<=====
Code;  c0149988 <path_release+18/30>
   3:   0f 94 c0                  sete   %al
Code;  c014998b <path_release+1b/30>
   6:   84 c0                     test   %al,%al
Code;  c014998d <path_release+1d/30>
   8:   75 02                     jne    c <_EIP+0xc>
Code;  c014998f <path_release+1f/30>
   a:   5b                        pop    %ebx
Code;  c0149990 <path_release+20/30>
   b:   c3                        ret
Code;  c0149991 <path_release+21/30>
   c:   89 54 24 08               mov    %edx,0x8(%esp,1)
Code;  c0149995 <path_release+25/30>
  10:   5b                        pop    %ebx
Code;  c0149996 <path_release+26/30>
  11:   e9 65 c3 00 00            jmp    c37b <_EIP+0xc37b>
                                                           
                    
                                                           
                 2 warnings and 3 errors issued.  Results
may not be reliable.

Curiously, the brand new RH 2.4.20-18.9 kernel produces 2
Oops from the one program. When I run it from a gnome
terminal, this is what comes immediately after the first
Oops:

>>EIP; c0134973 <__kmem_cache_alloc+73/e0>   <=====
                                                           
                    
>>eax; 84ac6f83 Before first symbol
>>ebx; c1a61000 <_end+16b6f80/10462fe0>
>>ecx; c1ac1f20 <_end+1717ea0/10462fe0>
>>edx; c1ac6f8c <_end+171cf0c/10462fe0>
>>esi; c1ac6f84 <_end+171cf04/10462fe0>
>>edi; 00200246 Before first symbol
>>ebp; c1a61000 <_end+16b6f80/10462fe0>
>>esp; c8caff40 <_end+8905ec0/10462fe0>
                                                           
                    
Trace; c013432f <kmem_cache_alloc+f/20>
Trace; c014972d <getname+1d/b0>
Trace; c014a5ee <__user_walk+e/40>
Trace; c0146aa6 <sys_readlink+26/90>
Trace; c011e9a2 <sys_gettimeofday+22/60>
Trace; c0109103 <system_call+33/40>
                                                           
                    Code;  c0134973
<__kmem_cache_alloc+73/e0>
00000000 <_EIP>:
Code;  c0134973 <__kmem_cache_alloc+73/e0>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)  
<=====
Code;  c0134976 <__kmem_cache_alloc+76/e0>
   3:   89 71 04                  mov    %esi,0x4(%ecx)
Code;  c0134979 <__kmem_cache_alloc+79/e0>
   6:   eb d9                     jmp    ffffffe1
<_EIP+0xffffffe1>
Code;  c013497b <__kmem_cache_alloc+7b/e0>
   8:   8d 46 10                  lea    0x10(%esi),%eax
Code;  c013497e <__kmem_cache_alloc+7e/e0>
   b:   8b 4e 10                  mov    0x10(%esi),%ecx
Code;  c0134981 <__kmem_cache_alloc+81/e0>
   e:   39 c1                     cmp    %eax,%ecx
Code;  c0134983 <__kmem_cache_alloc+83/e0>
  10:   74 20                     je     32 <_EIP+0x32>
Code;  c0134985 <__kmem_cache_alloc+85/e0>
  12:   8b 41 00                  mov    0x0(%ecx),%eax
                                                           
                    
                                                           
                   2 warnings and 3 errors issued.  Results
may not be reliable.

It would be nice to get confirmation as to this being a
generic problem or just a RH problem. Can someone running
another distro or plain vanilla kernel > 2.4.18 give the
program a try?
http://marc.theaimsgroup.com/?l=linux-kernel&m=105388560111905&w=2

Thanks,
Steve Grubb

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
