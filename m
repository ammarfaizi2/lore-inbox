Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRBCF25>; Sat, 3 Feb 2001 00:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbRBCF2s>; Sat, 3 Feb 2001 00:28:48 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:60681 "EHLO
	musicman.sycamore.net") by vger.kernel.org with ESMTP
	id <S129436AbRBCF23>; Sat, 3 Feb 2001 00:28:29 -0500
Message-ID: <3A7B96ED.7030901@earthlink.net>
Date: Fri, 02 Feb 2001 21:28:13 -0800
From: Martin Bogomolni <andovernet@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-SMP i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Missing modversions.h in module sources for 2.4.x?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While trying to compile a new driver for an 802.11 pci card, I started
work on upgrading the linux-wlan utilites to 2.4.0.   Other than the
usual small things (like replacing references to kfree_s with kfree) the 
work was going pretty smoothly.

I spent a good hour though, trying to debug one problem.  The device 
driver depends on having netlink in the kernel.  When I attempted to 
load the driver however, it would give me an unresolved symbol error
for netlink_broadcast, and netlink_kernel_create.

A quick fgrep of /proc/ksyms showed the error.. No version information 
was included in the kernel symbol table.

e.g. When loading usb-storage.o, with an SMP compiled kernel + modversions :

insmod usb-storage
Using /lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved sd
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_deregister
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_free_dev
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_free_urb
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_inc_dev_use
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_alloc_urb
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_register
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_reset_device
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_string
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_submit_urb
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_control_msg
/lib/modules/2.4.1-SMP/kernel/drivers/usb/storage/usb-storage.o: 
unresolved symbol usb_unlink_urb

A quick peek at /proc/ksyms shows :

fgrep usb_match_id /proc/ksyms
c02817f0 usb_match_id_R__ver_usb_match_id

		~			~			~

The solution was to add the #include <linux/modversions.h> header
into each of the drivers affected.  However, I have a feeling that
there are a lot of these "gotchas" still out there in 2.4.

Thoughts?

Martin.
martinb@valinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
