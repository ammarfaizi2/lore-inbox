Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264559AbTCZCmv>; Tue, 25 Mar 2003 21:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264560AbTCZCmv>; Tue, 25 Mar 2003 21:42:51 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:61189 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264559AbTCZCmt>; Tue, 25 Mar 2003 21:42:49 -0500
Date: Wed, 26 Mar 2003 03:53:56 +0100 (CET)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.51L.0303260335420.24751@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Mar 2003, Linus Torvalds wrote:
> A lot of changes all over. Most notably probably the fbcon updates

* And this changes aren't good for tdfx driver :(
I've got Voodoo3:
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
        Flags: 66Mhz, fast devsel, IRQ 11
        Memory at e4000000 (32-bit, non-prefetchable) [size=32M]
        Memory at e8000000 (32-bit, prefetchable) [size=32M]
        I/O ports at c000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
        Capabilities: [60] Power Management version 1

Only 8-bit works (more or less) fine. 16-bit I have white letters on... 
white background :) Very nice for work :D In 2.5.64 I had white letters on 
brown-red backgound.
24-bit has also colours: white letter on very light blue.

My screen is completelly broken with green characters and small screen in
corner when I switch from X to console. It was before sometimes, now it's
always :(


* Next thing (sorry Linus for priv letter...):
[...]
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.66; fi
WARNING: /lib/modules/2.5.66/kernel/drivers/md/xor.ko needs unknown symbol kernel_fpu_begin
WARNING: /lib/modules/2.5.66/kernel/drivers/scsi/aha152x.ko needs unknown symbol scsi_put_command
WARNING: /lib/modules/2.5.66/kernel/drivers/scsi/aha152x.ko needs unknown symbol scsi_get_command
WARNING: /lib/modules/2.5.66/kernel/drivers/hotplug/acpiphp.ko needs unknown symbol acpi_resource_to_address64
#


The most important thing - I have a lot of oops in my logs. ~ 1 per 2 
seconds

Debug: sleeping function called from illegal context at mm/slab.c:1723
Call Trace:
 [<c011c414>] __might_sleep+0x54/0x60
 [<c013b86b>] kmalloc+0x4b/0xa0
 [<c02042b0>] accel_cursor+0xe0/0x2d0
 [<c011a919>] try_to_wake_up+0x179/0x220
 [<c0204678>] fb_vbl_handler+0x78/0xa0
 [<c0124e7c>] update_process_times+0x2c/0x40
 [<c0124d4d>] update_wall_time+0xd/0x40
 [<c0202e40>] cursor_timer_handler+0x10/0x30
 [<c0124fa8>] run_timer_softirq+0xf8/0x130
 [<c0202e30>] cursor_timer_handler+0x0/0x30
 [<c0121801>] do_softirq+0x51/0xb0
 [<c010c700>] do_IRQ+0xf0/0x110
 [<c010b064>] common_interrupt+0x18/0x20
 [<c01c6a3e>] acpi_processor_idle+0xfe/0x210
 [<c01c6940>] acpi_processor_idle+0x0/0x210
 [<c0109040>] default_idle+0x0/0x30
 [<c01090f2>] cpu_idle+0x32/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c0105055>] rest_init+0x55/0x60


My config is on URL: http://piorun.ds.pg.gda.pl/~blues/config-2.5.66.txt

-- 
---------------------------------
pozdr.  Pawe³ Go³aszewski        
---------------------------------
CPU not found - software emulation...
