Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265308AbSJRNEU>; Fri, 18 Oct 2002 09:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265316AbSJRNEU>; Fri, 18 Oct 2002 09:04:20 -0400
Received: from wilma1.suth.com ([207.127.128.4]:28687 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S265308AbSJRNEO>;
	Fri, 18 Oct 2002 09:04:14 -0400
Subject: [BUG] VIA vt8233 ide_iomio_dma kerel oops
From: Jason Williams <jason_williams@suth.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-MDuOYUFO+VTkVhhbgmIU"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 09:12:38 -0400
Message-Id: <1034946763.26201.6.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MDuOYUFO+VTkVhhbgmIU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

So, I can't get my via82cxxx module to load and I can't build via82cxxx
into the kernel because it causes a kernel panic.  I am attaching the
ksymoops output and a snippet of the section of the dissassemble of the
function with gdb.  I am still going to play with this more to see if I
can track it down but if someone wants to lend a hand, it would be most
helpful as I am not the advanced kernel coders that most everyone else
on this list is.

Jason 



--=-MDuOYUFO+VTkVhhbgmIU
Content-Description: 
Content-Disposition: inline; filename=ksymoops.viaoops
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

ksymoops -v /usr/src/linux/vmlinux -k /root/ksyms -l /root/mods -o /lib/mod=
ules/2.5.43 -m /boot/System.map viasegfault=20
ksymoops 2.4.5 on i686 2.5.43.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /root/ksyms (specified)
     -l /root/mods (specified)
     -o /lib/modules/2.5.43 (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000065=
0
c02bc44d
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c02bc44d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c05a9a14   ecx: 00000001   edx: 00000001
esi: c05a9a24   edi: 00009008   ebp: 00000008   esp: db32fd7c
ds: 0068   es: 0068   ss: 0068
Stack: c03f5915 00009008 00000008 c05a9a24 c1526000 c05a9a14 e4c42f70 c05a9=
a14=20
       c02bc597 c05a9a14 00009008 00000008 00000089 c048c89d c1526000 00009=
008=20
       e4c41d88 c05a9a14 00009008 00000008 c02ba7fe c05a9a14 00009008 00000=
004=20
 [<e4c42f70>] via82cxxx_chipsets+0x30/0xa0 [via82cxxx]
 [<c02bc597>] ide_setup_dma+0x27/0x370
 [<e4c41d88>] init_dma_via82cxxx+0x38/0x40 [via82cxxx]
 [<c02ba7fe>] ide_hwif_setup_dma+0x10e/0x150
 [<e4c42f70>] via82cxxx_chipsets+0x30/0xa0 [via82cxxx]
 [<e4c42f91>] via82cxxx_chipsets+0x51/0xa0 [via82cxxx]
 [<c02bab0e>] do_ide_setup_pci_device+0x16e/0x330
 [<e4c42f70>] via82cxxx_chipsets+0x30/0xa0 [via82cxxx]
 [<e4c43140>] driver+0x0/0x80 [via82cxxx]
 [<c02bacfb>] ide_setup_pci_device+0x2b/0x80
 [<e4c42f70>] via82cxxx_chipsets+0x30/0xa0 [via82cxxx]
 [<c015d6be>] alloc_inode+0x17e/0x1b0
 [<e4c41dc8>] via_init_one+0x38/0x50 [via82cxxx]
 [<e4c42f70>] via82cxxx_chipsets+0x30/0xa0 [via82cxxx]
 [<c02522fe>] pci_device_probe+0x5e/0x70
 [<e4c430fc>] via_pci_tbl+0x1c/0x60 [via82cxxx]
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<c025ae23>] probe+0x23/0x30
 [<c025aebd>] found_match+0x2d/0x70
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<c025b05c>] do_driver_attach+0x5c/0x60
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<c025bcc1>] bus_for_each_dev+0x81/0x120
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<e4c43178>] driver+0x38/0x80 [via82cxxx]
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<c025b07e>] driver_attach+0x1e/0x30
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<c025b000>] do_driver_attach+0x0/0x60
 [<c025c1f6>] driver_register+0x76/0xb0
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<e4c43140>] driver+0x0/0x80 [via82cxxx]
 [<c025242b>] pci_register_driver+0x3b/0x50
 [<e4c43168>] driver+0x28/0x80 [via82cxxx]
 [<c02bae74>] ide_pci_register_driver+0x44/0x60
 [<e4c43140>] driver+0x0/0x80 [via82cxxx]
 [<e4c41def>] via_ide_init+0xf/0x20 [via82cxxx]
 [<e4c43140>] driver+0x0/0x80 [via82cxxx]
 [<c011b3f1>] sys_init_module+0x4e1/0x630
 [<e4c40060>] E __insmod_via82cxxx_O/lib/modules/2.5.43/kernel/drivers/ide/=
pci/via82cxxx.o_M3DB0015C_V132395+0x60/0x [via82cxxx]
 [<e4c40060>] E __insmod_via82cxxx_O/lib/modules/2.5.43/kernel/drivers/ide/=
pci/via82cxxx.o_M3DB0015C_V132395+0x60/0x80[via82cxxx]
 [<c01077cb>] syscall_call+0x7/0xb
Code: 8b 80 50 06 00 00 89 83 4c 06 00 00 8b 83 68 06 00 00 85 c0


>>EIP; c02bc44d <ide_iomio_dma+9d/190>   <=3D=3D=3D=3D=3D

>>ebx; c05a9a14 <ide_hwifs+754/4948>
>>esi; c05a9a24 <ide_hwifs+764/4948>
>>edi; 00009008 Before first symbol
>>esp; db32fd7c <_end+1ad7be3c/2468c140>

Code;  c02bc44d <ide_iomio_dma+9d/190>
00000000 <_EIP>:
Code;  c02bc44d <ide_iomio_dma+9d/190>   <=3D=3D=3D=3D=3D
   0:   8b 80 50 06 00 00         mov    0x650(%eax),%eax   <=3D=3D=3D=3D=
=3D
Code;  c02bc453 <ide_iomio_dma+a3/190>
   6:   89 83 4c 06 00 00         mov    %eax,0x64c(%ebx)
Code;  c02bc459 <ide_iomio_dma+a9/190>
   c:   8b 83 68 06 00 00         mov    0x668(%ebx),%eax
Code;  c02bc45f <ide_iomio_dma+af/190>
  12:   85 c0                     test   %eax,%eax


--=-MDuOYUFO+VTkVhhbgmIU
Content-Description: 
Content-Disposition: inline; filename=ide_iomio_dma.S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

0xc02bc3b0 <ide_iomio_dma>:	push   %ebp
0xc02bc3b1 <ide_iomio_dma+1>:	push   %edi
0xc02bc3b2 <ide_iomio_dma+2>:	push   %esi
0xc02bc3b3 <ide_iomio_dma+3>:	push   %ebx
0xc02bc3b4 <ide_iomio_dma+4>:	sub    $0x10,%esp
0xc02bc3b7 <ide_iomio_dma+7>:	mov    0x28(%esp,1),%edi
0xc02bc3bb <ide_iomio_dma+11>:	mov    0x2c(%esp,1),%ebp
0xc02bc3bf <ide_iomio_dma+15>:	movl   $0xc03e2da0,(%esp,1)
0xc02bc3c6 <ide_iomio_dma+22>:	mov    0x24(%esp,1),%ebx
0xc02bc3ca <ide_iomio_dma+26>:	lea    0xffffffff(%ebp,%edi,1),%eax
0xc02bc3ce <ide_iomio_dma+30>:	mov    %edi,0x8(%esp,1)
0xc02bc3d2 <ide_iomio_dma+34>:	lea    0x10(%ebx),%esi
0xc02bc3d5 <ide_iomio_dma+37>:	mov    %eax,0xc(%esp,1)
0xc02bc3d9 <ide_iomio_dma+41>:	mov    %esi,0x4(%esp,1)
0xc02bc3dd <ide_iomio_dma+45>:	call   0xc011a220 <printk>
0xc02bc3e2 <ide_iomio_dma+50>:	movl   $0xc041f154,(%esp,1)
0xc02bc3e9 <ide_iomio_dma+57>:	mov    %esi,0xc(%esp,1)
0xc02bc3ed <ide_iomio_dma+61>:	mov    %ebp,0x8(%esp,1)
0xc02bc3f1 <ide_iomio_dma+65>:	mov    %edi,0x4(%esp,1)
0xc02bc3f5 <ide_iomio_dma+69>:	call   0xc0120080 <__request_region>
0xc02bc3fa <ide_iomio_dma+74>:	test   %eax,%eax
0xc02bc3fc <ide_iomio_dma+76>:	je     0xc02bc523 <ide_iomio_dma+371>
0xc02bc402 <ide_iomio_dma+82>:	mov    0x558(%ebx),%edx
0xc02bc408 <ide_iomio_dma+88>:	mov    %edi,0x650(%ebx)
0xc02bc40e <ide_iomio_dma+94>:	mov    0x28(%edx),%ecx
0xc02bc411 <ide_iomio_dma+97>:	test   %ecx,%ecx
0xc02bc413 <ide_iomio_dma+99>:	je     0xc02bc422 <ide_iomio_dma+114>
0xc02bc415 <ide_iomio_dma+101>:	cmpb   $0x0,0x546(%ebx)
0xc02bc41c <ide_iomio_dma+108>:	je     0xc02bc4ee <ide_iomio_dma+318>
0xc02bc422 <ide_iomio_dma+114>:	mov    0x4(%ebx),%eax
0xc02bc425 <ide_iomio_dma+117>:	test   %eax,%eax
0xc02bc427 <ide_iomio_dma+119>:	je     0xc02bc4dd <ide_iomio_dma+301>
0xc02bc42d <ide_iomio_dma+125>:	mov    0x64c(%ebx),%eax
0xc02bc433 <ide_iomio_dma+131>:	test   %eax,%eax
0xc02bc435 <ide_iomio_dma+133>:	je     0xc02bc4cc <ide_iomio_dma+284>
0xc02bc43b <ide_iomio_dma+139>:	movzbl 0x546(%ebx),%eax
0xc02bc442 <ide_iomio_dma+146>:	test   %al,%al
0xc02bc444 <ide_iomio_dma+148>:	je     0xc02bc4b4 <ide_iomio_dma+260>
0xc02bc446 <ide_iomio_dma+150>:	test   %al,%al
0xc02bc448 <ide_iomio_dma+152>:	je     0xc02bc4b0 <ide_iomio_dma+256>
0xc02bc44a <ide_iomio_dma+154>:	mov    0x4(%ebx),%eax
0xc02bc44d <ide_iomio_dma+157>:	mov    0x650(%eax),%eax
0xc02bc453 <ide_iomio_dma+163>:	mov    %eax,0x64c(%ebx)
0xc02bc459 <ide_iomio_dma+169>:	mov    0x668(%ebx),%eax

--=-MDuOYUFO+VTkVhhbgmIU--

