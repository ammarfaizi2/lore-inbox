Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276329AbRJGVb2>; Sun, 7 Oct 2001 17:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276297AbRJGVbS>; Sun, 7 Oct 2001 17:31:18 -0400
Received: from [213.97.199.90] ([213.97.199.90]:1664 "HELO fargo")
	by vger.kernel.org with SMTP id <S276329AbRJGVbH>;
	Sun, 7 Oct 2001 17:31:07 -0400
From: "David Gomez" <davidge@jazzfree.com>
Date: Sun, 7 Oct 2001 23:28:48 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: UDF oops in kernel 2.4.9
Message-ID: <Pine.LNX.4.33.0110072320550.618-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

If i try to mount a dvd (udf is compiled as a module), syslog is full of
messages like this:

...
Oct  7 21:54:46 fargo kernel: VFS: grow_buffers: size = -1071097152
...

Mount cannot be killed (the proccess is in running state).

And if I 'insmod' the module udf.o first, and after try to mount the
disc, a nice oops appears. Below is decoded:


ksymoops 2.4.1 on i686 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /boot/System.map-2.4.9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.9 failed
Oct  7 23:17:05 fargo kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Oct  7 23:17:05 fargo kernel: c0131db7
Oct  7 23:17:05 fargo kernel: *pde = 00000000
Oct  7 23:17:05 fargo kernel: Oops: 0002
Oct  7 23:17:05 fargo kernel: CPU:    0
Oct  7 23:17:05 fargo kernel: EIP:    0010:[<c0131db7>]
Using defaults from ksymoops -t elf32-i386 -a i386
Oct  7 23:17:05 fargo kernel: EFLAGS: 00010292
Oct  7 23:17:05 fargo kernel: eax: 00000000   ebx: 00000000   ecx: c0284fb8   edx: 00000002
Oct  7 23:17:05 fargo kernel: esi: c22fec00   edi: c22fec00   ebp: c22fec00   esp: c25f7d40
Oct  7 23:17:05 fargo kernel: ds: 0018   es: 0018   ss: 0018
Oct  7 23:17:05 fargo kernel: Process mount (pid: 515, stackpage=c25f7000)
Oct  7 23:17:05 fargo kernel: Stack: c0284fb8 00000001 c02828a0 00000000 00000000 d4858923 00000340 00082800
Oct  7 23:17:05 fargo kernel:        c0285ac0 00000001 00000000 fffffffe 00000000 00082800 c0285ac0 00000000
Oct  7 23:17:05 fargo kernel:        c22fec00 d3fd9870 c5dfd400 00000000 c22fec00 c22fec00 c5dfd400 c014358a
Oct  7 23:17:05 fargo kernel: Call Trace: [<d4858923>] [<c014358a>] [<c01437d2>] [<c0131de5>] [<d4858225>]
Oct  7 23:17:05 fargo kernel:    [<d485b358>] [<c0134e6d>] [<d4847bf0>] [<c01350b0>] [<d485b358>] [<c0139cb0>]
Oct  7 23:17:05 fargo kernel:    [<c0135933>] [<d485b358>] [<d485b358>] [<c0110c30>] [<c0106dd8>] [<c0135bf6>]
Oct  7 23:17:05 fargo kernel:    [<c0135aae>] [<c0135c8c>] [<c0106ce7>]
Oct  7 23:17:05 fargo kernel: Code: 0f ab 50 18 8b 04 24 f6 40 18 01 75 3c 89 e0 50 6a 01 6a 00

>>EIP; c0131db7 <bread+27/250>   <=====
Trace; d4858923 <[isofs]isofs_read_inode+47/3c8>
Trace; c014358a <get_empty_inode+14a/1e0>
Trace; c01437d2 <iget4+c2/d0>
Trace; c0131de5 <bread+55/250>
Trace; d4858225 <[isofs]isofs_read_super+505/66c>
Trace; d485b358 <[isofs]iso9660_fs_type+0/28>
Trace; c0134e6d <get_super+2dd/830>
Trace; d4847bf0 <[cdrom]cdrom_media_changed+30/34>
Trace; c01350b0 <get_super+520/830>
Trace; d485b358 <[isofs]iso9660_fs_type+0/28>
Trace; c0139cb0 <path_release+40/140>
Trace; c0135933 <may_umount+4b3/ce0>
Trace; d485b358 <[isofs]iso9660_fs_type+0/28>
Trace; d485b358 <[isofs]iso9660_fs_type+0/28>
Trace; c0110c30 <__verify_write+160/800>
Trace; c0106dd8 <__up_wakeup+121c/2454>
Trace; c0135bf6 <may_umount+776/ce0>
Trace; c0135aae <may_umount+62e/ce0>
Trace; c0135c8c <may_umount+80c/ce0>
Trace; c0106ce7 <__up_wakeup+112b/2454>
Code;  c0131db7 <bread+27/250>
00000000 <_EIP>:
Code;  c0131db7 <bread+27/250>   <=====
   0:   0f ab 50 18               bts    %edx,0x18(%eax)   <=====
Code;  c0131dbb <bread+2b/250>
   4:   8b 04 24                  mov    (%esp,1),%eax
Code;  c0131dbe <bread+2e/250>
   7:   f6 40 18 01               testb  $0x1,0x18(%eax)
Code;  c0131dc2 <bread+32/250>
   b:   75 3c                     jne    49 <_EIP+0x49> c0131e00 <bread+70/250>
Code;  c0131dc4 <bread+34/250>
   d:   89 e0                     mov    %esp,%eax
Code;  c0131dc6 <bread+36/250>
   f:   50                        push   %eax
Code;  c0131dc7 <bread+37/250>
  10:   6a 01                     push   $0x1
Code;  c0131dc9 <bread+39/250>
  12:   6a 00                     push   $0x0


1 warning and 1 error issued.  Results may not be reliable.



Thanks for any help

