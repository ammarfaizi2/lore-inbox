Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSG2Nr1>; Mon, 29 Jul 2002 09:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSG2Nr0>; Mon, 29 Jul 2002 09:47:26 -0400
Received: from mail.wolnet.de ([213.178.16.8]:18880 "HELO wolnet.de")
	by vger.kernel.org with SMTP id <S317112AbSG2NrZ>;
	Mon, 29 Jul 2002 09:47:25 -0400
From: Peter <pk@q-leap.com>
To: linux-kernel@vger.kernel.org, johannes@erdfelt.com
Subject: oops with usb-serial converter
Reply-to: pk@q-leap.com
Message-Id: <S.0001006613@wolnet.de>
Date: Mon, 29 Jul 2002 15:50:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the attached kernel oops happens repeatable

Hardware:
  Dell Inspiron 2600 Laptop
  USB-Serial Converter: UC-232A

Software:
  minicom (V1.82.1)
  kernel: 2.4.19-rc3
          2.4.19-rc3-ac3

Description:
  After modprobing the appropiate modules (pl2303, usbserial, usbcore,
  uhci) and calling minicom on the device (/dev/usb/tts/0), everything
  seems fine (can login, etc). But after exiting minicom, it ends with a
  segmentation fault and the oops occurs.  So the oops always occurs at
  the moment I exit minicom.  The oops also occurs when running a getty
  on the device.  After that, I cannot remove the modules anymore.


ksymoops < the_oops.txt:

--------------------------------------8<--------------------------------------


Unable to handle kernel NULL pointer dereference at virtual address 00000014
c8bb0345
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c8bb0345>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c48fc800   ebx: ffffff8d   ecx: c4f1d800   edx: 00000000
esi: c545a420   edi: 00000000   ebp: 00000246   esp: c1dbbe70
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 571, stackpage=c1dbb000)
Stack: ffffff8d c545a420 00000000 00000282 c8bb1a78 c545a420 c545a428 c545a420
       00000286 c5452060 00000001 00000000 c48fcc00 c23781d4 c8bb0fd0 c545a420
       c4f1d87c c4f1d820 ffffffff c4f1d800 00000064 c23781d4 c8b9604e c545a420
Call Trace:    [<c8bb1a78>] [<c8bb0fd0>] [<c8b9604e>] [<c8baaee9>] [<c8ba4484>]
  [<c01b4d80>] [<c017a6d6>] [<c017a650>] [<c0142486>] [<c014388f>] [<c0141f38>]
  [<c01b53ae>] [<c0131ff4>] [<c0131045>] [<c0131093>] [<c01086ab>]
Code: 8b 52 14 8b 42 e8 8b 7a ec 25 00 00 00 2f 0d 00 00 80 01 89

>>EIP; c8bb0344 <[uhci]uhci_reset_interrupt+24/a0>   <=====
Trace; c8bb1a78 <[uhci]uhci_call_completion+170/1b0>
Trace; c8bb0fd0 <[uhci]uhci_unlink_urb+168/174>
Trace; c8b9604e <[usbcore]usb_unlink_urb+26/30>
Trace; c8baaee8 <[pl2303]pl2303_close+14c/194>
Trace; c8ba4484 <[usbserial]serial_close+a0/b0>
Trace; c01b4d80 <release_dev+240/4fc>
Trace; c017a6d6 <reiserfs_delete_inode+86/98>
Trace; c017a650 <reiserfs_delete_inode+0/98>
Trace; c0142486 <destroy_inode+26/2c>
Trace; c014388e <iput+1ce/1d8>
Trace; c0141f38 <d_delete+4c/6c>
Trace; c01b53ae <tty_release+a/10>
Trace; c0131ff4 <fput+4c/d0>
Trace; c0131044 <filp_close+54/60>
Trace; c0131092 <sys_close+42/54>
Trace; c01086aa <system_call+32/38>
Code;  c8bb0344 <[uhci]uhci_reset_interrupt+24/a0>
00000000 <_EIP>:
Code;  c8bb0344 <[uhci]uhci_reset_interrupt+24/a0>   <=====
   0:   8b 52 14                  mov    0x14(%edx),%edx   <=====
Code;  c8bb0346 <[uhci]uhci_reset_interrupt+26/a0>
   3:   8b 42 e8                  mov    0xffffffe8(%edx),%eax
Code;  c8bb034a <[uhci]uhci_reset_interrupt+2a/a0>
   6:   8b 7a ec                  mov    0xffffffec(%edx),%edi
Code;  c8bb034c <[uhci]uhci_reset_interrupt+2c/a0>
   9:   25 00 00 00 2f            and    $0x2f000000,%eax
Code;  c8bb0352 <[uhci]uhci_reset_interrupt+32/a0>
   e:   0d 00 00 80 01            or     $0x1800000,%eax
Code;  c8bb0356 <[uhci]uhci_reset_interrupt+36/a0>
  13:   89 00                     mov    %eax,(%eax)


--------------------------------------8<--------------------------------------



Greetings,

	Peter

