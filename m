Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTKRXxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 18:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTKRXxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 18:53:10 -0500
Received: from mid-1.inet.it ([213.92.5.18]:6053 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S263830AbTKRXxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 18:53:04 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: test9 and bluetooth
Date: Wed, 19 Nov 2003 00:52:45 +0100
User-Agent: KMail/1.5.4
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311021853.47300.cova@ferrara.linux.it> <200311062240.38099.cova@ferrara.linux.it> <20031106231545.GN3345@conectiva.com.br>
In-Reply-To: <20031106231545.GN3345@conectiva.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311190052.45803.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made some other test for USB bluetooth issue, with 2.6.0-test9-bk29
(processor: PIV 2.4 ht - SMP kernel preempt, but UP and not preempt seems to 
do no difference at all).
All tests made with usb_hci and bluetooth modules loaded.

I've verified that removing USB bluetooth dongle I get the Oops (shown below).

Then, I've made up some tests:
I've tried to plug in and remove usb dongle without hcid and sdpd loaded and 
all goes fine, without lockups.

If I remove the dongle after boot and after firing up hcid and sdpd, the crash 
is granted. (dongle inserted before powering on the machine)

Finally, I've tried this: no dongle plugged, booted the machine, fired up hcid 
and sdpd, inserted the dongle, (seen by the system), removed it (also seen by 
the system, no harm), inserted again, removed - BOOM.

When the dongle is inserted, I can see this on syslog:
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f75dd814 err -90

..or this:
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f71f7c14 err -22


Hope this can shed some light; I can made any test needed to narrow down this 
issue, just let me know.

Below I've reported one of Oops (obtained via serial interface).
I've got several of them, they differs in EIP and process, but the first item 
in call trace is always [<f897c4b9>] uhci_irq+0x67/0x1ca [uhci_hcd]

Hope This Helps..

Best regards.


Unable to handle kernel paging request at virtual address 80000234
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<f897c3ed>]    Tainted: P
EFLAGS: 00010046
EIP is at uhci_remove_pending_qhs+0x95/0xfa [uhci_hcd]
eax: 80000234   ebx: 00000093   ecx: 80000200   edx: f55aca24
esi: f74d4e0c   edi: f6024000   ebp: f74d4e18   esp: f6025e5c
ds: 007b   es: 007b   ss: 0068
Process hcid (pid: 2434, threadinfo=f6024000 task=f4c25310)
Stack: 00000296 f74d4e0c f74d4c00 00000000 f74d4c00 0000c000 f6025ef8 f897c4b9
       f74d4c00 00000000 f6921780 f74d4c00 00000001 00000000 f6025ef8 c02b9b4e
       f74d4c00 f6025ef8 f7d53c80 04000001 c010b617 00000013 f74d4c00 f6025ef8
Call Trace:
 [<f897c4b9>] uhci_irq+0x67/0x1ca [uhci_hcd]
 [<c02b9b4e>] usb_hcd_irq+0x36/0x5f
 [<c010b617>] handle_IRQ_event+0x3a/0x64
 [<c010b9d8>] do_IRQ+0xb8/0x196
 [<c0109d20>] common_interrupt+0x18/0x20
 [<f8a0e7e1>] hci_sock_release+0x126/0x23e [bluetooth]
 [<c02cd132>] sock_close+0x0/0x4d
 [<c02cc7c4>] sock_release+0x9d/0xfc
 [<c02cd132>] sock_close+0x0/0x4d
 [<c02cd165>] sock_close+0x33/0x4d
 [<c015c957>] __fput+0x12c/0x165
 [<c015ad89>] filp_close+0x59/0x96
 [<c015ae45>] sys_close+0x7f/0xdd
 [<c01093b3>] syscall_call+0x7/0xb

Code: 89 69 34 89 45 04 89 02 89 50 04 8b 54 24 08 c6 82 14 02 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

