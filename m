Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbTLWKE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 05:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTLWKE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 05:04:26 -0500
Received: from [213.140.2.58] ([213.140.2.58]:33179 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S265078AbTLWKEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 05:04:23 -0500
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
From: Carlo <devel@integra-sc.it>
To: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <200312222205.hBMM5vLv012067@car.linuxhacker.ru>
References: <1072126808.21200.3.camel@atena>
	 <200312222205.hBMM5vLv012067@car.linuxhacker.ru>
Content-Type: text/plain
Message-Id: <1072173894.21198.36.camel@atena>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 11:04:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il lun, 2003-12-22 alle 23:05, Oleg Drokin ha scritto:
> Hello!

> C> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> C> DataRequest }
> C> ide0: Drive 0 didn't accept speed setting. Oh, well.
> C> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> C> hda: CHECK for good STATUS
> 
> Do you always get these IDE errors prior to oops?

No, on 6 oops only one has this error!




> C> Unable to handle kernel paging request at virtual address ffffffe0
............
> Also please run your oops through ksymoops.

ksymoops 2.4.4 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22-WE (specified)
                                                                                                 
Dec 22 19:23:57 webeye kernel: Unable to handle kernel paging request at
virtual address ffffffe0Dec 22 19:23:57 webeye kernel: c0146553
Dec 22 19:23:57 webeye kernel: *pde = 00002063
Dec 22 19:23:57 webeye kernel: Oops: 0000
Dec 22 19:23:57 webeye kernel: CPU:    0
Dec 22 19:23:57 webeye kernel: EIP:    0010:[<c0146553>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 22 19:23:57 webeye kernel: EFLAGS: 00010213
Dec 22 19:23:57 webeye kernel: eax: cbf85168   ebx: ffffffe0   ecx:
cbf85000   edx: 0000000f
Dec 22 19:23:57 webeye kernel: esi: 00000000   edi: cbf85f40   ebp:
cbf85f68   esp: c594df24
Dec 22 19:23:57 webeye kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 19:23:57 webeye kernel: Process rmdir (pid: 11938,
stackpage=c594d000)
Dec 22 19:23:57 webeye kernel: Stack: 00000000 cbf85f40 cbf85f40
c6096b40 cbf85f40 bffffb18 c0146Dec 22 19:23:57 webeye kernel:       
cbf85f40 c013fa0f cbf85f40 000001fe c6461540 c6096b40 cbf85Dec 22
19:23:57 webeye kernel:        c013fb69 cbf85f40 cbf859c0 c594df9c
00000000 fffffff0 cbf85Dec 22 19:23:57 webeye kernel: Call Trace:   
[<c01465dd>] [<c013fa0f>] [<c018d840>] [<c013fb69>]Dec 22 19:23:57
webeye kernel:   [<c0114d00>] [<c01088a3>]
Dec 22 19:23:57 webeye kernel: Code: 8b 03 8b 36 85 c0 75 32 8d 4b 18 8b
51 04 8b 43 18 89 50 04
                                                                                                 
>>EIP; c0146553 <select_parent+33/a0>   <=====
Trace; c01465dd <shrink_dcache_parent+1d/30>
Trace; c013fa0f <d_unhash+2f/50>
Trace; c018d840 <reiserfs_rmdir+0/270>
Trace; c013fb69 <vfs_rmdir+139/1c0>
Trace; c013fc84 <sys_rmdir+94/e0>
Trace; c0114d00 <do_page_fault+0/48c>
Trace; c01088a3 <system_call+33/38>
Code;  c0146553 <select_parent+33/a0>
00000000 <_EIP>:
Code;  c0146553 <select_parent+33/a0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0146555 <select_parent+35/a0>
   2:   8b 36                     mov    (%esi),%esi
Code;  c0146557 <select_parent+37/a0>
   4:   85 c0                     test   %eax,%eax
Code;  c0146559 <select_parent+39/a0>
   6:   75 32                     jne    3a <_EIP+0x3a> c014658d
<select_parent+6d/a0>
Code;  c014655b <select_parent+3b/a0>
   8:   8d 4b 18                  lea    0x18(%ebx),%ecx
Code;  c014655e <select_parent+3e/a0>
   b:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c0146561 <select_parent+41/a0>
   e:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c0146564 <select_parent+44/a0>
  11:   89 50 04                  mov    %edx,0x4(%eax)
                                                                                                 
I hope this is what you want. I had never use ksymoops before.
This oops raise every time i use my program (a perl script that erase
files).
If it's necessary i can send the full /var/log/messages  passed through
ksymoops with a lot of "Unable to handle kernel paging request at
virtual address" but it's aboute 500Kb.

Thanks for your interest.

Marry Christmas :-) 
Saluti Carlo!



> Bye,
>     Oleg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

