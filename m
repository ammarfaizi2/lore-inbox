Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSDOLi2>; Mon, 15 Apr 2002 07:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312395AbSDOLi1>; Mon, 15 Apr 2002 07:38:27 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:55288 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312381AbSDOLi0>; Mon, 15 Apr 2002 07:38:26 -0400
Message-ID: <3CBABB92.8000307@wanadoo.fr>
Date: Mon, 15 Apr 2002 13:37:54 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020407
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg@kroah.com
CC: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.8 OOPS usb-uhci
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PIII 650 UP. kernel tainted by speedtch.o (usb Speedtouch Alcatel driver).
OOPS logged in /var/log/messages during shutdown (the 2 oops come together).
*It is not repeatable*. I haven't catched such oops with 2.5.8-pre3.

I hope it can help.


   ksymoops 2.4.5 on i686 2.5.8.  Options used
        -V (default)
        -k /proc/ksyms (default)
        -l /proc/modules (default)
        -o /lib/modules/2.5.8/ (default)
        -m /usr/src/linux/System.map (default)

   Warning: You did not tell me where to find symbol information.  I will
   assume that the log matches the kernel and modules that are running
   right now and I'll use the default options above for symbol resolution.
   If the current kernel and/or modules do not match the log, you can get
   more accurate output by telling me the kernel version and where to find
   map, modules, ksyms etc.  ksymoops -h explains the options.

   kernel BUG at usb.c:849!
   invalid operand: 0000
   CPU:    0
   EIP:    0010:[<d08b9a4e>]    Tainted: P
   Using defaults from ksymoops -t elf32-i386 -a i386
   EFLAGS: 00010246
   eax: 00000000   ebx: cf2d4000   ecx: cf56cf50   edx: 00000002
   esi: cf307988   edi: d08c8500   ebp: ffffffff   esp: cebd7f24
   ds: 0018   es: 0018   ss: 0018
   Stack: cf2d41f8 d08ba9ed cf2d4000 cf56cfbc cfe7fbbc d08c8480 0000000e
0000024c
          cf2d4000 d08ba9ae cf56cfbc cfe7fab4 d08cf740 cdd20000 d08ca000
000000c4
          cf56ce00 d08cdd6a cebd7f74 c13e2800 00000000 c018ef8f c13e2800
d08ca000
   Call Trace: [<d08ba9ed>] [<d08c8480>] [<d08ba9ae>] [<d08cf740>]
[<d08cdd6a>]
       [<c018ef8f>] [<d08ce296>] [<d08cf740>] [<c01182f7>] [<c0117579>]
[<c0106f2f>]
   Code: 0f 0b 51 03 14 3a 8c d0 8b 83 cc 00 00 00 8b 40 18 53 8b 40


EIP; d08b9a4e <[usbcore]usb_free_dev+26/5c>   <=====

ebx; cf2d4000 <_end+f073c20/105f2c20>
ecx; cf56cf50 <_end+f30cb70/105f2c20>
esi; cf307988 <_end+f0a75a8/105f2c20>
edi; d08c8500 <[usbcore]usbdevfs_driver+20/40>
ebp; ffffffff <END_OF_CODE+2f6ef3a0/????>
esp; cebd7f24 <_end+e977b44/105f2c20>

   Trace; d08ba9ed <[usbcore]usb_disconnect+145/150>
   Trace; d08c8480 <[usbcore]hub_driver+20/40>
   Trace; d08ba9ae <[usbcore]usb_disconnect+106/150>
   Trace; d08cf740 <[usb-uhci]uhci_pci_driver+0/3f>
   Trace; d08cdd6a <[usb-uhci]uhci_pci_remove+2a/c4>
   Trace; c018ef8f <pci_unregister_driver+33/4c>
   Trace; d08ce296 <[usb-uhci]uhci_hcd_cleanup+a/33>
   Trace; d08cf740 <[usb-uhci]uhci_pci_driver+0/3f>
   Trace; c01182f7 <free_module+17/c0>
   Trace; c0117579 <sys_delete_module+12d/27c>
   Trace; c0106f2f <syscall_call+7/b>

   Code;  d08b9a4e <[usbcore]usb_free_dev+26/5c>
   00000000 <_EIP>:
   Code;  d08b9a4e <[usbcore]usb_free_dev+26/5c>   <=====
      0:   0f 0b                     ud2a      <=====
   Code;  d08b9a50 <[usbcore]usb_free_dev+28/5c>
      2:   51                        push   %ecx
   Code;  d08b9a51 <[usbcore]usb_free_dev+29/5c>
      3:   03 14 3a                  add    (%edx,%edi,1),%edx
   Code;  d08b9a54 <[usbcore]usb_free_dev+2c/5c>
      6:   8c d0                     mov    %ss,%eax
   Code;  d08b9a56 <[usbcore]usb_free_dev+2e/5c>
      8:   8b 83 cc 00 00 00         mov    0xcc(%ebx),%eax
   Code;  d08b9a5c <[usbcore]usb_free_dev+34/5c>
      e:   8b 40 18                  mov    0x18(%eax),%eax
   Code;  d08b9a5f <[usbcore]usb_free_dev+37/5c>
     11:   53                        push   %ebx
   Code;  d08b9a60 <[usbcore]usb_free_dev+38/5c>
     12:   8b 40 00                  mov    0x0(%eax),%eax

   kernel BUG at /usr/gnu/linux/include/linux/usb.h:1074!
   invalid operand: 0000
   CPU:    0
   EIP:    0010:[<d08cbada>]    Tainted: P
   EFLAGS: 00010202
   eax: 00000001   ebx: cf2d4000   ecx: 00000001   edx: 00000003
   esi: 00000246   edi: cf38ea1c   ebp: ce471194   esp: cf22fee8
   ds: 0018   es: 0018   ss: 0018
   Stack: ce70ad84 cf38ea1c 00000246 cfe7fab4 d08cbd7d cfe7fab4 cf38ea1c
ce70ad84
          cf22e000 00000246 caa72e08 d08b9b56 cf38ea1c d08bf900 cf38ea1c
cf38e87c
          ffffffff c124f478 caa72e08 d08bfe99 cf38e87c cf5ed2e8 cbb3b9e4
c0136928
   Call Trace: [<d08cbd7d>] [<d08b9b56>] [<d08bf900>] [<d08bfe99>]
[fput+76/236]
   Call Trace: [<d08cbd7d>] [<d08b9b56>] [<d08bf900>] [<d08bfe99>]
[<c0136928>]
       [<c013542c>] [<c0118c78>] [<c0119347>] [<c0119536>] [<c0106f2f>]
   Code: 0f 0b 32 04 20 e4 8c d0 57 e8 e4 df fe ff 83 c4 04 eb 15 8d


EIP; d08cbada <[usb-uhci]uhci_unlink_urb_sync+142/174>   <=====

ebx; cf2d4000 <_end+f073c20/105f2c20>
edi; cf38ea1c <_end+f12e63c/105f2c20>
ebp; ce471194 <_end+e210db4/105f2c20>
esp; cf22fee8 <_end+efcfb08/105f2c20>

   Trace; d08cbd7d <[usb-uhci]uhci_unlink_urb+8d/98>
   Trace; d08b9b56 <[usbcore]usb_unlink_urb+26/38>
   Trace; d08bf900 <[usbcore]destroy_all_async+58/e4>
   Trace; d08bfe99 <[usbcore]usbdev_release+9d/ac>
   Trace; d08cbd7d <[usb-uhci]uhci_unlink_urb+8d/98>
   Trace; d08b9b56 <[usbcore]usb_unlink_urb+26/38>
   Trace; d08bf900 <[usbcore]destroy_all_async+58/e4>
   Trace; d08bfe99 <[usbcore]usbdev_release+9d/ac>
   Trace; c0136928 <fput+4c/ec>
   Trace; c013542c <filp_close+a0/ac>
   Trace; c0118c78 <put_files_struct+50/b8>
   Trace; c0119347 <do_exit+103/2cc>
   Trace; c0119536 <sys_exit+e/10>
   Trace; c0106f2f <syscall_call+7/b>

   Code;  d08cbada <[usb-uhci]uhci_unlink_urb_sync+142/174>
   00000000 <_EIP>:
   Code;  d08cbada <[usb-uhci]uhci_unlink_urb_sync+142/174>   <=====
      0:   0f 0b                     ud2a      <=====
   Code;  d08cbadc <[usb-uhci]uhci_unlink_urb_sync+144/174>
      2:   32 04 20                  xor    (%eax,1),%al
   Code;  d08cbadf <[usb-uhci]uhci_unlink_urb_sync+147/174>
      5:   e4 8c                     in     $0x8c,%al
   Code;  d08cbae1 <[usb-uhci]uhci_unlink_urb_sync+149/174>
      7:   d0 57 e8                  rclb   0xffffffe8(%edi)
   Code;  d08cbae4 <[usb-uhci]uhci_unlink_urb_sync+14c/174>
      a:   e4 df                     in     $0xdf,%al
   Code;  d08cbae6 <[usb-uhci]uhci_unlink_urb_sync+14e/174>
      c:   fe                        (bad)
   Code;  d08cbae7 <[usb-uhci]uhci_unlink_urb_sync+14f/174>
      d:   ff 83 c4 04 eb 15         incl   0x15eb04c4(%ebx)
   Code;  d08cbaed <[usb-uhci]uhci_unlink_urb_sync+155/174>
     13:   8d 00                     lea    (%eax),%eax



Pierre
------------------------------------------------
   Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------


