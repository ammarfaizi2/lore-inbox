Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbSKZTeF>; Tue, 26 Nov 2002 14:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSKZTeE>; Tue, 26 Nov 2002 14:34:04 -0500
Received: from bozo.vmware.com ([65.113.40.131]:4621 "EHLO mailout1.vmware.com")
	by vger.kernel.org with ESMTP id <S266654AbSKZTdy>;
	Tue, 26 Nov 2002 14:33:54 -0500
Date: Tue, 26 Nov 2002 10:45:36 -0800
From: chrisl@vmware.com
To: USB Devel <linux-usb-users@lists.sourceforge.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: EHCI Kernel panic on current BK 2.5
Message-ID: <20021126184536.GB1519@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to setup the usb 2.0 hard disk on my desktop in 2.5.
It works great with uhci driver. (2.4 and 2.5).

When I try modprobe ehci-hcd in 2.5. Kernel panic. It seems
that kernel OOPS inside the panic handle code again.

I can't get the full OOPS from the serial console either.

I am typing it here. I can only see the last screen.
It might have some typo and emotion.

EIP is at scheduler_tick+0x92/0x360
eax: 00000000 ebx: 00000000 ecx: 00000001  edx: 00000003
esi: dd5e3000 edi: 00000001 ebp: dd5b9ed0  esp: dd5b9ec0
ds: 0068   es: 0068  ss:068
Process (pid:26, threadinfo=dd5b8000 task=dd5e3000)
Stack: 0000002 000000 0000001 000000 dd5b9f80
....
Call Trace:
[<c011de1a>] update_process_times+0x2a/0x30
[<c011dffa>] do_timer+0x2a/0xf0
[<c010de22>] timer_interrupt+0x22/0x130
             __call_console_drivers+0x46/0x60
	     handle_IRQ_event+0x2a/0x60
             do_IRQ+0xa0/0x130
             common_interrupt+0x18/0x20
             xfrm4_dst_destory+0x8/0x20
             xfrm4_dst_detrory+0x8/0x20
             die+0x5c/0x80
             do_page_fault+0x14e/0x467

Code: 0f ab 50 08 8d 65 f4 5b 5e 5f 5d c3 89 f6 b8 00 e0 ff ff 21
 <0>Kerenl panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


Here is another one without the serial console:

Call Trace:
	    update_process_times+0x2a/0x30
	    do_timer+0x2a/0xf0
	    timer_interrupt_0x22/0xff
	    _call_console_drivers+0x46/0x60
	    handle_IRQ_event+0x2a/0x60
	    do_IRQ+0xa0/0x130
	    do_page_fault+0x43/0x467
	    do_page_fault_0x43/0x467
            common_interupt+0x18/0x20
            do_page_fault+0x43/0x467
            do_page_fault+0x43/0x467
            xfrm4_dst_destroy+0x8/0x30
	    xfrm4_dst_destroy+0x8/0x30
            die+0x5c/0x80
	    do_page_fault+0x14e/0x467
	    scrup+0x100/0x110
            vgacon_consor+0x168/0x1f0

Code: <same as above>

PS. I notice that some line are duplicated. That is the way
it is on the screen.



