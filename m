Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTAJI2b>; Fri, 10 Jan 2003 03:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTAJI2b>; Fri, 10 Jan 2003 03:28:31 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:45974 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264644AbTAJI2a>; Fri, 10 Jan 2003 03:28:30 -0500
Date: Fri, 10 Jan 2003 00:37:14 -0800
From: Anthony Lau <anthony@greyweasel.com>
Subject: Kernel Oops with HIMEM+VM in 2.4.19,20
To: linux-kernel@vger.kernel.org
Message-id: <20030110083714.GA702@kimagure>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am getting reproducible kernel oops and random segmentation
faults whenever the kernel starts using VM. Without any VM pages
being used, the system is stable.

I have tested kernels compiled with and without HIMEM support
(all other kernel config options identical). Without HIMEM 4GB
support, the system is stable for weeks. With HIMEM 4GB support,
the system starts oops'ing and seg. faulting when VM starts
being used.

My system info:

1.5GB physical RAM (MemTest86 run for 2 times, no errors)
2.0GB VM on a partition
Aopen AX34u with Via Apollo Pro 133T chipset

Sample Oops from logs:
Jan  8 08:53:59 kimagure kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000317
Jan  8 08:53:59 kimagure kernel:  printing eip:
Jan  8 08:53:59 kimagure kernel: c0146053
Jan  8 08:53:59 kimagure kernel: *pde = 00000000
Jan  8 08:53:59 kimagure kernel: Oops: 0000
Jan  8 08:53:59 kimagure kernel: CPU:    0
Jan  8 08:53:59 kimagure kernel: EIP:    0010:[free_kiovec+83/108]    Not tainted
Jan  8 08:53:59 kimagure kernel: EFLAGS: 00010202
Jan  8 08:53:59 kimagure kernel: eax: 00000000   ebx: df7dcc34   ecx: df7dcc44   edx: df7dcc44
Jan  8 08:53:59 kimagure kernel: esi: f6784800   edi: 00000307   ebp: 00000c59   esp: c222df4c
Jan  8 08:53:59 kimagure kernel: ds: 0018   es: 0018   ss: 0018
Jan  8 08:53:59 kimagure kernel: Process kswapd (pid: 5, stackpage=c222d000)
Jan  8 08:53:59 kimagure kernel: Stack: de765b48 de765b30 df7dcc34 c0144226 df7dcc34 00000011 000001d0 00000020 
Jan  8 08:53:59 kimagure kernel:        00000006 c01444eb 000056a6 c012d760 00000006 000001d0 00000006 000001d0 
Jan  8 08:53:59 kimagure kernel:        c03180c8 00000000 c03180c8 c012d7af 00000020 c03180c8 00000002 c222c000 
Jan  8 08:53:59 kimagure kernel: Call Trace:    [destroy_inode+22/44] [sync_inodes_sb+159/468] [rw_swap_page_base+32/296]
[rw_swap_p
age_base+111/296] [rw_swap_page_base+259/296]
Jan  8 08:53:59 kimagure kernel:   [rw_swap_page+54/72] [__free_pages_ok+109/612] [kernel_thread+40/56]
Jan  8 08:53:59 kimagure kernel: 
Jan  8 08:53:59 kimagure kernel: Code: 8b 47 10 85 c0 74 06 53 ff d0 83 c4 04 ff 4b 2c 0f 94 c0 84 

Because of the symptoms, I think that there could be some
incompatibility between Himem and the VM subsystem. Of course
I may have just configured my kernel incorrectly.

Any help is appreciated and I will gladly supply more logs
if I knew which ones would be useful.

Thanks,

Anthony Lau
