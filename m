Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130677AbQLAB6f>; Thu, 30 Nov 2000 20:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130775AbQLAB60>; Thu, 30 Nov 2000 20:58:26 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:35077 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S130677AbQLAB6N>; Thu, 30 Nov 2000 20:58:13 -0500
Message-ID: <3A26FE24.80304@megapathdsl.net>
Date: Thu, 30 Nov 2000 17:25:56 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001127
X-Accept-Language: en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: johannes@erdfelt.com, linux-kernel@vger.kernel.org,
        linux-usb-users@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [patch] usb-uhci.c: fix for PCI-lockups/IRQ problems
In-Reply-To: <20001130110840.A2612@in.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Acher wrote:

> Hi,
> test12-pre3 had a large set of patches to usb-uhci.c. One small detail of
> this patch can make the driver to lockup the PCI bus with certain UHCI-chips
> (only Intel but not VIA, of course not on my machines...). This patch should 
> fix that.
> It also includes Linus' patch for the IRQ-setup.
> 

I am testing with this patch applied.

Here's an OOPS I got when plugging and unplugging my USB
mouse multiple times.

Unable to handle kernel paging request at virtual address 01cc0035
c589352c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c589352c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 01cc0011   ebx: 5508ec83   ecx: c4d39ef4   edx: c4a22b20
esi: c4a22b20   edi: c4d39f18   ebp: 00000064   esp: c4d39eb4
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 104, stackpage=c4d39000)
Stack: c4d39f08 c4a22b20 c4d39f18 00000064 00000000 00000286 c5825f46 
c4a22b20
        c582605a c4a22b20 c1fbd400 80000180 c1d39600 c4d39fdc c4d38000 
c4d39f08
        c4d39f08 00000000 00000000 c4d39f0c c4d39f0c 00000000 c4d39f20 
c4d39f20
Call Trace: [<c5825f46>] [<c582605a>] [<c5826183>] [<c5826210>] 
[<c582855d>] [<c5829324>] [<c582fcc8>]
        [<c58310cc>] [<c5829515>] [<c0108f0f>] [<c5825000>] [<c5827dbc>]
Code: 8b 40 24 89 44 24 14 83 78 10 00 75 0a b8 ed ff ff ff e9 4f

 >>EIP; c589352c <[usb-uhci]uhci_submit_urb+1c/28c>   <=====
Trace; c5825f46 <[usbcore]usb_submit_urb+1e/30>
Trace; c582605a <[usbcore]usb_start_wait_urb+aa/174>
Trace; c5826183 <[usbcore]usb_internal_control_msg+5f/74>
Trace; c5826210 <[usbcore]usb_control_msg+78/98>
Trace; c582855d <[usbcore]usb_get_port_status+35/3c>
Trace; c5829324 <[usbcore]usb_hub_events+b0/27c>
Trace; c582fcc8 <[usbcore]usb_bandwidth_option+26e0/271c>
Trace; c58310cc <[usbcore]khubd_wait+4/c>
Trace; c5829515 <[usbcore]usb_hub_thread+25/4c>
Trace; c0108f0f <kernel_thread+23/30>
Trace; c5825000 <[nls_iso8859-1].data.end+15e5/1645>
Trace; c5827dbc <[usbcore]init_module+0/0>
Code;  c589352c <[usb-uhci]uhci_submit_urb+1c/28c>
00000000 <_EIP>:
Code;  c589352c <[usb-uhci]uhci_submit_urb+1c/28c>   <=====
    0:   8b 40 24                  mov    0x24(%eax),%eax   <=====
Code;  c589352f <[usb-uhci]uhci_submit_urb+1f/28c>
    3:   89 44 24 14               mov    %eax,0x14(%esp,1)
Code;  c5893533 <[usb-uhci]uhci_submit_urb+23/28c>
    7:   83 78 10 00               cmpl   $0x0,0x10(%eax)
Code;  c5893537 <[usb-uhci]uhci_submit_urb+27/28c>
    b:   75 0a                     jne    17 <_EIP+0x17> c5893543 
<[usb-uhci]uhci_submit_urb+33/28c>
Code;  c5893539 <[usb-uhci]uhci_submit_urb+29/28c>
    d:   b8 ed ff ff ff            mov    $0xffffffed,%eax
Code;  c589353e <[usb-uhci]uhci_submit_urb+2e/28c>
   12:   e9 4f 00 00 00            jmp    66 <_EIP+0x66> c5893592 
<[usb-uhci]uhci_submit_urb+82/28c>


I hope this helps,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
