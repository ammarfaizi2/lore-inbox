Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277323AbRJJRNp>; Wed, 10 Oct 2001 13:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277325AbRJJRNf>; Wed, 10 Oct 2001 13:13:35 -0400
Received: from smtprt15.wanadoo.fr ([193.252.19.210]:40680 "EHLO
	smtprt15.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S277323AbRJJRNU>; Wed, 10 Oct 2001 13:13:20 -0400
Message-ID: <3BC48100.3F4F0269@wanadoo.fr>
Date: Wed, 10 Oct 2001 19:10:24 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre10 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre10, Oops with ide/scsi
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've a DVD and a burner, both are on the same ide channel. I use
ide-scsi
emulation.
I've installed an audio disk in the DVD reader and tried toi read it
with
'xcdroast'. The automounter was active. I got a oops (description
follows) and
this oops was followed by many many others and finally a complete crash
of the
machine, even the magic keys where not active.

here are the messages and the raw oops, then the oops prcessed by
ksymoops. This is the only oops I've found in the log, many others
followed this one ...


automount[3141]: do_mount /dev/dvd /amnt/dvd/ type iso9660 options ro
using module generic
automount[3141]: mount(generic): calling mkdir_path /amnt/dvd/
automount[3141]: mount(generic): calling mount -t iso9660 -s -o ro
/dev/dvd /amnt/dvd/
kernel: scsi0 channel 0 : resetting for second half of retries.
kernel: SCSI bus is being reset for host 0 channel 0.
kernel: SCSI CD error : host 0 id 1 lun 0 return code = 18000002
kernel: sr0b:01: sns =  0  0 
kernel: Non-extended sense class 0 code 0x0 Raw sense data:0x00 0x00
0x00 0x00
kernel: CD-ROM I/O error: dev 0b:01, sector 586252
kernel: Unable to handle kernel paging request at virtual address
24bf0ad8
kernel: current->tss.cr3 = 0f0f7000, %%cr3 = 0f0f7000
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:
0010:[es1371:__insmod_es1371_O/lib/modules/2.2.20pre10/misc/es1371.o_M3B+-253763/96]
kernel: EFLAGS: 00010283
kernel: eax: d04b58d0   ebx: 551cec82   ecx: cf0fbf20   edx: d04b58cc
kernel: esi: cf0fbf20   edi: 00000001   ebp: cbb7abc4   esp: cf0fbe70
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process tntc (pid: 417, process nr: 19, stackpage=cf0fb000)
kernel: Stack: cbb7abc4 d04b7e54 00000000 00000000 00000000 cd431c00
00000001 00000002
kernel:        d0402b0b cf0fbf20 d04b7e54 00000000 00000282 cf0fbf20
cb625798 cf0fbf34
kernel:        00000100 cbb7abc4 cbb7ada8 d04b7e54 00000001 00000000
00000000 00000000
kernel: Call Trace: [<d04b7e54>]
[es1371:__insmod_es1371_O/lib/modules/2.2.20pre10/misc/es1371.o_M3B+-251125/96]
                [<d04b7e54>] [<d04b7e54>] [sock_recvmsg+65/192]
[do_select+487/512] [<d04b7d60>]

kernel:        [<d04b58cc>] [sock_read+132/148] [sys_read+178/208]
[common_interrupt+24/32] [system_call+52/56]
kernel: Code: 8b 04 98 50 e8 e6 0e 00 00 83 c4 10 4b 79 e8 5b 5e 83 c4
14
kernel: isofs_read_super: bread failed, dev=0b:01, iso_blknum=146563,
block=293126
automount[3141]: >> mount: wrong fs type, bad option, bad superblock on
/dev/dvd,
automount[3141]: >>        or too many mounted file systems



ksymoops 2.4.2 on i586 2.2.20pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.20pre10/ (default)
     -m /boot/System.map-2.2.20pre10 (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list
not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 24bf0ad8
current->tss.cr3 = 0f0f7000, %%cr3 = 0f0f7000
*pde = 00000000

Oops: 0000
CPU:    0
EIP:
0010:[es1371:__insmod_es1371_O/lib/modules/2.2.20pre10/misc/es1371.o_M3B+-253763/96]
EFLAGS: 00010283
eax: d04b58d0   ebx: 551cec82   ecx: cf0fbf20   edx: d04b58cc
esi: cf0fbf20   edi: 00000001   ebp: cbb7abc4   esp: cf0fbe70
ds: 0018   es: 0018   ss: 0018
Process tntc (pid: 417, process nr: 19, stackpage=cf0fb000)
Stack: cbb7abc4 d04b7e54 00000000 00000000 00000000 cd431c00 00000001
00000002
       d0402b0b cf0fbf20 d04b7e54 00000000 00000282 cf0fbf20 cb625798
cf0fbf34
       00000100 cbb7abc4 cbb7ada8 d04b7e54 00000001 00000000 00000000
00000000
Call Trace: [<d04b7e54>]
[es1371:__insmod_es1371_O/lib/modules/2.2.20pre10/misc/es1371.o_M3B+-251125/96]
        [<d04b7e54>] [<d04b7e54>] [sock_recvmsg+65/192]
[do_select+487/512] [<d04b7d60>]
        [<d04b58cc>] [sock_read+132/148] [sys_read+178/208]
[common_interrupt+24/32] [system_call+52/56]
Code: 8b 04 98 50 e8 e6 0e 00 00 83 c4 10 4b 79 e8 5b 5e 83 c4 14
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; d04b7e54 <[scc]SCC_Info+f4/a20>
Trace; d04b7e54 <[scc]SCC_Info+f4/a20>

Trace; d04b7e54 <[scc]SCC_Info+f4/a20>
Trace; d04b58cc <[scc]t_maxkeyup+0/154>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 04 98                  mov    (%eax,%ebx,4),%eax
Code;  00000002 Before first symbol
   3:   50                        push   %eax
Code;  00000004 Before first symbol
   4:   e8 e6 0e 00 00            call   eef <_EIP+0xeef> 00000eee
Before first symbol
Code;  00000008 Before first symbol
   9:   83 c4 10                  add    $0x10,%esp
Code;  0000000c Before first symbol
   c:   4b                        dec    %ebx
Code;  0000000c Before first symbol
   d:   79 e8                     jns    fffffff7 <_EIP+0xfffffff7>
fffffff6 <END_OF_CODE+2fade258/????>
Code;  0000000e Before first symbol
   f:   5b                        pop    %ebx
Code;  00000010 Before first symbol
  10:   5e                        pop    %esi
Code;  00000010 Before first symbol
  11:   83 c4 14                  add    $0x14,%esp


1 warning issued.  Results may not be reliable.


The configuration is :
K6-2 500 with 256MB SDRAM running linux 2.2.10pre10

Linux debian-f5ibh 2.2.20pre10 #1 mer oct 10 12:27:12 CEST 2001 i586
unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.27
util-linux             2.11h
modutils               2.4.10
e2fsprogs              tune2fs
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.27
util-linux             2.11h
modutils               2.4.10
e2fsprogs              tune2fs
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate bsd_comp ppp slhc nls_iso8859-15
isofs
sr_mod cdrom sg ide-scsi scsi_mod af_packet scc ax25 serial nfsd
parport_probe
parport_pc lp parport autofs lockd sunrpc es1371 soundcore usb-ohci
usbcore
w83781d i2c-proc i2c-isa i2c-core unix

-----------
Regards

                Jean-Luc
