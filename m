Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277144AbRJLBVm>; Thu, 11 Oct 2001 21:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRJLBVc>; Thu, 11 Oct 2001 21:21:32 -0400
Received: from adsl-64-166-152-214.dsl.snfc21.pacbell.net ([64.166.152.214]:12042
	"EHLO gw.yeah.cx") by vger.kernel.org with ESMTP id <S277142AbRJLBVQ> convert rfc822-to-8bit;
	Thu, 11 Oct 2001 21:21:16 -0400
Date: Thu, 11 Oct 2001 18:24:45 -0700
From: Andrew Over <ajo@acm.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on removing via-rhine [2.4.10-ac11]
Message-ID: <20011011182445.A12015@yeah.cx>
Reply-To: Andrew Over <ajo@acm.org>
In-Reply-To: <20011011140943.A10576@yeah.cx> <32326.1002845066@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <32326.1002845066@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.20i
X-OS: Linux 2.4.5-ac17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 10:04:26AM +1000, Keith Owens wrote:

> Oops in module delete may not get the symbol tables for the deleted
> module if they have already been removed from /proc/ksyms.  I suggest
> you create /var/log/ksymoops, man insmod.  Then insmod and rmmod will
> save the symbol tables after each module load or unload, you can point
> ksymoops at the saved symbols from before the failing rmmod.  That will
> give a better ksymoops decode.

Thanks for that.  Already setup courtesy of Debian.

Revised oops as follows:

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129841>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c18542d0   ebx: 00000000   ecx: c18542d0   edx: 00000000
esi: c1896c00   edi: c18542d0   ebp: bfffe8fc   esp: dcb6df28
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 6729, stackpage=dcb6d000)
Stack: dfbfa400 c1896c00 dfbfa540 bfffe8fc ed0800ff 0000001c c1896c00 c01acd3f 
       c0129f1a c0129f44 c010b6bd e08fdbab c1896c00 00000200 df5b0000 1f5b0000 
       c1896c00 dfbfa400 c1896c00 e08fe860 e08fc000 c01ad01f c1896c00 e08fc000 
Call Trace: [<c01acd3f>] [<c0129f1a>] [<c0129f44>] [<c010b6bd>] [<e08fdbab>] 
   [<e08fe860>] [<c01ad01f>] [<e08fdc0a>] [<e08fe860>] [<c01150c7>] [<c0114457>] 
   [<c0106c4b>] 
Code: 0f 0b 8b 57 08 85 d2 74 02 0f 0b 89 f8 2b 05 2c 04 27 c0 69 

>>EIP; c0129840 <__free_pages_ok+10/1c0>   <=====
Trace; c01acd3e <pci_release_regions+6e/80>
Trace; c0129f1a <__free_pages+1a/20>
Trace; c0129f44 <free_pages+24/30>
Trace; c010b6bc <pci_free_consistent+1c/20>
Trace; e08fdbaa <[via-rhine]via_rhine_remove_one+2a/40>
Trace; e08fe860 <[via-rhine]via_rhine_driver+0/3e>
Trace; c01ad01e <pci_unregister_driver+3e/60>
Trace; e08fdc0a <[via-rhine]via_rhine_cleanup+a/10>
Trace; e08fe860 <[via-rhine]via_rhine_driver+0/3e>
Trace; c01150c6 <free_module+16/a0>
Trace; c0114456 <sys_delete_module+f6/1c0>
Trace; c0106c4a <system_call+32/38>
Code;  c0129840 <__free_pages_ok+10/1c0>
00000000 <_EIP>:
Code;  c0129840 <__free_pages_ok+10/1c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129842 <__free_pages_ok+12/1c0>
   2:   8b 57 08                  mov    0x8(%edi),%edx
Code;  c0129844 <__free_pages_ok+14/1c0>
   5:   85 d2                     test   %edx,%edx
Code;  c0129846 <__free_pages_ok+16/1c0>
   7:   74 02                     je     b <_EIP+0xb> c012984a <__free_pages_ok+1a/1c0>
Code;  c0129848 <__free_pages_ok+18/1c0>
   9:   0f 0b                     ud2a   
Code;  c012984a <__free_pages_ok+1a/1c0>
   b:   89 f8                     mov    %edi,%eax
Code;  c012984c <__free_pages_ok+1c/1c0>
   d:   2b 05 2c 04 27 c0         sub    0xc027042c,%eax
Code;  c0129852 <__free_pages_ok+22/1c0>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

--Andrew
