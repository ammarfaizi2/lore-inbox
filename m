Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312996AbSDJRNg>; Wed, 10 Apr 2002 13:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313323AbSDJRNf>; Wed, 10 Apr 2002 13:13:35 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:23533 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312996AbSDJRNe>; Wed, 10 Apr 2002 13:13:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Johannes Erdfelt <johannes@erdfelt.com>
Subject: Re: 2.5.8-pre3: kernel BUG at usb.c:849! (preempt_count 1)
Date: Wed, 10 Apr 2002 19:11:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net,
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <E16vHsQ-0000Jy-00@baldrick> <20020410114144.N8314@sventech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vLdF-0000Dc-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I got a new oops, which I could decode:

ksymoops 2.4.5 on i586 2.5.8-pre3.  Options used
     -V (default)
     -k /var/log/ksymoops/20020410185940.ksyms (specified)
     -l /var/log/ksymoops/20020410185940.modules (specified)
     -o /lib/modules/2.5.8-pre3/ (specified)
     -m /boot/System.map-2.5.8-pre3 (specified)

kernel BUG at usb.c:849!
invalid operand: 0000
CPU:    0
EIP:    0010:[<cc8babe2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cb987800   ecx: cb987550   edx: 00000002
esi: c962c588   edi: cc8c7a20   ebp: ffffffff   esp: c93bff24
ds: 0018   es: 0018   ss: 0018
Stack: cb9879f8 cc8bbafe cb987800 cb9875bc cb763180 cc8c79a0 0000000e 0000024c 
       cb987800 cc8bbaad cb9875bc cb763080 cc8ce600 c991e000 cc8c9000 000000c4 
       cb987400 cc8ccc7a c93bff74 c12dc800 00000000 c01cf07f c12dc800 cc8c9000 
Call Trace: [<cc8bbafe>] [<cc8c79a0>] [<cc8bbaad>] [<cc8ce600>] [<cc8ccc7a>] 
Code: 0f 0b 51 03 94 42 8c cc 8b 83 cc 00 00 00 8b 40 18 53 8b 40 


>>EIP; cc8babe2 <[usbcore]usb_free_dev+26/5c>   <=====

>>ebx; cb987800 <_end+b6a64e0/c589ce0>
>>ecx; cb987550 <_end+b6a6230/c589ce0>
>>esi; c962c588 <_end+934b268/c589ce0>
>>edi; cc8c7a20 <[usbcore]usbdevfs_driver+20/40>
>>ebp; ffffffff <END_OF_CODE+337319bc/????>
>>esp; c93bff24 <_end+90dec04/c589ce0>

Trace; cc8bbafe <[usbcore]usb_disconnect+156/160>
Trace; cc8c79a0 <[usbcore]hub_driver+20/40>
Trace; cc8bbaad <[usbcore]usb_disconnect+105/160>
Trace; cc8ce600 <[usb-uhci]uhci_pci_driver+0/3f>
Trace; cc8ccc7a <[usb-uhci]uhci_pci_remove+2a/c0>

Code;  cc8babe2 <[usbcore]usb_free_dev+26/5c>
00000000 <_EIP>:
Code;  cc8babe2 <[usbcore]usb_free_dev+26/5c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  cc8babe4 <[usbcore]usb_free_dev+28/5c>
   2:   51                        push   %ecx
Code;  cc8babe5 <[usbcore]usb_free_dev+29/5c>
   3:   03 94 42 8c cc 8b 83      add    0x838bcc8c(%edx,%eax,2),%edx
Code;  cc8babec <[usbcore]usb_free_dev+30/5c>
   a:   cc                        int3   
Code;  cc8babed <[usbcore]usb_free_dev+31/5c>
   b:   00 00                     add    %al,(%eax)
Code;  cc8babef <[usbcore]usb_free_dev+33/5c>
   d:   00 8b 40 18 53 8b         add    %cl,0x8b531840(%ebx)
Code;  cc8babf5 <[usbcore]usb_free_dev+39/5c>
  13:   40                        inc    %eax

