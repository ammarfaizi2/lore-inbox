Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318941AbSHSR2j>; Mon, 19 Aug 2002 13:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318949AbSHSR2j>; Mon, 19 Aug 2002 13:28:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19663 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318941AbSHSR2i>; Mon, 19 Aug 2002 13:28:38 -0400
Subject: Re: [Lse-tech] LTP-Nightly bk test
From: Paul Larson <plars@austin.ibm.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au
In-Reply-To: <2553170000.1029775843@flay>
References: <1029768156.2582.113.camel@plars.austin.ibm.com> 
	<2553170000.1029775843@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Aug 2002 12:24:42 -0500
Message-Id: <1029777883.4073.4.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 11:50, Martin J. Bligh wrote:
> > page allocation failure. order:0, mode:0x50
> > 
> > The test was: 'mtest01 -p80 -w' which will essentially allocate up to
> > 80% of the memory and write to it.  I'll keep pounding on it with LTP to
> > see if I can reproduce the swap.c:80 oops.
> 
> I think akpm posted a patch for similar mem exhaustion a few days ago,
> but I can't find it at the moment. Would be interesting to see what 
> /proc/meminfo and /proc/slabinfo look like as you march to your death ;-)
Anyone know where to find that patch?  I'll look at doing this again
while grabbing those files periodically.  I ran this again though and
got a different error:

kernel BUG at page_alloc.c:97!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c013252a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 02000150   ebx: c232aa14   ecx: c232aa14   edx: c232aa14
esi: 000001fb   edi: 00000000   ebp: f713d8a0   esp: f7093eb4
ds: 0068   es: 0068   ss: 0068
Stack: c232aa14 000001fb 00114000 f713d8a0 c232aa14 00047ffb c232aa6c
c232aac4
       c19a001c c03b7b00 00000207 ffffffff 0003783b 0001bc1d c0131079
c232aa14
       000001fb c01337cf 000001d6 c012708d c232aa14 63c00000 80000000
c3c388f0
Call Trace: [<c0131079>] [<c01337cf>] [<c012708d>] [<c0127135>]
[<c012718d>]
   [<c012a2a6>] [<c011658d>] [<c011b448>] [<c011b68a>] [<c01073e3>]
Code: 0f 0b 61 00 0d c7 31 c0 8b 5c 24 10 8b 03 f6 c4 20 74 08 0f

>>EIP; c013252a <__free_pages_ok+8a/330>   <=====
Trace; c0131078 <__page_cache_release+c4/c8>
Trace; c01337ce <free_page_and_swap_cache+42/48>
Trace; c012708c <zap_pte_range+24c/2a8>
Trace; c0127134 <zap_pmd_range+4c/68>
Trace; c012718c <unmap_page_range+3c/5c>
Trace; c012a2a6 <exit_mmap+ea/208>
Trace; c011658c <mmput+48/60>
Trace; c011b448 <do_exit+d8/2f4>
Trace; c011b68a <sys_exit+e/10>
Trace; c01073e2 <syscall_call+6/a>
Code;  c013252a <__free_pages_ok+8a/330>
00000000 <_EIP>:
Code;  c013252a <__free_pages_ok+8a/330>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013252c <__free_pages_ok+8c/330>
   2:   61                        popa
Code;  c013252c <__free_pages_ok+8c/330>
   3:   00 0d c7 31 c0 8b         add    %cl,0x8bc031c7
Code;  c0132532 <__free_pages_ok+92/330>
   9:   5c                        pop    %esp
Code;  c0132534 <__free_pages_ok+94/330>
   a:   24 10                     and    $0x10,%al
Code;  c0132536 <__free_pages_ok+96/330>
   c:   8b 03                     mov    (%ebx),%eax
Code;  c0132538 <__free_pages_ok+98/330>
   e:   f6 c4 20                  test   $0x20,%ah
Code;  c013253a <__free_pages_ok+9a/330>
  11:   74 08                     je     1b <_EIP+0x1b> c0132544
<__free_pages_ok+a4/330>
Code;  c013253c <__free_pages_ok+9c/330>
  13:   0f 00 00                  sldt   (%eax)

