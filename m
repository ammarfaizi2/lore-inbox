Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUBIAJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 19:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUBIAJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 19:09:07 -0500
Received: from slask.tomt.net ([217.8.136.223]:15750 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S264454AbUBIAI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 19:08:59 -0500
Message-ID: <4026CF98.5000905@tomt.net>
Date: Mon, 09 Feb 2004 01:08:56 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc1
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402082234.22043.bzolnier@elka.pw.edu.pl> <4026B064.5080900@tomt.net> <200402082351.48958.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402082351.48958.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>>>Can you disassemble ide_pci_register_host_proc using gdb?
>>
>>I'd need a walkthrough, not very familiar with gdb other than getting a
>>backtrace out of it
> 
> 
> Make sure to enable following options in kernel config:
> CONFIG_DEBUG_KERNEL ("Kernel hacking"->"Kernel debugging" ) and
> CONFIG_DEBUG_INFO ("Kernel debugging"->"Compile the kernel with debug info").
> 
> Recompile kernel.
> 
> $ gdb /usr/src/linux/vmlinux
> (gdb) disassemble ide_pci_register_host_proc
> 
> That's all :-).
> 

Ahh. However, as ide-core is a module in this case, I had to run gdb on 
the module instead. Anyway..

(gdb) disassemble ide_pci_register_host_proc
Dump of assembler code for function ide_pci_register_host_proc:
0xe940 <ide_pci_register_host_proc>:    mov    0x4(%esp,1),%ecx
0xe944 <ide_pci_register_host_proc+4>:  test   %ecx,%ecx
0xe946 <ide_pci_register_host_proc+6>:  je     0xe978 
<ide_pci_register_host_proc+56>
0xe948 <ide_pci_register_host_proc+8>:  movl   $0x0,0x10(%ecx)
0xe94f <ide_pci_register_host_proc+15>: movb   $0x1,0x4(%ecx)
0xe953 <ide_pci_register_host_proc+19>: mov    0x3910,%eax
0xe958 <ide_pci_register_host_proc+24>: test   %eax,%eax
0xe95a <ide_pci_register_host_proc+26>: je     0xe972 
<ide_pci_register_host_proc+50>
0xe95c <ide_pci_register_host_proc+28>: mov    %eax,%edx
0xe95e <ide_pci_register_host_proc+30>: mov    0x10(%eax),%eax
0xe961 <ide_pci_register_host_proc+33>: test   %eax,%eax
0xe963 <ide_pci_register_host_proc+35>: je     0xe96e 
<ide_pci_register_host_proc+46>
0xe965 <ide_pci_register_host_proc+37>: mov    %eax,%edx
0xe967 <ide_pci_register_host_proc+39>: mov    0x10(%eax),%eax
0xe96a <ide_pci_register_host_proc+42>: test   %eax,%eax
0xe96c <ide_pci_register_host_proc+44>: jne    0xe965 
<ide_pci_register_host_proc+37>
0xe96e <ide_pci_register_host_proc+46>: mov    %ecx,0x10(%edx)
0xe971 <ide_pci_register_host_proc+49>: ret
0xe972 <ide_pci_register_host_proc+50>: mov    %ecx,0x3910
0xe978 <ide_pci_register_host_proc+56>: ret
End of assembler dump.


