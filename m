Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315542AbSECCxr>; Thu, 2 May 2002 22:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315543AbSECCxr>; Thu, 2 May 2002 22:53:47 -0400
Received: from saltbush.adelaide.edu.au ([129.127.43.5]:24725 "EHLO
	saltbush.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S315542AbSECCxq>; Thu, 2 May 2002 22:53:46 -0400
From: "Hong-Gunn Chew" <hgchewML@optusnet.com.au>
To: "'Petr Vandrovec'" <VANDROVE@vc.cvut.cz>,
        "'Andrea Arcangeli'" <andrea@suse.de>
Cc: "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        <riel@conectiva.com.br>
Subject: RE: Memory corruption when running VMware. (was File curruption when running VMware)
Date: Fri, 3 May 2002 12:23:35 +0930
Message-ID: <001701c1f24d$b7e50e10$241d7f81@hgclaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <37A7BD60863@vcnet.vc.cvut.cz>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr, Andrea,

Petr wrote:
>   So if you have >890MB of RAM and your kernel is compiled 
> with support for pte in high memory, please stop using 
> VMware, or reconfigure your 
> kernel to not use pte in high memory (4GB config without 
> pte-in-highmem is OK). Using pte-in-highmem with vmmon will 
> cause kernel oopses and/or 
> memory corruption :-(

I have been trying different kernel configurations to overcome this
problem.  I found that turning on APIC seem to work properly.  However
turning on IO-APIC causes it to hang just after X is started, which
seems to be during the startup of gdm.
I do have a silly question to ask though.  How do I compile the kernel
NOT to use pte in high memory?

Andrea wrote:
> passing to the kernel mem=850M in lilo at boot will be enough.

This did not work as it causes vmware to seg fault with a kernel oops:
	Unable to handle kernel paging request at virtual address
ffffe350
	 printing eip:
	f61ff30a
	*pde = 00001063
	*pte = 00000000
	Oops: 0000
	CPU:    0
	EIP:
0010:[nls_iso8859-1:__insmod_nls_iso8859-1_S.data_L2336+139562/11435686]
Tainted: PF
	EIP:    0010:[<f61ff30a>]    Tainted: PF
	EFLAGS: 00013286
	eax: ffffe350   ebx: e7652600   ecx: ffffe350   edx: 000000d0
	esi: e7652600   edi: 00000069   ebp: e7625de8   esp: e7625de8
	ds: 0018   es: 0018   ss: 0018
	Process vmware (pid: 2595, stackpage=e7625000)
	Stack: e7625e08 f61ff34d ffffe350 c02f8ee0 e7625e2c f5095a00
000000d0 e6d21000  
	       e7625eb8 f61ff41f e7652600 e7625e8d e7625e8e e7625e8f
e7625e40 00003286  
	       00003286 efe78d80 000001f0 00000000 e7589a80 c01e330f
000000bc 000001f0
	Call Trace:
[nls_iso8859-1:__insmod_nls_iso8859-1_S.data_L2336+139629/11435619]
[nls_iso8859-1:__insmod_nls_iso8859-1_S.data_L2336+139839/11435409]
[sys_sendmsg+303/480] [wait_for_buffers+86/144]
[nls_iso8859-1:__insmod_nls_iso8859-1_S.data_L2336+137406/11437842]
	Call Trace: [<f61ff34d>] [<f61ff41f>] [<c01e330f>] [<c0134a36>]
[<f61fea9e>]
	
[nls_iso8859-1:__insmod_nls_iso8859-1_S.data_L2336+132081/11443167]
[generic_file_readahead+288/304] [bounce_end_io_read+164/288]
[isapnp_set_mem+23/272] [vfs_link+23/256] [system_call+51/56]
	   [<f61fd5d1>] [<c01272b0>] [<c0131e94>] [<c01e0527>]
[<c013e487>]  [<c0106f0b>]
	
	Code: 8b 11 89 d0 25 00 07 01 00 3d 00 04 00 00 75 12 81 ca 00
00

Cheers,
Hong-Gunn

