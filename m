Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264521AbRFYWhL>; Mon, 25 Jun 2001 18:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264515AbRFYWhB>; Mon, 25 Jun 2001 18:37:01 -0400
Received: from blinky.its.caltech.edu ([131.215.48.132]:14330 "EHLO
	blinky.its.caltech.edu") by vger.kernel.org with ESMTP
	id <S264425AbRFYWgq>; Mon, 25 Jun 2001 18:36:46 -0400
Date: Mon, 25 Jun 2001 15:36:44 -0700 (PDT)
From: James Lamanna <jlamanna@its.caltech.edu>
X-X-Sender: <jlamanna@blinky>
To: <linux-kernel@vger.kernel.org>
Subject: More module conversion...
Message-ID: <Pine.GSO.4.31.0106251532330.28698-100000@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my quest to convert a module from 2.2 to 2.4, I came across
a nice oops (it actually was from their code that I thought I didn't
have to touch...).

The oops comes when trying to access address 0xd2000, which the
code for this robot controller has hardcoded as its "BASE_ADDR"
Were the base addresses for io cards moved between 2.2 and 2.4?

* Please cc me since I'm not currently subscribed.
Thanks,
--James Lamanna


ksymoops 2.4.0 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux-2.4.5/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Jun 25 15:10:08 martel kernel: Unable to handle kernel paging request at virtual address 000d2000
Jun 25 15:10:08 martel kernel: c8853cc0
Jun 25 15:10:08 martel kernel: *pde = 00000000
Jun 25 15:10:08 martel kernel: Oops: 0000
Jun 25 15:10:08 martel kernel: CPU:    0
Jun 25 15:10:08 martel kernel: EIP:    0010:[<c8853cc0>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 25 15:10:08 martel kernel: EFLAGS: 00010286
Jun 25 15:10:08 martel kernel: eax: 000d2000   ebx: 000000fd   ecx: c748e000   edx: c0244b64
Jun 25 15:10:08 martel kernel: esi: 00000000   edi: 00000000   ebp: c8854780   esp: c6a11ef0
Jun 25 15:10:08 martel kernel: ds: 0018   es: 0018   ss: 0018
Jun 25 15:10:08 martel kernel: Process insmod (pid: 1071, stackpage=c6a11000)
Jun 25 15:10:08 martel kernel: Stack: 00000001 c028853c 00000019 000000fd 00000000 00000000 0806e918 c8853f66
Jun 25 15:10:08 martel kernel:        c8854780 000000fd c8854640 c8853000 00000000 00000000 c8853000 c0111a05
Jun 25 15:10:08 martel kernel:        00000000 c63a8000 000016a0 c63a9000 00000060 ffffffea 00000005 c6b25e00
Jun 25 15:10:08 martel kernel: Call Trace: [<c8853f66>] [<c8854780>] [<c8854640>] [<c8853000>] [<c8853000>] [<c0111a05>] [<c883a000>]
Jun 25 15:10:08 martel kernel:        [<c8853060>] [<c0106c4b>]
Jun 25 15:10:08 martel kernel: Code: 0f b6 34 07 89 f2 80 fa ff 74 08 84 d2 0f 85 09 01 00 00 47

>>EIP; c8853cc0 <[i200m]i200m_probe+20/168>   <=====
Trace; c8853f66 <[i200m]init_module+e2/138>
Trace; c8854780 <[i200m]__module_kernel_version+0/0>
Trace; c8854640 <[i200m]i200m_fops+0/5f>
Trace; c8853000 <[wvlan_cs]__module_parm_station_name+12e98/12ef8>
Trace; c8853000 <[wvlan_cs]__module_parm_station_name+12e98/12ef8>
Trace; c0111a05 <sys_init_module+525/5e0>
Trace; c883a000 <[ds].data.end+15c1/1621>
Trace; c8853060 <[i200m]i200m_boot_command+0/d4>
Trace; c0106c4b <system_call+33/38>
Code;  c8853cc0 <[i200m]i200m_probe+20/168>
00000000 <_EIP>:
Code;  c8853cc0 <[i200m]i200m_probe+20/168>   <=====
   0:   0f b6 34 07               movzbl (%edi,%eax,1),%esi   <=====
Code;  c8853cc4 <[i200m]i200m_probe+24/168>
   4:   89 f2                     mov    %esi,%edx
Code;  c8853cc6 <[i200m]i200m_probe+26/168>
   6:   80 fa ff                  cmp    $0xff,%dl
Code;  c8853cc9 <[i200m]i200m_probe+29/168>
   9:   74 08                     je     13 <_EIP+0x13> c8853cd3 <[i200m]i200m_probe+33/168>
Code;  c8853ccb <[i200m]i200m_probe+2b/168>
   b:   84 d2                     test   %dl,%dl
Code;  c8853ccd <[i200m]i200m_probe+2d/168>
   d:   0f 85 09 01 00 00         jne    11c <_EIP+0x11c> c8853ddc <[i200m]i200m_probe+13c/168>
Code;  c8853cd3 <[i200m]i200m_probe+33/168>
  13:   47                        inc    %edi


1 warning issued.  Results may not be reliable.



