Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTIOROp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 13:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTIOROp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 13:14:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:15521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261282AbTIOROn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 13:14:43 -0400
Date: Mon, 15 Sep 2003 10:11:48 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Ramon Casellas <casellas@infres.enst.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
In-Reply-To: <Pine.LNX.4.56.0309151417050.7490@gandalf.localdomain>
Message-ID: <Pine.LNX.4.33.0309151006060.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> IBM thinkpad X.31, Latest BIOS. Kernel, 2.6.0-test5-mm2 
> (I haven't been able to use power management features since 2.6.0-test2 or 
> so, with test4/test5 neither APM nor ACPI work.)

> --------------------------------------------
> title Gentoo 2.6.0-test5-mm2 ACPI
>     root (hd0,4)
>     kernel /vmlinuz-2.6.0-test5-mm2 ro root=0309 mem=1024M idebus=66 
> apm=off hdc=ide-cd hdc=ide-scsi
>     #initrd=(hd0,4)/initrd-acpi
>     resume=/dev/hda8
> --------------------------------------------
> 
> Module                  Size  Used by
...

Wow, that's a lot of modules. :) 

> trigger:
> echo 3 > /proc/acpi/sleep
> 
> (echo mem/disk/etc > /sys/power/state does nothing)

Try 'echo -n mem > /sys/power/state' 

> Unable to handle kern. Pag. req. virt. addr. fffffff4
> eip c0276506
> *pde = 00002067
> *pte = 00000000
> Oops 000 [#1]
> PREEMPT
> 
> CPU : 0
> eip 0060:[<c0276506>) not tainted vli
> eflags: 00010283
> EIP is at usb_device_suspend + 0x26/0x50

This is similar to a bug Pavel reported last week. Please try either 
removing the usb modules before you suspend, or applying the patch here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106315363102204&w=2


Thanks,



	Pat

