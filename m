Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSFgy>; Sun, 19 Nov 2000 00:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKSFgo>; Sun, 19 Nov 2000 00:36:44 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:13607 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129136AbQKSFgd>; Sun, 19 Nov 2000 00:36:33 -0500
Message-ID: <3A175FB5.6C9EE37E@linux.com>
Date: Sat, 18 Nov 2000 21:05:57 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [oops] apm and tulip (eeprom.c) related in kernel 2.4.0 test11-pre7
Content-Type: multipart/mixed;
 boundary="------------E7527BCA591257D5EDB12823"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7527BCA591257D5EDB12823
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've been trying [unsuccessfully :S] to get the kernel's pcmcia
working.  I woke up this morning and found the following oops:

Unable to handle kernel NULL pointer dereference at virtual address
0000001b
c01d4dca
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d4dca>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: c84e9ec0   ebx: 00000000   ecx: c03560c8   edx: c376d140
esi: cbf7bbb4   edi: c376d000   ebp: 00000008   esp: cbf7bab4
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 2, stackpage=cbf7b000)
Stack: c376d070 cbf7bbb4 c376d000 c376d140 00000001 c03ae5cc 00000009
c376d140
       c01d9041 c376d000 cb236400 c0367040 cbf7bc0b cbfe2940 000000ff
0000000c
       cbf7bb34 18b0ffff c0344c40 2000bb10 ffffff30 00000000 00000003
00001880
Call Trace: [<c01d9041>] [<c0344c40>] [<c02190f1>] [<c0219337>]
[<c022450b>] [<c021c05b>] [<c021bfc0>]
       [<c021bf50>] [<c021c1e8>] [<c021c2a4>] [<c02205ec>] [<c02199a9>]
[<c0219a2d>] [<c0219a96>] [<c0219ac5>]
       [<c0115841>] [<c01158d5>] [<c011082d>] [<c0110aa4>] [<c0110b5b>]
[<c0110bd2>] [<c02cf0bc>] [<c011152a>]
       [<c010910f>] [<c0109118>]
Code: 80 7b 1b 00 0f 84 12 03 00 00 8b 4c 24 1c 83 b9 58 02 00 00

>>EIP; c01d4dca <tulip_parse_eeprom+17a/4a0>   <=====
Trace; c01d9041 <tulip_init_one+7bd/ccc>
Trace; c0344c40 <irda_crc16_table+5000/5200>
Trace; c02190f1 <pci_announce_device+2d/40>
Trace; c0219337 <pci_insert_device+5f/74>
Trace; c022450b <cb_alloc+1e7/220>
Trace; c021c05b <unreset_socket+93/100>
Trace; c021bfc0 <reset_socket+44/4c>
Trace; c021bf50 <setup_socket+ac/d8>
Trace; c021c1e8 <parse_events+7c/d4>
Trace; c021c2a4 <pcmcia_resume_socket+34/3c>
Trace; c02205ec <cardbus_resume+10/14>
Trace; c02199a9 <pci_pm_resume_device+19/20>
Trace; c0219a2d <pci_pm_resume_bus+29/54>
Trace; c0219a96 <pci_pm_resume+16/28>
Trace; c0219ac5 <pci_pm_callback+1d/24>
Trace; c0115841 <pm_send+2d/58>
Trace; c01158d5 <pm_send_all+2d/5c>
Trace; c011082d <send_event+65/70>
Trace; c0110aa4 <check_events+160/19c>
Trace; c0110b5b <apm_event_handler+7b/7c>
Trace; c0110bd2 <apm_mainloop+76/100>
Trace; c02cf0bc <error_table+4f8/39a4>
Trace; c011152a <apm+28a/29c>
Trace; c010910f <kernel_thread+1f/38>
Trace; c0109118 <kernel_thread+28/38>
Code;  c01d4dca <tulip_parse_eeprom+17a/4a0>
00000000 <_EIP>:
Code;  c01d4dca <tulip_parse_eeprom+17a/4a0>   <=====
   0:   80 7b 1b 00               cmpb   $0x0,0x1b(%ebx)   <=====
Code;  c01d4dce <tulip_parse_eeprom+17e/4a0>
   4:   0f 84 12 03 00 00         je     31c <_EIP+0x31c> c01d50e6
<tulip_parse_eeprom+496/4a0>
Code;  c01d4dd4 <tulip_parse_eeprom+184/4a0>
   a:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c01d4dd8 <tulip_parse_eeprom+188/4a0>
   e:   83 b9 58 02 00 00 00      cmpl   $0x0,0x258(%ecx)


        if (ee_data[27] == 0) {         /* No valid media table. */
 17a:   80 7b 1b 00             cmpb   $0x0,0x1b(%ebx)
 17e:   0f 84 12 03 00 00       je     496 <tulip_parse_eeprom+0x496>
        } else if (tp->chip_id == DC21041) {
 184:   8b 4c 24 1c             mov    0x1c(%esp,1),%ecx
 188:   83 b9 58 02 00 00 01    cmpl   $0x1,0x258(%ecx)
 18f:   0f 85 8b 00 00 00       jne    220 <tulip_parse_eeprom+0x220>

-d


--------------E7527BCA591257D5EDB12823
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------E7527BCA591257D5EDB12823--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
