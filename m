Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSIEX4W>; Thu, 5 Sep 2002 19:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSIEX4W>; Thu, 5 Sep 2002 19:56:22 -0400
Received: from mout0.freenet.de ([194.97.50.131]:56512 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S318502AbSIEX4U>;
	Thu, 5 Sep 2002 19:56:20 -0400
Date: Fri, 6 Sep 2002 02:00:40 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org
Subject: [OOPS:2.5.33] Re: [Jfs-discussion] crash with JFS assert
Message-ID: <20020906000040.GA269@prester.freenet.de>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	JFS-Discussion <jfs-discussion@www-124.ibm.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org
References: <Pine.LNX.4.43.0209051006480.887-100000@leo.uni-sw.gwdg.de> <3D771308.6030009@hh59.org> <200209050755.06015.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209050755.06015.shaggy@austin.ibm.com>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaggy,

On Thu, 05 Sep 2002, Dave Kleikamp wrote:

> For what it's worth, after I asked about your gcc version, I tried to 
> the latest 3.2 compiler and didn't have a problem with it.
 
> I never was able to figure out the cause of your oops, and I haven't 
> been able to reproduce it.  It looked to me like a linked list 
> (synclist) was corrupted, but I wasn't able to figure out what could 
> have caused it.
 
> I'm glad you haven't had the problem since, but I'm concerned about not 
> understanding what caused the problem.

I'm really sorry. Guess what just happend after I have get my keyboard to
work with 2.5.33 and put the filesystem under some load....

I have no idea how I could reproduce it. It's just more or less heavy
filesystem load...


Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01889e9
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c01889e9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: cbc92d04   ecx: cbc3c000   edx: cbc92d10
esi: cc80909c   edi: cc809090   ebp: cbe4b980   esp: cbc3df08
ds: 0068   es: 0068   ss: 0068
Stack: c1390000 0000004d cbc3df14 cbc92d04 c8f15208 cc809090 cc856fbc
00000000
       c019d351 c139dea8 0004d3e8 00000001 cc809090 00000000 00000010
c139dea8
       c223aba0 08048df8 c0116ac3 cbc3df78 cc809090 cc809090 00000246
cbc3c000
Call Trace: [<c019d351>] [<c0116ac3>] [<c019dde5>] [<c019e084>] [<c0116c80>]
   [<c0116c80>] [<c019dee0>] [<c01057ad>]
Code: 89 50 04 89 57 0c 89 72 04 8b 57 30 8b 44 24 0c 89 50 48 ff


>>EIP; c01889e9 <diUpdatePMap+219/330>   <=====

>>ebx; cbc92d04 <_end+b943560/c5c685c>
>>ecx; cbc3c000 <_end+b8ec85c/c5c685c>
>>edx; cbc92d10 <_end+b94356c/c5c685c>
>>esi; cc80909c <_end+c4b98f8/c5c685c>
>>edi; cc809090 <_end+c4b98ec/c5c685c>
>>ebp; cbe4b980 <_end+bafc1dc/c5c685c>
>>esp; cbc3df08 <_end+b8ee764/c5c685c>

Trace; c019d351 <txUpdateMap+2b1/360>
Trace; c0116ac3 <schedule+183/2f0>
Trace; c019dde5 <txLazyCommit+55/150>
Trace; c019e084 <jfs_lazycommit+1a4/2b0>
Trace; c0116c80 <default_wake_function+0/40>
Trace; c0116c80 <default_wake_function+0/40>
Trace; c019dee0 <jfs_lazycommit+0/2b0>
Trace; c01057ad <kernel_thread_helper+5/18>

Code;  c01889e9 <diUpdatePMap+219/330>
00000000 <_EIP>:
Code;  c01889e9 <diUpdatePMap+219/330>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c01889ec <diUpdatePMap+21c/330>
   3:   89 57 0c                  mov    %edx,0xc(%edi)
Code;  c01889ef <diUpdatePMap+21f/330>
   6:   89 72 04                  mov    %esi,0x4(%edx)
Code;  c01889f2 <diUpdatePMap+222/330>
   9:   8b 57 30                  mov    0x30(%edi),%edx
Code;  c01889f5 <diUpdatePMap+225/330>
   c:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c01889f9 <diUpdatePMap+229/330>
  10:   89 50 48                  mov    %edx,0x48(%eax)
Code;  c01889fc <diUpdatePMap+22c/330>
  13:   ff 00                     incl   (%eax)

Right after that the following kernel message appeared..

init_special_inode: bogus imode (0)


Further I add some information as it is suggested by REPORTING-BUGS

My best regards,
Axel Siebenwirth


Linux prester 2.5.33 #1 Thu Sep 5 01:34:07 CEST 2002 i686 unknown

Gnu C                  gcc (GCC) 3.2.1 20020904 (prerelease) Copyright (C)
2002
Free Software Foundation, Inc. This is free software; see the source for
copying conditions. There is NO warranty; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.19
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         ppp_deflate zlib_inflate zlib_deflate bsd_comp
ppp_async
8250 core ppp_generic slhc rtc nls_iso8859-1 nls_cp437 minix

00:00.0 Host bridge: Intel Corp. 82810 GMCH [Graphics Memory Controller Hub]
(rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810 CGC [Chipset Graphics
Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev
02)

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0beeffff : System RAM
  00100000-002835a1 : Kernel code
  002835a2-002da5bf : Kernel data
0bef0000-0bef2fff : ACPI Non-volatile Storage
0bef3000-0befffff : ACPI Tables
d0000000-d3ffffff : Intel Corp. 82810 CGC [Chipset Graphics Controller]
d4000000-d407ffff : Intel Corp. 82810 CGC [Chipset Graphics Controller]
ffb00000-ffffffff : reserved

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
d000-d01f : Intel Corp. 82801AA USB
d800-d8ff : Intel Corp. 82801AA AC'97 Audio
  d800-d8ff : Intel ICH 82801AA
dc00-dc3f : Intel Corp. 82801AA AC'97 Audio
  dc00-dc3f : Intel ICH 82801AA
f000-f00f : Intel Corp. 82801AA IDE
  f000-f007 : ide0
  f008-f00f : ide1
