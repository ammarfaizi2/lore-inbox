Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTAOLDr>; Wed, 15 Jan 2003 06:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAOLDr>; Wed, 15 Jan 2003 06:03:47 -0500
Received: from pd208.katowice.sdi.tpnet.pl ([213.76.228.208]:23936 "EHLO finwe")
	by vger.kernel.org with ESMTP id <S262838AbTAOLDn>;
	Wed, 15 Jan 2003 06:03:43 -0500
Date: Wed, 15 Jan 2003 12:12:35 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Cc: mdharm-usb@one-eyed-alien.net
Subject: 2.4.20/2.4.21-pre3 usb Oops
Message-ID: <20030115111234.GA1322@finwe.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	mdharm-usb@one-eyed-alien.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've got ide disk connected as usb-storage device.

Oops is reproductable (output from ksymoops below). 
I had to copy it from screen (I hope effects are 
reliable).


How I reproduced it:
--------------------
I loaded usb-storage (which loaded sd_mod), then sg, 
made copy of /proc/ksyms then tried to fdisk /dev/sda.

System:
-------

I've got 2.4.20 with preempt, but effect is similar
while running 2.4.21-pre3. I'm quite sure I could use 
it with 2.4.17/18.

While I was composing this message and tried to disconnect 
mentioned device system froze.

config: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4/config-2.4.20+p.gz
dmesg: http://zeus.polsl.gliwice.pl/~jfk/kernel/dmesg.gz

Logs (not 'directly' oops related)
----------------------------------
/etc/hotplug/usb.agent: Setup usb-storage for USB product 55aa/103/904
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb-uhci.c: interrupt, status 3, frame# 245
usb_control/bulk_msg: timeout
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.

----------------------------------
<Output from ksymoops:>

ksymoops 2.4.8 on i686 2.4.20+p.  Options used
     -V (default)
     -k ./ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20+p (specified)
     -m /boot/System.map-2.4.20+p (specified)

Warning (compare_ksyms_lsmod): module input is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module snd-mixer-oss is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module snd-pcm-oss is in lsmod but not in ksyms, probably no symbols exported
Error (compare_ksyms_lsmod): module sg is in ksyms but not in lsmod
Oops: 0000d
CPU: 0 <EIP: 0010:[<c012e548>] Not tainted
EFLAGS: 00010002
eax: 01e27c98 ebx: 6f732e78 ecx: 00000000 edx: c100001c
esi: 00000000 edi: 00000206 ebp: 00000000 esp: c8a03e84
ds: 0018 es: 0018 ss: 0018
Process usb.agent (pid 1560 stackpage=c8a03000)
Stack:    cfd54980 00000000 cff2ada0 00000000 c01b8b07 6f732e78 cff24800 00000000
          cff2ada0 00000000 00000000 d081e159 00000001 cfd54980 c01b7eec cff24800
          cff24800 00000000 d081eadf cff24800 c12e587c c12e5860 00000000 00000000
Call Trace: [<c01b8b07>] [<d081e159>] [<c01b7eec>] [<d081eadf>] [<d081ebca>] [<c010811d>] [<c0108311>] [<c0121274>] [<c0106d7b>] 
Code: 2b 59 0c 89 d8 31 d2 f7 76 18 89 c3 8b 41 14 89 44 99 18 89
Using defaults from ksymoops -t elf32-i386 -a i386


>>edx; c100001c <_end+d371c4/10548208>
>>esp; c8a03e84 <_end+873b02c/10548208>

Trace; c01b8b07 <usb_destroy_configuration+163/1b4>
Trace; d081e159 <[usb-uhci]uhci_free_dev+2d/34>
Trace; c01b7eec <usb_free_dev+24/3c>
Trace; d081eadf <[usb-uhci]process_urb+243/254>
Trace; d081ebca <[usb-uhci]uhci_interrupt+da/154>
Trace; c010811d <handle_IRQ_event+31/5c>
Trace; c0108311 <do_IRQ+b9/118>
Trace; c0121274 <sys_rt_sigprocmask+1f0/234>
Trace; c0106d7b <system_call+33/38>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   2b 59 0c                  sub    0xc(%ecx),%ebx
Code;  00000003 Before first symbol
   3:   89 d8                     mov    %ebx,%eax
Code;  00000005 Before first symbol
   5:   31 d2                     xor    %edx,%edx
Code;  00000007 Before first symbol
   7:   f7 76 18                  divl   0x18(%esi)
Code;  0000000a Before first symbol
   a:   89 c3                     mov    %eax,%ebx
Code;  0000000c Before first symbol
   c:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  0000000f Before first symbol
   f:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

<0> Kernel panic: Aiee, killing interrupt handler!

3 warnings and 1 error issued.  Results may not be reliable.

 
Jacek

-- 
Jacek Kawa
