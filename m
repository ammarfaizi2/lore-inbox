Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSDDHAz>; Thu, 4 Apr 2002 02:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311244AbSDDHAq>; Thu, 4 Apr 2002 02:00:46 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:23936 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S311239AbSDDHAl>;
	Thu, 4 Apr 2002 02:00:41 -0500
Message-ID: <3CABFA10.9060707@tmsusa.com>
Date: Wed, 03 Apr 2002 23:00:32 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: arjan@fenrus.demon.nl, "Axel H. Siebenwirth" <axel@hh59.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another BUG in page_alloc.c:108
In-Reply-To: <Pine.LNX.4.44.0204040817240.10620-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I was all wet - so the nvidia driver is
implicated after all...

Joe

Zwane Mwaikambo wrote:

>On Wed, 3 Apr 2002 arjan@fenrus.demon.nl wrote:
>
>>In article <20020403035406.GA2925@neon> you wrote:
>>
>>>EIP:    0010:[__free_pages_ok+45/688]    Tainted: P 
>>>
>>Nvidia ? 
>>I get the distinct impression that the lastest nvidia drivers
>>reintroduced a bug that fubars the page allocator ;(
>>
>
>The latest nvidia stuff definately spews major chunks on its way out...
>
>This is on 2.4.19-pre2-ac3, backing upto the previous release nvidia 
>drivers i can't reproduce.
>
>invalid operand: 0000
>CPU:    0
>EIP:    0010:[<c0130c47>]    Not tainted
>EFLAGS: 00013282
>eax: 00000000   ebx: c15f94b0   ecx: c100000c   edx: db140eb0
>esi: 00000000   edi: 00000000   ebp: 00007000   esp: deb35edc
>ds: 0018   es: 0018   ss: 0018
>Process X (pid: 1457, stackpage=deb35000)
>Stack: c0306380 c15f94b0 00000000 00000001 c15f94b0 00008000 c15f94b0 
>c15f94b0 
>       00008000 debb5688 00007000 c0124782 c15f94b0 1d68d027 00000008 
>00000000 
>       425a3000 de793424 4259b000 00000000 425a3000 de793424 dfffcd50 
>dec00420 
>Call Trace: [<c0124782>] [<c01270ed>] [<c01271a2>] [<c0106f2b>] 
>
>Code: 0f 0b c6 43 24 05 8b 43 18 89 f1 83 e0 eb 89 43 18 c1 e8 18
>
>>>EIP; c0130c47 <__free_pages_ok+97/250>   <=====
>>>
>Trace; c0124782 <zap_page_range+192/260>
>Trace; c01270ed <do_munmap+1ed/270>
>Trace; c01271a2 <sys_munmap+32/50>
>Trace; c0106f2b <system_call+33/38>
>Code;  c0130c47 <__free_pages_ok+97/250>
>00000000 <_EIP>:
>Code;  c0130c47 <__free_pages_ok+97/250>   <=====
>   0:   0f 0b                     ud2a      <=====
>Code;  c0130c49 <__free_pages_ok+99/250>
>   2:   c6 43 24 05               movb   $0x5,0x24(%ebx)
>Code;  c0130c4d <__free_pages_ok+9d/250>
>   6:   8b 43 18                  mov    0x18(%ebx),%eax
>Code;  c0130c50 <__free_pages_ok+a0/250>
>   9:   89 f1                     mov    %esi,%ecx
>Code;  c0130c52 <__free_pages_ok+a2/250>
>   b:   83 e0 eb                  and    $0xffffffeb,%eax
>Code;  c0130c55 <__free_pages_ok+a5/250>
>   e:   89 43 18                  mov    %eax,0x18(%ebx)
>Code;  c0130c58 <__free_pages_ok+a8/250>
>  11:   c1 e8 18                  shr    $0x18,%eax
>
>0xc0130c40 <__free_pages_ok+144>:       mov    0x28(%ebx),%edx
>0xc0130c43 <__free_pages_ok+147>:       test   %edx,%edx
>0xc0130c45 <__free_pages_ok+149>:       je     0xc0130c49 
><__free_pages_ok+153>
>0xc0130c47 <__free_pages_ok+151>:       ud2a
>
>if (page->pte_chain)
>                BUG();
>
>



