Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264834AbSIWGEH>; Mon, 23 Sep 2002 02:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264859AbSIWGEH>; Mon, 23 Sep 2002 02:04:07 -0400
Received: from cts04.webone.com.au ([210.9.240.37]:53819 "EHLO
	cts04.webone.com.au") by vger.kernel.org with ESMTP
	id <S264834AbSIWGEF>; Mon, 23 Sep 2002 02:04:05 -0400
Date: Mon, 23 Sep 2002 16:09:08 +1000
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 OOPS in kswapd __remove_from_queues
Message-ID: <20020923160908.A28264@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On a KT333 based machine running EXT3 on software RAID1, I'm seeing kswapd die
as shown in the included oops.  I've run memtest86 on the machine, and it's 
come up clean in that.  (Unlike recent bug reports of this nature I've been
able to find on the list, the wild pointer isn't a single-bit-modified null
pointer).

If you need any more information, just ask.

	- Kevin.
	
P.S.: The warnings in the ksymoops output that ext3.o and jbd.o have changed
since they were loaded seem to be caused by the fact that my cramfs initrd
doesn't keep file dates.  md5sums of the versions in the initrd were the same
as the versions in /lib/modules.

ksymoops 2.4.5 on i686 2.4.19-crec.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-crec/ (default)
     -m /boot/System.map-2.4.19-crec (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.19-crec/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-crec/kernel/fs/jbd/jbd.o for module jbd has changed since load
Sep 23 14:19:27 schubert kernel: Unable to handle kernel paging request at virtual address 42000030
Sep 23 14:19:27 schubert kernel: c0135061
Sep 23 14:19:27 schubert kernel: *pde = 00000000
Sep 23 14:19:27 schubert kernel: Oops: 0002
Sep 23 14:19:27 schubert kernel: CPU:    0
Sep 23 14:19:27 schubert kernel: EIP:    0010:[__remove_from_queues+17/48]    Not tainted
Sep 23 14:19:27 schubert kernel: EFLAGS: 00010206
Sep 23 14:19:27 schubert kernel: eax: 42000000   ebx: ce94c1c0   ecx: ce94c1c0   edx: 40000000
Sep 23 14:19:27 schubert kernel: esi: ce94c1c0   edi: ce94c1c0   ebp: c1465118   esp: c15bff24
Sep 23 14:19:27 schubert kernel: ds: 0018   es: 0018   ss: 0018
Sep 23 14:19:27 schubert kernel: Process kswapd (pid: 4, stackpage=c15bf000)
Sep 23 14:19:27 schubert kernel: Stack: c01376cb ce94c1c0 c1465118 000001d0 0000000c 00000200 c0135ba9 ce94c1c0 
Sep 23 14:19:27 schubert kernel:        c1465118 c012d622 c1465118 000001d0 00000020 000001d0 00000020 00000006 
Sep 23 14:19:27 schubert kernel:        00000006 c15be000 00004670 000001d0 c023ec74 c012d876 00000006 00000000 
Sep 23 14:19:27 schubert kernel: Call Trace:    [try_to_free_buffers+91/224] [try_to_release_page+73/80] [shrink_cache+482/768] [shrink_caches+86/128] [try_to_free_pages+60/96]
Sep 23 14:19:27 schubert kernel: Code: 89 50 30 89 02 c7 41 30 00 00 00 00 51 e8 7d ff ff ff 83 c4 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 42000000 Before first symbol
>>ebx; ce94c1c0 <_end+e67a10c/20560f4c>
>>ecx; ce94c1c0 <_end+e67a10c/20560f4c>
>>edx; 40000000 Before first symbol
>>esi; ce94c1c0 <_end+e67a10c/20560f4c>
>>edi; ce94c1c0 <_end+e67a10c/20560f4c>
>>ebp; c1465118 <_end+1193064/20560f4c>
>>esp; c15bff24 <_end+12ede70/20560f4c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 30                  mov    %edx,0x30(%eax)
Code;  00000003 Before first symbol
   3:   89 02                     mov    %eax,(%edx)
Code;  00000005 Before first symbol
   5:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  0000000c Before first symbol
   c:   51                        push   %ecx
Code;  0000000d Before first symbol
   d:   e8 7d ff ff ff            call   ffffff8f <_EIP+0xffffff8f> ffffff8f <END_OF_CODE+1f755e20/????>
Code;  00000012 Before first symbol
  12:   83 c4 00                  add    $0x0,%esp


3 warnings issued.  Results may not be reliable.

lsmod output:

Module                  Size  Used by    Not tainted
loop                    8560   0  (autoclean)
e1000                  64356   1
st                     26644   0  (unused)
aic7xxx               110912   0  (unused)
rtc                     6012   0  (autoclean)
ext3                   56832   3  (autoclean)
jbd                    36344   3  (autoclean) [ext3]


