Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292082AbSB0Erf>; Tue, 26 Feb 2002 23:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292079AbSB0ErZ>; Tue, 26 Feb 2002 23:47:25 -0500
Received: from smtp01.web.de ([194.45.170.210]:46107 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S292062AbSB0ErE>;
	Tue, 26 Feb 2002 23:47:04 -0500
Message-ID: <3C7C72C3.60906@web.de>
Date: Wed, 27 Feb 2002 05:46:43 +0000
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.5-dj2 and vfat oopses (ksymoops output included)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

trying to copy a file to a fat 32 partition, the kernel oopses. Here is 
the information
% uname -r
        2.5.5-dj2
distro:
        Debian GNU/Linux unstable
machine:
        Dell Inspiron 8000
partition:
        hda7, type c (FAT 32 LBA) on a 40 GB Toshiba HD
fstab entry for the partition:
        /dev/hda7   /mnt/data   vfat    
rw,quiet,uid=1000,gid=100,codepage=850  0  0

ksymoops (made it immediatelly after the oops with the same modules 
loaded and same kernel):

ksymoops 2.4.3 on i686 2.5.5-dj2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.5-dj2/ (default)
     -m /boot/System.map-2.5.5-dj2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol 
vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  
Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000053
d097f966
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d097f966>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: 00000053   ebx: 00000001   ecx: 00000000   edx: d0983e00
esi: c78e3db7   edi: c76c3000   ebp: c76c3042   esp: c78e3d3c
ds: 0018   es: 0018   ss: 0018
Stack: 00000024 c78e3e20 ce426ce0 ca219f60 6f646e6f 6152206e 28206e69 
68746f4e
       c76c2ffe c78e3dbc 654d2073 6b694c20 6f592065 6f442075 536d2e29 
c78e3db8
       c78e0101 00000001 00000002 00000006 00000000 00000000 c0267bc0 
00000020
Call Trace: [<d0980191>] [<d0980214>] [<d0983e00>] [<d0983e00>] [<d0980427>]
   [<d09804f4>] [<d097f61b>] [<d09809d3>] [permission+123/132] 
[vfs_create+246/284] [open_namei+357/1728]
Code: 0f b6 14 08 80 3c 08 00 0f 45 c2 88 44 24 7c 0f b6 c0 f6 80

 >>EIP; d097f966 <[vfat]vfat_create_shortname+1ca/750>   <=====
Trace; d0980190 <[vfat]vfat_fill_slots+88/2d4>
Trace; d0980214 <[vfat]vfat_fill_slots+10c/2d4>
Trace; d0983e00 <[nls_cp850]table+0/1e>
Trace; d0983e00 <[nls_cp850]table+0/1e>
Trace; d0980426 <[vfat]vfat_build_slots+4a/54>
Trace; d09804f4 <[vfat]vfat_add_entry+c4/28c>
Trace; d097f61a <[vfat]vfat_cmpi+66/7c>
Trace; d09809d2 <[vfat]vfat_create+52/174>
Code;  d097f966 <[vfat]vfat_create_shortname+1ca/750>
00000000 <_EIP>:
Code;  d097f966 <[vfat]vfat_create_shortname+1ca/750>   <=====
   0:   0f b6 14 08               movzbl (%eax,%ecx,1),%edx   <=====
Code;  d097f96a <[vfat]vfat_create_shortname+1ce/750>
   4:   80 3c 08 00               cmpb   $0x0,(%eax,%ecx,1)
Code;  d097f96e <[vfat]vfat_create_shortname+1d2/750>
   8:   0f 45 c2                  cmovne %edx,%eax
Code;  d097f970 <[vfat]vfat_create_shortname+1d4/750>
   b:   88 44 24 7c               mov    %al,0x7c(%esp,1)
Code;  d097f974 <[vfat]vfat_create_shortname+1d8/750>
   f:   0f b6 c0                  movzbl %al,%eax
Code;  d097f978 <[vfat]vfat_create_shortname+1dc/750>
  12:   f6 80 00 00 00 00 00      testb  $0x0,0x0(%eax)


3 warnings issued.  Results may not be reliable.



The P in Tainted: is because of the NVdriver module. Fat and vfat 
compiled as modules too. I can read with no problems from the partition, 
but I can't write to it. Any clue/patch ?

Regards,
Todor

