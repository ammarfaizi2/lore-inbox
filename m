Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135513AbREDAev>; Thu, 3 May 2001 20:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135521AbREDAel>; Thu, 3 May 2001 20:34:41 -0400
Received: from Huntington-Beach.blue-labs.org ([208.179.59.198]:34599 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135513AbREDAea>; Thu, 3 May 2001 20:34:30 -0400
Message-ID: <3AF1F8C0.8070007@blue-labs.org>
Date: Thu, 03 May 2001 17:33:04 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9+) Gecko/20010503
X-Accept-Language: en
MIME-Version: 1.0
To: linux-drivers@lists.quicknet.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Quicknet PhoneJACK usage in 2.4.4 isn't a good thing
In-Reply-To: <3AF1C946.6060602@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the followup with the CVS (5/3/2001) version of ixj.o and 
phonedev.o.  First inbound call was fine, answered, sent voice data, 
pushed buttons, all is well.  Second inbound call crashed the modules.  
All further attempts to route a call to it have failed.

Unable to handle kernel paging request at virtual address d14f42c0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d0a9f507>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00a44fac   ebx: d14f336c   ecx: 00000018   edx: 00000004
esi: 0000082f   edi: cc9f3df9   ebp: cc9f3d58   esp: cc9f3d4c
ds: 0018   es: 0018   ss: 0018
Process gnophone (pid: 3456, stackpage=cc9f3000)
Stack: 00000095 0000082f cc9f3df9 cc9f3d88 d0a9f6ab 0000082f 00000000 
c0438d80
      c02a67f6 00000060 d0aaf3cd ca53a5e0 00000246 00000000 0813e3c0 
cc9f3e98
      d0a9fcb6 0000082f 00000007 c029f748 ca53a5e0 00000000 0813e3c0 
d0aaf404
Call Trace: [<d0a9f6ab>] [<c02a67f6>] [<d0aaf3cd>] [<d0a9fcb6>] 
[<c029f748>] [<d0aaf404>] [<c02a746d>]
      [<c02a7b24>] [<d0aae3c0>] [<f8081e08>] [<c02953df>] [<d0aae3c0>] 
[<c01a8bb9>] [<c01a8c54>] [<c029727b>]
      [<c029728f>] [<c0297403>] [<c029a9e7>] [<c0117a02>] [<c013b79f>] 
[<c0106a53>] [<c010002b>]
Code: 80 bb 54 0f 00 00 13 77 5f 8b 75 0c c1 e6 04 2b 75 0c c1 e6

 >>EIP; d0a9f507 <[ixj]ixj_write_cid_bit+13/cc>   <=====
Trace; d0a9f6ab <[ixj]ixj_write_cid_seize+1b/50>
Trace; c02a67f6 <ip_output+10e/114>
Trace; d0aaf3cd <[ixj]__module_parm_xio+f32/14065>
Trace; d0a9fcb6 <[ixj]ixj_write_cid+20a/3a4>
Trace; c029f748 <nf_hook_slow+ec/134>
Trace; d0aaf404 <[ixj]__module_parm_xio+f69/14065>
Trace; c02a746d <ip_build_xmit+2e5/36c>
Trace; c02a7b24 <output_maybe_reroute+0/14>
Trace; d0aae3c0 <[ixj]__module_kernel_version+0/0>
Trace; f8081e08 <END_OF_CODE+275bf8f5/????>
Trace; c02953df <sys_sendto+df/f0>
Trace; d0aae3c0 <[ixj]__module_kernel_version+0/0>
Trace; c01a8bb9 <write_chan+161/214>
Trace; c01a8c54 <write_chan+1fc/214>
Trace; c029727b <skb_release_data+67/70>
Trace; c029728f <kfree_skbmem+b/54>
Trace; c0297403 <__kfree_skb+12b/134>
Trace; c029a9e7 <net_tx_action+4b/9c>
Trace; c0117a02 <do_softirq+42/64>
Trace; c013b79f <sys_ioctl+15f/174>
Trace; c0106a53 <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>

Code;  d0a9f507 <[ixj]ixj_write_cid_bit+13/cc> 00000000 <_EIP>:
Code;  d0a9f507 <[ixj]ixj_write_cid_bit+13/cc>   <=====
  0:   80 bb 54 0f 00 00 13      cmpb   $0x13,0xf54(%ebx)   <=====
Code;  d0a9f50e <[ixj]ixj_write_cid_bit+1a/cc>
  7:   77 5f                     ja     68 <_EIP+0x68> d0a9f56f 
<[ixj]ixj_write_cid_bit+7b/cc>
Code;  d0a9f510 <[ixj]ixj_write_cid_bit+1c/cc>
  9:   8b 75 0c                  mov    0xc(%ebp),%esi
Code;  d0a9f513 <[ixj]ixj_write_cid_bit+1f/cc>
  c:   c1 e6 04                  shl    $0x4,%esi
Code;  d0a9f516 <[ixj]ixj_write_cid_bit+22/cc>
  f:   2b 75 0c                  sub    0xc(%ebp),%esi
Code;  d0a9f519 <[ixj]ixj_write_cid_bit+25/cc>
  12:   c1 e6 00                  shl    $0x0,%esi



