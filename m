Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285555AbRLSVuB>; Wed, 19 Dec 2001 16:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285554AbRLSVtw>; Wed, 19 Dec 2001 16:49:52 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:19405 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S285540AbRLSVth>; Wed, 19 Dec 2001 16:49:37 -0500
Message-ID: <3C210AB9.5000900@suhr.home.cs.tu-berlin.de>
Date: Wed, 19 Dec 2001 22:46:33 +0100
From: Gregor Suhr <linuxkernel@suhr.home.cs.tu-berlin.de>
Reply-To: gregor@suhr.home.cs.tu-berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS  at boot in 2.4.17-rc[12]  (kernel BUG at slab.c:815) maybe devfs
Content-Type: multipart/mixed;
 boundary="------------040209020005080101070706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040209020005080101070706
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Hi,
I tried to upgrade my system from 2.4.16 to 2.4.17-rc2 but I'am always 
got the following OOPS:

ksymoops 2.4.3 on i686 2.4.16.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.17-rc2 (specified)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
kernel BUG at slab.c:815!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012960a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001a   ebx: dfe38698   ecx: 00000001   edx: 00002a56
esi: dfe38691   edi: c0324117   ebp: 00000000   esp: c181dee4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c181d000)
Stack: c0316083 0000032f c181def4 dfe386b8 00000018 c180f368 c180f324 
c180f324
       c030c113 c03a7ad4 c032410a 0000001c 00000020 00000000 00000000 
00000000
       c03a72f3 c0317020 00000002 00000000 00000000 dfe80e24 00003a00 
00000009
Call Trace: [<c0118206>] [<c0118226>] [<c010522c>] [<c0105000>] [<c010525e>]
   [<c0105000>] [<c0105726>] [<c0105250>]
Code: 0f 0b 5f 8b 13 5d 89 d3 8b 03 89 c2 0f 18 02 81 fb c8 dc 37

 >>EIP; c012960a <kmem_cache_create+40a/470>   <=====
Trace; c0118206 <sys_wait4+3a6/3b0>
Trace; c0118226 <sys_waitpid+16/20>
Trace; c010522c <prepare_namespace+11c/140>
Trace; c0105000 <_stext+0/0>
Trace; c010525e <init+e/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105726 <kernel_thread+26/30>
Trace; c0105250 <init+0/140>
Code;  c012960a <kmem_cache_create+40a/470>
00000000 <_EIP>:
Code;  c012960a <kmem_cache_create+40a/470>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012960c <kmem_cache_create+40c/470>
   2:   5f                        pop    %edi
Code;  c012960c <kmem_cache_create+40c/470>
   3:   8b 13                     mov    (%ebx),%edx
Code;  c012960e <kmem_cache_create+40e/470>
   5:   5d                        pop    %ebp
Code;  c0129610 <kmem_cache_create+410/470>
   6:   89 d3                     mov    %edx,%ebx
Code;  c0129612 <kmem_cache_create+412/470>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c0129614 <kmem_cache_create+414/470>
   a:   89 c2                     mov    %eax,%edx
Code;  c0129616 <kmem_cache_create+416/470>
   c:   0f 18 02                  prefetchnta (%edx)
Code;  c0129618 <kmem_cache_create+418/470>
   f:   81 fb c8 dc 37 00         cmp    $0x37dcc8,%ebx

 <0>Kernel panic: Attempted to kill init!

Before the kernel gives up i get the following error messages while 
trying to find my LVM drives:

Mounted devfs on /dev
modprobe: Can't open dependencies file 
/lib/modules/2.4.17-rc2/modules.dep (No such file odevfs: 
devfs_mk_dir(vg0): using old entry in dir: c1808724 ""
r directory)
vgdevfs: devfs_register(group): could not append to parent, err: -17
scan -- reading devfs: devfs_register(root): could not append to parent, 
err: -17
all physical voldevfs: devfs_register(tmp): could not append to parent, 
err: -17
umes (this may tdevfs: devfs_register(var): could not append to parent, 
err: -17
ake a while...)devfs: devfs_register(squid): could not append to parent, 
err: -17

vgscan -- founddevfs: devfs_register(usr): could not append to parent, 
err: -17
 inactive volumedevfs: devfs_register(home): could not append to parent, 
err: -17
 group "vg0"
vgdevfs: devfs_register(swap): could not append to parent, err: -17
scan -- "/etc/lvdevfs: devfs_register(redhat): could not append to 
parent, err: -17
mtab" and "/etc/devfs: devfs_register(mp3): could not append to parent, 
err: -17
lvmtab.d" succesdevfs: devfs_register(appdata): could not append to 
parent, err: -17
sfully created
devfs: devfs_register(oracle): could not append to parent, err: -17
vgscan -- WARNING: This program does not do a VGDA backup of your volume 
group

vgchange -- volume group "vg0" successfully activated


System Configuration:
PIII 700
512MB RAM
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11l
modutils               2.4.12
e2fsprogs              1.23
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11

All partitions are on  a LVM drive, and should be found by the initrd.

I hope the problem will be solved before 2.4.17.

Best regards,

Gregor Suhr



--------------040209020005080101070706
Content-Type: application/x-gzip;
 name="linuxconfig.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="linuxconfig.gz"


--------------040209020005080101070706--

