Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292837AbSCDUZe>; Mon, 4 Mar 2002 15:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292838AbSCDUZZ>; Mon, 4 Mar 2002 15:25:25 -0500
Received: from stingr.net ([212.193.33.37]:6531 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S292837AbSCDUZN>;
	Mon, 4 Mar 2002 15:25:13 -0500
Date: Mon, 4 Mar 2002 23:25:10 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@caldera.de>, linux-mm@kvack.org
Subject: Re: [PATCH] radix-tree pagecache for 2.4.19-pre2-ac2
Message-ID: <20020304232510.C333@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@caldera.de>, linux-mm@kvack.org
In-Reply-To: <20020303210346.A8329@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020303210346.A8329@caldera.de>
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Christoph Hellwig:
> I have uploaded an updated version of the radix-tree pagecache patch
> against 2.4.19-pre2-ac2.  News in this release:

60% the patch is broken. I got 2 oopses. Both looking the same.

ksymoops 2.4.1 on i686 2.4.19-pre2-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre2-ac2/ (default)
     -m /boot/System.map-2.4.19-pre2-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol md_size  , md says c4864900, /lib/modules/2.4.19-pre2-ac2/kernel/drivers/md/md.o says c4864720.  Ignoring /lib/modules/2.4.19-pre2-ac2/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says c4864100, /lib/modules/2.4.19-pre2-ac2/kernel/drivers/md/md.o says c4863f20.  Ignoring /lib/modules/2.4.19-pre2-ac2/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c484fa34, /lib/modules/2.4.19-pre2-ac2/kernel/drivers/usb/usbcore.o says c484f4f4.  Ignoring /lib/modules/2.4.19-pre2-ac2/kernel/drivers/usb/usbcore.o entry
Mar  4 19:57:24 lanserv2 kernel: invalid operand: 0000
Mar  4 19:57:24 lanserv2 kernel: CPU:    0
Mar  4 19:57:24 lanserv2 kernel: EIP:    0010:[shmem_writepage+157/272]    Not tainted
Mar  4 19:57:24 lanserv2 kernel: EIP:    0010:[<c013577d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar  4 19:57:24 lanserv2 kernel: EFLAGS: 00010212
Mar  4 19:57:24 lanserv2 kernel: eax: fffffff4   ebx: c3bea0e0   ecx: 0000056b   edx: 00000143
Mar  4 19:57:24 lanserv2 kernel: esi: c10887c8   edi: fffffff4   ebp: 00056a00   esp: c3fc7f54
Mar  4 19:57:24 lanserv2 kernel: ds: 0018   es: 0018   ss: 0018
Mar  4 19:57:24 lanserv2 kernel: Process kswapd (pid: 4, stackpage=c3fc7000)
Mar  4 19:57:24 lanserv2 kernel: Stack: 00050d00 00056a00 c10887c8 c10887e0 c0297ca0 0000002a c01307d5 c10887c8
Mar  4 19:57:24 lanserv2 kernel:        00000154 00000015 c0297e1c 00000154 00000086 00000048 c0130bc8 c0297e1c
Mar  4 19:57:24 lanserv2 kernel:        000001d0 00000006 0000003e 000001d0 00000082 00000000 00000000 c0131472
Mar  4 19:57:24 lanserv2 kernel: Call Trace: [page_launder_zone+933/1584] [page_launder+360/768] [do_try_to_free_pages+18/384] [
Mar  4 19:57:24 lanserv2 kernel: Call Trace: [<c01307d5>] [<c0130bc8>] [<c0131472>] [<c0131771>] [<c0105000>]
Mar  4 19:57:24 lanserv2 kernel:    [<c01056a6>] [<c0131670>]
Mar  4 19:57:24 lanserv2 kernel: Code: 0f 0b 53 e8 3b f9 ff ff 8b 0f 58 85 c9 74 02 0f 0b 55 56 e8

>>EIP; c013577d <shmem_writepage+9d/110>   <=====
Trace; c01307d5 <page_launder_zone+3a5/630>
Trace; c0130bc8 <page_launder+168/300>
Trace; c0131472 <do_try_to_free_pages+12/180>
Trace; c0131771 <kswapd+101/2d0>
Trace; c0105000 <_stext+0/0>
Trace; c01056a6 <kernel_thread+26/30>
Trace; c0131670 <kswapd+0/2d0>
Code;  c013577d <shmem_writepage+9d/110>
00000000 <_EIP>:
Code;  c013577d <shmem_writepage+9d/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013577f <shmem_writepage+9f/110>
   2:   53                        push   %ebx
Code;  c0135780 <shmem_writepage+a0/110>
   3:   e8 3b f9 ff ff            call   fffff943 <_EIP+0xfffff943> c01350c0 <shmem_recalc_inode+0/60>
Code;  c0135785 <shmem_writepage+a5/110>
   8:   8b 0f                     mov    (%edi),%ecx
Code;  c0135787 <shmem_writepage+a7/110>
   a:   58                        pop    %eax
Code;  c0135788 <shmem_writepage+a8/110>
   b:   85 c9                     test   %ecx,%ecx
Code;  c013578a <shmem_writepage+aa/110>
   d:   74 02                     je     11 <_EIP+0x11> c013578e <shmem_writepage+ae/110>
Code;  c013578c <shmem_writepage+ac/110>
   f:   0f 0b                     ud2a   
Code;  c013578e <shmem_writepage+ae/110>
  11:   55                        push   %ebp
Code;  c013578f <shmem_writepage+af/110>
  12:   56                        push   %esi
Code;  c0135790 <shmem_writepage+b0/110>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0135795 <shmem_writepage+b5/110>


4 warnings issued.  Results may not be reliable.

Both happens under heavy swapout.
under -ac2 without this patch same case walks fine.

(why I'm still unsure - I have a bit of reiserfs quota in both kernels. This
oopses may be caused by incorrect merge. If youre interested, I can send
merge results.)

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
