Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbSJHQPO>; Tue, 8 Oct 2002 12:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSJHQPN>; Tue, 8 Oct 2002 12:15:13 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:10180 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP
	id <S261350AbSJHQOZ>; Tue, 8 Oct 2002 12:14:25 -0400
Date: Tue, 8 Oct 2002 18:20:00 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Oops with 2.4.20pre5
Message-ID: <20021008162000.GB18374@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>From times to times, my laptop oops at shutdown time, just after quitting
XFree. The computer then hangs and you have to press (5 seconds) the big
red switch to go on.

The computer is a Toshiba S3000-X11 with a celeron 1GHz. System is linux
redhat-7.3 with most updates, XFree-cvs and a 2.4.20pre5 kernel with
acpi patches and the tosh3k module from Bruno Ducrot.

Oops number 1 appeared in a vt (framebuffer vt) just after XFree exits.
The shutdown procedure was stopped. I could switch VT, and even type
«root» at the logging prompt of VT number 2. At that point, oops number 2
appeared. After that point, I could still switch VT, but even typing
login names at prompt wouldn't work. I wrote down by hand both oops; I
hope I didn't make any mistake. Nothing in the logs.  The Oops are at the
end of the email.

Note that my kernel is only tainted by the ipchains.o module; I don't use
any proprietary modules, and I use the vanilla i830.o module and not the
one found in XFree's sources.

Appart from that, I have another problem with this kernel: USB-storage
doesn't work with large file transfers: I mounted an zip-250 on USB; it
worked fine, I could « ls » and stuff. When I tried to copy a 70meg file
on the zip, the system first become very unresponsive (difficult to move
the mouse pointer, keyboard focus not following, big lattency (couple of
seconds) between key presses and response, etc), and then hung
completely. In contrast, it worked perfectly with redhat's kernel.

As I know there are a lot of USB fix at the moment, the problem might
have disapeared in recent kernels. I will try more recent kernel in some
time and get back to you if my usb problem is still present. However, if
you want a more thourough report on this zip problem before I upgrade the
kernel, drop me a note.

Regards,

	Éric Brunet

=========================== Oops number 1 ===============================
ksymoops 2.4.4 on i686 2.4.20-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre5/ (default)
     -m /boot/System.map-2.4.20-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 00000004
c012bdf6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012bdf6>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013056
eax: 01000000   ebx: cc990c78   ecx: cc990000   edx: cc8ce000
esi: c12ae1c8   edi: 00000064   ebp: c1229f04   esp: ceca7e08
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 7, stackpage=ceca7000)
Stack: cde20bec 00000000 c015d6a9 00003246 00000000 000016e7 c0155480 cf667bb8
       cc96e000 00000000 00000000 c1229f04 c0135864 c12ae1c8 000000f0 c01607d7
       00000000 cf667b14 000016e7 00000000 00000000 00000000 ce0761b4 00000000
Call Trace:    [<c015d6a9>] [<c0155480>] [<c0135864>] [<c01607d7>] [<c015e075>]
  [<c01141d3>] [<c01604d6>] [<c01603b0>] [<c0107156>] [<c01603d0>]
Code: 89 48 04 89 01 89 71 04 89 0e 8b 6e 1c f7 c5 00 08 00 00 74

>>EIP; c012bdf6 <kmem_cache_alloc+a6/190>   <=====
Trace; c015d6a9 <__journal_file_buffer+d9/1e0>
Trace; c0155480 <ext3_bmap+60/70>
Trace; c0135864 <get_unused_buffer_head+34/80>
Trace; c01607d7 <journal_write_metadata_buffer+1c7/2b0>
Trace; c015e075 <journal_commit_transaction+645/f14>
Trace; c01141d3 <schedule+2c3/2f0>
Trace; c01604d6 <kjournald+106/1a0>
Trace; c01603b0 <commit_timeout+0/10>
Trace; c0107156 <kernel_thread+26/30>
Trace; c01603d0 <kjournald+0/1a0>
Code;  c012bdf6 <kmem_cache_alloc+a6/190>
00000000 <_EIP>:
Code;  c012bdf6 <kmem_cache_alloc+a6/190>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c012bdf9 <kmem_cache_alloc+a9/190>
   3:   89 01                     mov    %eax,(%ecx)
Code;  c012bdfb <kmem_cache_alloc+ab/190>
   5:   89 71 04                  mov    %esi,0x4(%ecx)
Code;  c012bdfe <kmem_cache_alloc+ae/190>
   8:   89 0e                     mov    %ecx,(%esi)
Code;  c012be00 <kmem_cache_alloc+b0/190>
   a:   8b 6e 1c                  mov    0x1c(%esi),%ebp
Code;  c012be03 <kmem_cache_alloc+b3/190>
   d:   f7 c5 00 08 00 00         test   $0x800,%ebp
Code;  c012be09 <kmem_cache_alloc+b9/190>
  13:   74 00                     je     15 <_EIP+0x15> c012be0b <kmem_cache_alloc+bb/190>


1 warning issued.  Results may not be reliable.
==============================================================================

and:

======================== Oops number 2 =============================
ksymoops 2.4.4 on i686 2.4.20-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre5/ (default)
     -m /boot/System.map-2.4.20-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 00000004
c012bdf6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012bdf6>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010056
eax: 01000000   ebx: cc8ce444   ecx: cc8ce000   edx: c856c000
esi: c12ae1c8   edi: 00000000   ebp: 00000001   esp: cec2dcc4
ds: 0018   es: 0018   ss: 0018
Process mingetty (pid: 1280, stackpage=cec2d000)
Stack: cc8ab144 cf64b000 c01565f5 00000246 cea701f0 c0157877 00000246 cebb19ac
       00000000 00000000 00001000 00000001 c0135864 c12ae1c8 000000f0 c0135936
       00000001 c0145f80 00000001 00000001 00000000 c1180700 00000302 cc8ab1e8
Call Trace:    [<c01565f5>] [<c0157877>] [<c0135864>] [<c0135936>] [<c0145f80>]
  [<c0135b78>] [<c0136218>] [<c012e0c0>] [<c01270ac>] [<c0154bb0>] [<c013cc8e>]
  [<c012780c>] [<c0127410>] [<c013a86c>] [<c013acf4>] [<c013b189>] [<c013c0ee>]
  [<c0107590>] [<c010890b>]
Code: 89 48 04 89 01 89 71 04 89 0e 8b 6e 1c f7 c5 00 08 00 00 74

>>EIP; c012bdf6 <kmem_cache_alloc+a6/190>   <=====
Trace; c01565f5 <ext3_read_inode+15/2b0>
Trace; c0157877 <ext3_find_entry+247/350>
Trace; c0135864 <get_unused_buffer_head+34/80>
Trace; c0135936 <create_buffers+26/f0>
Trace; c0145f80 <get_new_inode+f0/160>
Trace; c0135b78 <create_empty_buffers+18/60>
Trace; c0136218 <block_read_full_page+58/240>
Trace; c012e0c0 <__alloc_pages+40/170>
Trace; c01270ac <do_generic_file_read+2bc/430>
Trace; c0154bb0 <ext3_get_block+0/70>
Trace; c013cc8e <link_path_walk+77e/890>
Trace; c012780c <sys_sendfile+18c/200>
Trace; c0127410 <file_read_actor+0/80>
Trace; c013a86c <kernel_read+4c/60>
Trace; c013acf4 <prepare_binprm+114/120>
Trace; c013b189 <do_execve+109/1e0>
Trace; c013c0ee <getname+5e/a0>
Trace; c0107590 <sys_execve+30/60>
Trace; c010890b <system_call+33/38>
Code;  c012bdf6 <kmem_cache_alloc+a6/190>
00000000 <_EIP>:
Code;  c012bdf6 <kmem_cache_alloc+a6/190>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c012bdf9 <kmem_cache_alloc+a9/190>
   3:   89 01                     mov    %eax,(%ecx)
Code;  c012bdfb <kmem_cache_alloc+ab/190>
   5:   89 71 04                  mov    %esi,0x4(%ecx)
Code;  c012bdfe <kmem_cache_alloc+ae/190>
   8:   89 0e                     mov    %ecx,(%esi)
Code;  c012be00 <kmem_cache_alloc+b0/190>
   a:   8b 6e 1c                  mov    0x1c(%esi),%ebp
Code;  c012be03 <kmem_cache_alloc+b3/190>
   d:   f7 c5 00 08 00 00         test   $0x800,%ebp
Code;  c012be09 <kmem_cache_alloc+b9/190>
  13:   74 00                     je     15 <_EIP+0x15> c012be0b <kmem_cache_alloc+bb/190>


1 warning issued.  Results may not be reliable.
=============================================================================
