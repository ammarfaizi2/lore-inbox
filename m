Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbQKHGtl>; Wed, 8 Nov 2000 01:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQKHGtb>; Wed, 8 Nov 2000 01:49:31 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:29564 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130485AbQKHGtW>; Wed, 8 Nov 2000 01:49:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Hanselman <mjhans@quiq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: fs problem in 2.4.0-test10 -- oops in directory access 
In-Reply-To: Your message of "Wed, 08 Nov 2000 00:38:33 MDT."
             <Pine.LNX.4.21.0011080037370.23104-100000@c3po.central.quiq.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 17:48:45 +1100
Message-ID: <8096.973666125@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000 00:38:33 -0600 (CST), 
Matthew Hanselman <mjhans@quiq.com> wrote:
>I can poke around tomorrow morning without a reboot, but then I'll have to
>reboot (so please respond via email if I can do anything).  I tried
>grinding the message through ksymoops-2.3.5, and it complains with this
>error:
>
>Warning (Oops_code): trailing garbage ignored on Code: line
>  Text: 'Code:  Bad EIP value. '
>  Garbage: 'IP value. '
>Using defaults from ksymoops -t elf32-i386 -a i386
>Error (Oops_code_values): invalid value 0xBad in Code line, must be 2, 4, 8 or 1
>Error (Oops_code_values): invalid value 0xE in Code line, must be 2, 4, 8 or 16 

Are you sure that is ksymoops 2.3.5?  My version of 2.3.5 handles
'Code: Bad EIP value. '.  ksymoops >= 2.3.4 should handle it correctly.

>Nov  8 00:11:42 chewbacca kernel: Unable to handle kernel paging request at virtual address 00c014aa 
>Nov  8 00:11:42 chewbacca kernel:  printing eip: 
>Nov  8 00:11:42 chewbacca kernel: 00c014aa 
>Nov  8 00:11:42 chewbacca kernel: *pde = 00000000 
>Nov  8 00:11:42 chewbacca kernel: Oops: 0000 
>Nov  8 00:11:42 chewbacca kernel: CPU:    0 
>Nov  8 00:11:42 chewbacca kernel: EIP:    0010:[usb_stor_exit+12588154/-1072693296] 
>Nov  8 00:11:42 chewbacca kernel: EFLAGS: 00010206 
>Nov  8 00:11:42 chewbacca kernel: eax: 00c014aa   ebx: cf0a1fa4 ecx: da155940   edx: c4a70440 
>Nov  8 00:11:42 chewbacca kernel: esi: 00000000   edi: bffff020 ebp: bffff00c   esp: cf0a1f94 
>Nov  8 00:11:42 chewbacca kernel: ds: 0018   es: 0018   ss: 0018 
>Nov  8 00:11:42 chewbacca kernel: Process ls (pid: 9036, stackpage=cf0a1000) 
>Nov  8 00:11:42 chewbacca kernel: Stack: c0135dd7 c4a70440 cf0a0000 bffff020 c4a70440 eff83540 00000003 bfffe830  
>Nov  8 00:11:42 chewbacca kernel:        bfffe81c 00000008 00000001 c010a4fb bffff020 080549ac 4010fd60 bffff020  
>Nov  8 00:11:42 chewbacca kernel:        bffff020 bffff00c 000000c4 0000002b 0000002b 000000c4 400c4e1c 00000023  
>Nov  8 00:11:42 chewbacca kernel: Call Trace: [sys_lstat64+55/112] [system_call+51/56]  
>Nov  8 00:11:42 chewbacca kernel: Code:  Bad EIP value. 

sys_lstat64+55 has branched to the value in eax and blown up.  It looks like
the data in eax is a kernel address shifted right one byte.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
