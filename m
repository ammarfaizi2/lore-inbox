Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSAQQcm>; Thu, 17 Jan 2002 11:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289199AbSAQQcZ>; Thu, 17 Jan 2002 11:32:25 -0500
Received: from ti200710a082-0464.bb.online.no ([148.122.9.208]:5124 "EHLO
	empire.e") by vger.kernel.org with ESMTP id <S289198AbSAQQcM>;
	Thu, 17 Jan 2002 11:32:12 -0500
Message-ID: <3C46FC88.2050906@freenix.no>
Date: Thu, 17 Jan 2002 17:32:08 +0100
From: frode <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020113
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.17 oops, again ("kernel BUG at page_alloc.c:76!")
Content-Type: multipart/mixed;
 boundary="------------080602030109030700050308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080602030109030700050308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I got this oops yesterday, on a 2.4.17 kernel on a k7 750 with 384mb ram and 
160mb swap. It took down XFree but I could still run programs on the VT, so I 
attach the output of 'dmesg | ksymoops', 'free', 'lspci' and 'lsmod'. If 
anyone's interested, I can mail the .config file as well.

I've had a lot of oopses on 2.4.17 lately; see for example 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.1/1628.html.

The kernel is tainted because of the nvidia NVdriver module v2313.
(but even without it loaded I recall getting oopses).

I tried running MemTest86 for about 35 minutes with no errors reported.

By the way, during bootup, i get a "spurious 8259A interrupt: IRQ7."
kernel message. Sometimes after all services have been started, other times just 
before the initscripts are finished starting everything. It doesn't seem to have 
any effect.. my printer seems to work fine (if lpt1 is related to IRQ7..?)

- Frode

--------------080602030109030700050308
Content-Type: text/plain;
 name="dmesg_pipe_ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_pipe_ksymoops.txt"

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 2000110, slice: 1000055
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
kernel BUG at page_alloc.c:76!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c4d4>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013282
eax: 0000001f   ebx: c131fe40   ecx: c02f8ca0   edx: 00001e2b
esi: c131fe40   edi: cd26ece8   ebp: 00000000   esp: cdc23e58
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 1565, stackpage=cdc23000)
Stack: c028b308 0000004c c131fe40 000f5000 cd26ece8 48a45000 cdc23e74 00400000 
       c8a03027 cd0c29b0 c012b6c5 c012cdac c131fe40 c012d1f1 c131fe40 c0122c7a 
       c131fe40 00106000 c0123071 0c7f9047 d6b4cac0 d6bce300 48645000 00106000 
Call Trace: [<c012b6c5>] [<c012cdac>] [<c012d1f1>] [<c0122c7a>] [<c0123071>] 
   [<c01253e5>] [<c01154d9>] [<c01195ed>] [<c0106d38>] [<c0154114>] [<c0132e8f>] 
   [<c0131eac>] [<c0106f7c>] [<c0106ec4>] 
Code: 0f 0b 83 c4 08 8d b4 26 00 00 00 00 89 f0 2b 05 2c ad 35 c0 

>>EIP; c012c4d4 <__free_pages_ok+34/2a0>   <=====
Trace; c012b6c4 <lru_cache_del+4/10>
Trace; c012cdac <page_cache_release+2c/30>
Trace; c012d1f0 <free_page_and_swap_cache+30/40>
Trace; c0122c7a <__free_pte+3a/40>
Trace; c0123070 <zap_page_range+190/240>
Trace; c01253e4 <exit_mmap+b4/130>
Trace; c01154d8 <mmput+38/60>
Trace; c01195ec <do_exit+9c/200>
Trace; c0106d38 <do_signal+228/290>
Trace; c0154114 <ext3_release_file+14/20>
Trace; c0132e8e <fput+ae/e0>
Trace; c0131eac <filp_close+5c/70>
Trace; c0106f7c <error_code+34/3c>
Trace; c0106ec4 <signal_return+14/18>
Code;  c012c4d4 <__free_pages_ok+34/2a0>
00000000 <_EIP>:
Code;  c012c4d4 <__free_pages_ok+34/2a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c4d6 <__free_pages_ok+36/2a0>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012c4d8 <__free_pages_ok+38/2a0>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c012c4e0 <__free_pages_ok+40/2a0>
   c:   89 f0                     mov    %esi,%eax
Code;  c012c4e2 <__free_pages_ok+42/2a0>
   e:   2b 05 2c ad 35 c0         sub    0xc035ad2c,%eax


1 warning issued.  Results may not be reliable.

--------------080602030109030700050308
Content-Type: text/plain;
 name="free.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="free.txt"

             total       used       free     shared    buffers     cached
Mem:        384212     181232     202980          0      24840     119700
-/+ buffers/cache:      36692     347520
Swap:       160608       4576     156032

--------------080602030109030700050308
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 21)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:09.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo (rev 02)
00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 06)
00:0d.0 Ethernet controller: 3Com Corporation 3c900B-Combo [Etherlink XL Combo] (rev 04)
01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 (rev 10)

--------------080602030109030700050308
Content-Type: text/plain;
 name="lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod.txt"

Module                  Size  Used by    Tainted: P  
NVdriver              816864  14 (autoclean)
nls_iso8859-1           2848   3 (autoclean)
nls_cp437               4384   3 (autoclean)
emu10k1                58720   2
ac97_codec              9824   0 [emu10k1]
sound                  57004   0 [emu10k1]
3c59x                  25512   1

--------------080602030109030700050308--

