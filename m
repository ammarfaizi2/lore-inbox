Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbTAQS06>; Fri, 17 Jan 2003 13:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267630AbTAQS05>; Fri, 17 Jan 2003 13:26:57 -0500
Received: from cynosure.colorado-research.com ([65.171.192.72]:900 "EHLO
	cynosure.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267629AbTAQS04>; Fri, 17 Jan 2003 13:26:56 -0500
Message-ID: <3E284D07.1000307@cora.nwra.com>
Date: Fri, 17 Jan 2003 11:35:51 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Burton Windle <bwindle@fint.org>,
       "''Linux Kernel Mailing List ' '" <linux-kernel@vger.kernel.org>
Subject: Re: kswapd in D uninterruptible sleep on 2.4.21-pre3-ac2
References: <Pine.LNX.4.43.0301171150220.1037-100000@morpheus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle wrote:

>Lots of people have reported strange oops in the 2.4.21-pre3-ac* kernels,
>I wouldn't advise running them. Stick with 21-pre3 for now :)
>
>  
>
Hmm, you may be right.  I just noticed the following oops in the log. 
 Passing along to the list incase it's of any use.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0135722
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0135722>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c18fc1b0   ecx: f6144000   edx: f614405c
esi: efeb3000   edi: 00000000   ebp: efeb3040   esp: f6145d64
ds: 0018   es: 0018   ss: 0018
Process idl (pid: 2645, stackpage=f6145000)
Stack: 00000100 c0303030 00000080 00000002 f7f9ad80 00000046 c01a411c 
f7fb3450
       efeb3000 cccccccd efeb3040 c013295a f7fb3450 0000002a cccccccd 
f7ffd600
       c0133cd9 f7fb3450 efeb3040 00000001 f7fb3458 f7fb3460 00000086 
f6144000
Call Trace:    [<c01a411c>] [<c013295a>] [<c0133cd9>] [<c0134e79>] 
[<c0134f2c>]
  [<c0135a10>] [<c0135ccb>] [<c020388f>] [<c012a9bc>] [<c012aac4>] 
[<c012ace2>]
  [<c013b195>] [<c012e38a>] [<c011642a>] [<f89f2bdb>] [<c01ac390>] 
[<c013d20e>]
  [<c010a48c>] [<c010a6a3>] [<c010a6c5>] [<c0116310>] [<c0108c24>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 7b 0c ff 41 68 83 c4 1c

 >>EIP; c0135722 <__free_pages_ok+282/2a0>   <=====
Trace; c01a411c <ide_set_handler+5c/70>
Trace; c013295a <kmem_slab_destroy+aa/d0>
Trace; c0133cd9 <kmem_cache_reap+2b9/330>
Trace; c0134e79 <shrink_caches+19/90>
Trace; c0134f2c <try_to_free_pages_zone+3c/60>
Trace; c0135a10 <balance_classzone+60/200>
Trace; c0135ccb <__alloc_pages+11b/170>
Trace; c020388f <fast_clear_page+2f/60>
Trace; c012a9bc <do_anonymous_page+3c/110>
Trace; c012aac4 <do_no_page+34/1f0>
Trace; c012ace2 <handle_mm_fault+62/d0>
Trace; c013b195 <bounce_end_io_write+85/c0>
Trace; c012e38a <generic_file_read+7a/110>
Trace; c011642a <do_page_fault+11a/41b>
Trace; f89f2bdb <[nfs]nfs_file_read+8b/a0>
Trace; c01ac390 <write_intr+0/1a0>
Trace; c013d20e <sys_read+fe/110>
Trace; c010a48c <handle_IRQ_event+5c/90>
Trace; c010a6a3 <do_IRQ+a3/f0>
Trace; c010a6c5 <do_IRQ+c5/f0>
Trace; c0116310 <do_page_fault+0/41b>
Trace; c0108c24 <error_code+34/3c>
Code;  c0135722 <__free_pages_ok+282/2a0>
00000000 <_EIP>:
Code;  c0135722 <__free_pages_ok+282/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0135725 <__free_pages_ok+285/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0135727 <__free_pages_ok+287/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c013572a <__free_pages_ok+28a/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c013572d <__free_pages_ok+28d/2a0>
   b:   89 7b 0c                  mov    %edi,0xc(%ebx)
Code;  c0135730 <__free_pages_ok+290/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c0135733 <__free_pages_ok+293/2a0>
  11:   83 c4 1c                  add    $0x1c,%esp

# lsmod
Module                  Size  Used by    Not tainted
nfs                    78364   3  (autoclean)
nfsd                   78144   8  (autoclean)
lockd                  57376   1  (autoclean) [nfs nfsd]
sunrpc                 82356   1  (autoclean) [nfs nfsd lockd]
autofs                 11972   5  (autoclean)
w83781d                22560   0  (unused)
i2c-proc                8512   0  [w83781d]
i2c-amd756              4996   0  (unused)
i2c-core               22568   0  [w83781d i2c-proc i2c-amd756]
3c59x                  30856   1
st                     31028   0  (unused)
md                     52800   0  (unused)
ext3                   70208   4
jbd                    51968   4  [ext3]
sym53c8xx              74392   2
sd_mod                 13244   4
scsi_mod              122544   3  [st sym53c8xx sd_mod]

# uname -a
Linux moli 2.4.21-pre3-ac2 #2 SMP Thu Jan 9 13:07:18 MST 2003 i686 unknown


