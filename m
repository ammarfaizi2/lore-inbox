Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSIIPae>; Mon, 9 Sep 2002 11:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSIIPae>; Mon, 9 Sep 2002 11:30:34 -0400
Received: from mail4.caramail.com ([213.193.13.95]:46484 "EHLO
	mail4.caramail.com") by vger.kernel.org with ESMTP
	id <S317399AbSIIPa3>; Mon, 9 Sep 2002 11:30:29 -0400
From: Thierry BLIND <thierry.blind@caramail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <1031585610028066@caramail.com>
X-Mailer: Caramail - www.caramail.com
X-Originating-IP: [217.128.90.57]
Mime-Version: 1.0
Subject: PROBLEM: Oops when unloading usb-uhci module
Date: Mon, 09 Sep 2002 17:33:30 GMT+1
Content-Type: multipart/mixed; boundary="=_NextPart_Caramail_0280661031585610_ID"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Caramail_0280661031585610_ID
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello, this is my first kernel bug report, but since many
kernel releases ( at least >=3D 2.4.17 ) I fall on same the
bug, so I've decided to report this now :-)
 
Please, could I be personally CC'ed the answers/comments
posted to the list in response to my posting. Thanx :-)

[1.] One line summary of the problem:

Oops when unloading usb-uhci module

[2.] Full description of the problem/report:

Actually, I'm using an ECI USB ADSL modem (a Globescan
based-model) to connect to internet,
that requires to run (usermode) programs (see X. section) to
be recognized by the kernel (because there is no kernel
support yet). 

The only thing is, when I lose synchro or ppp connection, I
have to restart my modem by unloading and reloading usb-uhci
first, and run the usermode programs then again.

And that's where it "oops" (while unloading usb-uhci):-(

NB: After the first oops, when I try "insmod usb-uhci", it
oops again. But at this point, it's probably normal :-)
 
[3.] Keywords:

modules, usb, kernel 

[4.] Kernel version (from /proc/version):

2.4.19-8mdk (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk))

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.5 on i686 2.4.19-8mdk. Options used
 -V (default)
 -k /proc/ksyms (default)
 -l /proc/modules (default)
 -o /lib/modules/2.4.19-8mdk/ (default)
 -m /boot/System.map-2.4.19-8mdk (default)

*pde =3D 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01b72bd>] Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000 ebx: 1268e200 ecx: 00000000 edx: 1268e200
esi: 00000202 edi: 1268e200 ebp: d277de94 esp: d277de70
ds: 0018 es: 0018 ss: 0018
Process pppoeci (pid: 2482, stackpage=3Dd277d000)
Stack: d2634420 00000000 c01b72f4 00000000 1268e200 d7e14b60
d2634420 d7e14b60
 d7e14b60 d277dea8 dabce88a 00000000 d268e200 1268e200
d277dec0 dabcf645
 d7e14b60 d268e200 00000246 d48cee1c d277dee0 dabcfab4
d7e14b60 d2634420
Call Trace: [<c01b72f4>] [<dabce88a>] [<dabcf645>]
[<dabcfab4>] [<dabcfcc6>]
 [<dabbf26f>] [<dabc3600>] [<dabc3a7a>] [<c013adf2>]
[<c01397c8>] [<c011e447>]
 [<c011ea25>] [<c011ebe1>] [<c0108fe3>]
Code: 8b 01 39 c8 74 14 8b 50 0c 39 d3 72 07 03 51 18 39 d3
72 08
<6>usb.c: USB bus 2 deregistered
kmem_cache_destroy: Can't free all objects c142ea08
usb-uhci.c: urb_priv_kmem remained

>>EIP; c01b72bd <pool_find_page+d/30> <=3D=3D=3D=3D=3D

>>ebx; 1268e200 Before first symbol
>>edx; 1268e200 Before first symbol
>>edi; 1268e200 Before first symbol
>>ebp; d277de94 <_end+1248647c/1a520648>
>>esp; d277de70 <_end+12486458/1a520648>

Trace; c01b72f4 <pci_pool_free+14/e0>
Trace; dabce88a <[usbcore].bss.end+260b/8de1>
Trace; dabcf645 <[usbcore].bss.end+33c6/8de1>
Trace; dabcfab4 <[usbcore].bss.end+3835/8de1>
Trace; dabcfcc6 <[usbcore].bss.end+3a47/8de1>
Trace; dabbf26f <[usbcore]usb_unlink_urb+2f/40>
Trace; dabc3600 <[usbcore]destroy_all_async+70/80>
Trace; dabc3a7a <[usbcore]usbdev_release+4a/70>
Trace; c013adf2 <fput+e2/100>
Trace; c01397c8 <filp_close+38/60>
Trace; c011e447 <put_files_struct+67/d0>
Trace; c011ea25 <do_exit+a5/230>
Trace; c011ebe1 <sys_exit+11/20>
Trace; c0108fe3 <system_call+33/40>

Code; c01b72bd <pool_find_page+d/30>
00000000 <_EIP>:
Code; c01b72bd <pool_find_page+d/30> <=3D=3D=3D=3D=3D
 0: 8b 01 mov (%ecx),%eax <=3D=3D=3D=3D=3D
Code; c01b72bf <pool_find_page+f/30>
 2: 39 c8 cmp %ecx,%eax
Code; c01b72c1 <pool_find_page+11/30>
 4: 74 14 je 1a <_EIP+0x1a>
c01b72d7 <pool_find_page+27/30>
Code; c01b72c3 <pool_find_page+13/30>
 6: 8b 50 0c mov 0xc(%eax),%edx
Code; c01b72c6 <pool_find_page+16/30>
 9: 39 d3 cmp %edx,%ebx
Code; c01b72c8 <pool_find_page+18/30>
 b: 72 07 jb 14 <_EIP+0x14>
c01b72d1 <pool_find_page+21/30>
Code; c01b72ca <pool_find_page+1a/30>
 d: 03 51 18 add 0x18(%ecx),%edx
Code; c01b72cd <pool_find_page+1d/30>
 10: 39 d3 cmp %edx,%ebx
Code; c01b72cf <pool_find_page+1f/30>
 12: 72 08 jb 1c <_EIP+0x1c>
c01b72d9 <pool_find_page+29/30>

[6.] A small shell script or example program which triggers
the problem (if possible)

On my PC, I can easily reproduce the oops this way:

$ /sbin/modprobe usb-uhci
$ # Next 2 progs are from eciadsl-usermode_0.5.tgz
$ /usr/local/bin/eci-load1
/etc/eciadsl/eci_firm_kit_wanadoo.bin >log1.txt 2>&1
$ /usr/local/bin/eci-load2 /etc/eciadsl/eci_wan3.dmt.bin
>log2.txt 2>&1
$ # Call to my script "/etc/ppp/peers/adsl"
$ /usr/sbin/pppd call adsl
$ # Wait some time ...
$ sleep 5
$ kill -TERM `pidof pppd`
$ # And that's where it should "oops"
$ /sbin/modprobe -r usb-uhci

Sometimes, I have to re-run this script 2 or 3 times before
it "oops" really ...

[7.1.] Software (add the output of the ver_linux script here)
Linux phoenix.home 2.4.19-8mdk #1 Sat Aug 31 00:49:47 CEST
2002 i686 unknown unknown GNU/Linux
 
Gnu C 3.2
Gnu make 3.79.1
util-linux 2.11u
mount 2.11u
modutils 2.4.19
e2fsprogs 1.27ea
reiserfsprogs 3.6.3
PPP 2.4.1
Linux C Library 2.2.5
Dynamic linker (ldd) 2.2.5
Procps 2.0.7
Net-tools 1.60
Console-tools 0.2.3
Sh-utils 2.0.15
Modules Loaded n_hdlc ppp_synctty lp parport_pc
parport sr_mod floppy ppp_async ppp_generic slhc agpgart
NVdriver emu10k1 ac97_codec sound soundcore nfsd lockd
sunrpc ipchains usb-uhci usbcore af_packet ne 8390
nls_iso8859-15 nls_cp850 vfat fat ide-cd cdrom ide-scsi
scsi_mod rtc reiserfs

[7.2.] Processor information (from /proc/cpuinfo):

processor : 0
vendor_id : AuthenticAMD
cpu family : 6
model : 1
model name : AMD-K7(tm) Processor
stepping : 2
cpu MHz : 704.954
cache size : 512 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 sep
mtrr pge mca cmov pat mmx syscall mmxext 3dnowext 3dnow
bogomips : 1405.74

[7.3.] Module information (from /proc/modules):

usb-uhci 21676 0 (unused)
ppp_async 7456 0 (autoclean) (unused)
ppp_generic 20064 0 (autoclean) [ppp_async]
slhc 5072 0 (autoclean) [ppp_generic]
agpgart 31840 3 (autoclean)
lp 6720 0
parport_pc 21672 1
parport 23936 1 [lp parport_pc]
NVdriver 989312 10 (autoclean)
emu10k1 56172 0
ac97_codec 9928 0 [emu10k1]
sound 55732 0 [emu10k1]
soundcore 3780 0 [emu10k1 sound]
nfsd 66448 0 (autoclean)
lockd 46480 0 (autoclean) [nfsd]
sunrpc 60188 0 (autoclean) [nfsd lockd]
ipchains 39656 0 (unused)
usbcore 57984 1 [usb-uhci]
af_packet 13000 0 (autoclean)
ne 6544 1 (autoclean)
8390 6192 0 (autoclean) [ne]
nls_iso8859-15 3356 9 (autoclean)
nls_cp850 3580 9 (autoclean)
vfat 9556 9 (autoclean)
fat 31864 0 (autoclean) [vfat]
ide-cd 28744 0
cdrom 26848 0 [ide-cd]
ide-scsi 8180 0
scsi_mod 90436 1 [ide-scsi]
rtc 6560 0 (autoclean)
reiserfs 169776 3


[7.4.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
 Vendor: YAMAHA Model: CRW3200E Rev: 1.0d
 Type: CD-ROM ANSI SCSI
revision: 02

[X.] Other notes, patches, fixes, workarounds:

The tar that adds ECI modem support can be found under
http://prdownloads.sourceforge.net/eciadsl/eciadsl-usermode_0.5.tgz

In addition it includes all needed stuff to start an
internet connection through pppd. 

______________________________________________________
Bo=EEte aux lettres - Caramail - http://www.caramail.com


--=_NextPart_Caramail_0280661031585610_ID--

