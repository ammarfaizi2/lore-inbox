Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317818AbSGPOEg>; Tue, 16 Jul 2002 10:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317842AbSGPOEf>; Tue, 16 Jul 2002 10:04:35 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:8147 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317818AbSGPOEe>; Tue, 16 Jul 2002 10:04:34 -0400
Date: Tue, 16 Jul 2002 16:07:22 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: mdharm-usb@one-eyed-alien.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Breakage with "usb-storage: catch bad commands"
Message-ID: <20020716140722.GM7955@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	mdharm-usb@one-eyed-alien.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using the linux 2.5 BK head, I get an oops, just after:
	Initializing USB Mass Storage driver...
	usb.c: registered new driver usb-storage
	scsi0 : SCSI emulation for USB Mass Storage devices
	  Vendor: Sony      Model: MSC-U01N          Rev: 1.00
	  Type:   Direct-Access                      ANSI SCSI revision: 02

Just FYI, since the driver (probably more likely the SCSI layer)
stopped working some (2-3) kernel releases ago...

Thanks,

Stelian.

ksymoops 2.4.4 on i586 2.5.25.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.25/ (default)
     -m /boot/System.map-2.5.25 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at transport.c:351!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c78ed363>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: 000000ff   ebx: c137be00   ecx: c78efc20   edx: 00000024
esi: ffffffff   edi: 00000000   ebp: c137be00   esp: c4ebdf34
ds: 0018   es: 0018   ss: 0018
Stack: c137b800 c137be00 c137b800 c78edd1c c137be00 c137b800 00000000 c78ed7b5 
       c137be00 c137b800 00000000 c5650580 00000246 00000000 00000001 c5650580 
       c01128e1 c137be00 00000000 c137b800 c137b800 c78ed0ce c137be00 c137b800 
Call Trace: [<c78edd1c>] [<c78ed7b5>] [<c01128e1>] [<c78ed0ce>] [<c78f126c>] 
   [<c78ee74a>] [<c01122f0>] [<c0108519>] [<c78ee447>] [<c0106ea6>] [<c78ee447>] 
   [<c78f126c>] 
Code: 0f 0b 5f 01 c4 02 8f c7 5b 89 d0 5e 5f c3 8b 44 24 04 8b 40 

>>EIP; c78ed363 <[usb-storage]usb_stor_transfer_length+16b/179>   <=====
Trace; c78edd1c <[usb-storage]usb_stor_CB_transport+8c/b9>
Trace; c78ed7b5 <[usb-storage]usb_stor_invoke_transport+1b/239>
Trace; c01128e1 <default_wake_function+0/36>
Trace; c78ed0ce <[usb-storage]usb_stor_ufi_command+10a/132>
Trace; c78f126c <[usb-storage]usb_stor_sense_notready+0/14>
Trace; c78ee74a <[usb-storage]usb_stor_control_thread+303/3aa>
Trace; c01122f0 <schedule_tail+1a/1d>
Trace; c0108519 <ret_from_fork+5/14>
Trace; c78ee447 <[usb-storage]usb_stor_control_thread+0/3aa>
Trace; c0106ea6 <kernel_thread+26/30>
Trace; c78ee447 <[usb-storage]usb_stor_control_thread+0/3aa>
Trace; c78f126c <[usb-storage]usb_stor_sense_notready+0/14>
Code;  c78ed363 <[usb-storage]usb_stor_transfer_length+16b/179>
00000000 <_EIP>:
Code;  c78ed363 <[usb-storage]usb_stor_transfer_length+16b/179>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c78ed365 <[usb-storage]usb_stor_transfer_length+16d/179>
   2:   5f                        pop    %edi
Code;  c78ed366 <[usb-storage]usb_stor_transfer_length+16e/179>
   3:   01 c4                     add    %eax,%esp
Code;  c78ed368 <[usb-storage]usb_stor_transfer_length+170/179>
   5:   02 8f c7 5b 89 d0         add    0xd0895bc7(%edi),%cl
Code;  c78ed36e <[usb-storage]usb_stor_transfer_length+176/179>
   b:   5e                        pop    %esi
Code;  c78ed36f <[usb-storage]usb_stor_transfer_length+177/179>
   c:   5f                        pop    %edi
Code;  c78ed370 <[usb-storage]usb_stor_transfer_length+178/179>
   d:   c3                        ret    
Code;  c78ed371 <[usb-storage]usb_stor_blocking_completion+0/c>
   e:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  c78ed375 <[usb-storage]usb_stor_blocking_completion+4/c>
  12:   8b 40 00                  mov    0x0(%eax),%eax

 kernel BUG at scsiglue.c:150!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c78ec18f>]    Not tainted
EFLAGS: 00010002
eax: 00000003   ebx: 00000001   ecx: c137be00   edx: c137b800
esi: 00000292   edi: c137be00   ebp: c4efff28   esp: c4effef4
ds: 0018   es: 0018   ss: 0018
Stack: c4efe000 c788356b c137be00 c788303e c137ba00 00000000 00000000 00000000 
       c4efff34 c4efff34 43434700 00000086 c0256e90 00000000 00000000 00000000 
       c4efff34 c4efff34 00000246 c4efff58 c4efe000 c137be00 c137be58 00000000 
Call Trace: [<c788356b>] [<c788303e>] [<c7883398>] [<c7883f02>] [<c78ec066>] 
   [<c78846aa>] [<c0108519>] [<c78ec066>] [<c0106ea6>] [<c788454a>] 
Code: 0f 0b 96 00 c8 01 8f c7 8b 44 24 0c 89 81 00 01 00 00 89 8a 

>>EIP; c78ec18f <[usb-storage]queuecommand+32/60>   <=====
Trace; c788356b <[scsi_mod]scsi_send_eh_cmnd+ac/1e0>
Trace; c788303e <[scsi_mod]scsi_eh_done+0/6c>
Trace; c7883398 <[scsi_mod]scsi_test_unit_ready+85/10b>
Trace; c7883f02 <[scsi_mod]scsi_unjam_host+31f/967>
Trace; c78ec066 <[usb-storage]detect+0/28>
Trace; c78846aa <[scsi_mod]scsi_error_handler+160/1b2>
Trace; c0108519 <ret_from_fork+5/14>
Trace; c78ec066 <[usb-storage]detect+0/28>
Trace; c0106ea6 <kernel_thread+26/30>
Trace; c788454a <[scsi_mod]scsi_error_handler+0/1b2>
Code;  c78ec18f <[usb-storage]queuecommand+32/60>
00000000 <_EIP>:
Code;  c78ec18f <[usb-storage]queuecommand+32/60>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c78ec191 <[usb-storage]queuecommand+34/60>
   2:   96                        xchg   %eax,%esi
Code;  c78ec192 <[usb-storage]queuecommand+35/60>
   3:   00 c8                     add    %cl,%al
Code;  c78ec194 <[usb-storage]queuecommand+37/60>
   5:   01 8f c7 8b 44 24         add    %ecx,0x24448bc7(%edi)
Code;  c78ec19a <[usb-storage]queuecommand+3d/60>
   b:   0c 89                     or     $0x89,%al
Code;  c78ec19c <[usb-storage]queuecommand+3f/60>
   d:   81 00 01 00 00 89         addl   $0x89000001,(%eax)
Code;  c78ec1a2 <[usb-storage]queuecommand+45/60>
  13:   8a 00                     mov    (%eax),%al


1 warning issued.  Results may not be reliable.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
