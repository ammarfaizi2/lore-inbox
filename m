Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTAWP1g>; Thu, 23 Jan 2003 10:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbTAWP1g>; Thu, 23 Jan 2003 10:27:36 -0500
Received: from [193.137.96.140] ([193.137.96.140]:38330 "EHLO dwarf.utad.pt")
	by vger.kernel.org with ESMTP id <S265306AbTAWP1f>;
	Thu, 23 Jan 2003 10:27:35 -0500
Message-ID: <3E300BCE.9080909@alvie.com>
Date: Thu, 23 Jan 2003 15:35:42 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] 2.5.58 hangs at boot
References: <F760B14C9561B941B89469F59BA3A847137F76@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847137F76@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, all.

I have the same problem here with 2.5.57/8/9 with a Toshiba 2410 Laptop. 
Very funny also. The exact system lockup varies according to printk's 
inserted in the code.

>Can you stick a printk in ev_sci_handler and see if that's being called
>repeatedly?
>
Yes it is.

do_IRQ() is called for irq line 9, calls handle_IRQ_event() which then 
calls acpi_irq and finally ev_sci_handler().

This repeats 'ad infinitum'. Didn't wait for more than a few minutes, 
but it looks like it will.

The interrupts are handled at acpi_ev_gpe_detect (), which returns 1. At 
this point in_irq() returns 0x00010000 (or 0x00001000, don't have a 
serial console :/)

Any ideas ??? Need some more debugging ?

Funny enough, without the printk's it usually hangs at 
create_workqueue(), while doing wait_for_completion() - seems the kernel 
thread simply fails to get run.

-- 

Álvaro Lopes 
---------------------
A .sig is just a .sig


