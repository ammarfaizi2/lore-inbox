Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129686AbQJ0T6u>; Fri, 27 Oct 2000 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129711AbQJ0T6k>; Fri, 27 Oct 2000 15:58:40 -0400
Received: from thalia.fm.intel.com ([132.233.247.11]:34834 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129686AbQJ0T6c>; Fri, 27 Oct 2000 15:58:32 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDB99@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Hunt Kent'" <kenthunt@yahoo.com>,
        "'lmcclef@lmc.ericsson.se'" <lmcclef@lmc.ericsson.se>,
        "'f5ibh@db0bm.ampr.org'" <f5ibh@db0bm.ampr.org>
Cc: Greg KH <greg@wirex.com>, "'kaos@ocs.com.au'" <kaos@ocs.com.au>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: test[9-10] USB depmod unresolved symbols 
Date: Fri, 27 Oct 2000 12:55:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hunt, Claude, Jean-Luc:

I'm hoping that this will help explain some of
the confusion that you have been or are seeing,
although it doesn't explain it fully for me,
but maybe it does for someone else (like Keith
Owens ?).

I was able to reproduce the problem that Hunt
described below.  'depmod -ae' gave me similar
output (but lots more of them since I compiled
everything possible as a USB module -- except
for the USB core [USB Support option]).

I'm currently using 2.4.0-test10-pre6.
My normal (?) kernel has NO USB built into it.
That is, I normally build USB all as modules.
Call this no-USB kernel 't10pre6'.

But for this test, I built usbcore into the kernel.
Call this usbcore-kernel 't10pre6-kuc'.

Now if I am running 't10pre6' (no USB in kernel)
and I do 'depmod -ae', I get lots of these
"Unresolved symbol" messages from depmod.
However, if I boot 't10pre6-kuc' (USBcore in kernel)
and i do 'depmod -ae', it works fine, no errors.

Is this like what you are seeing?
Are you seeing depmod errors before loading
the kernel that includes the USB core?

And finally (for anyone), is this the normal,
expected usage & behavior of depmod?

Thanks,
~Randy


> From: Hunt Kent [mailto:kenthunt@yahoo.com]
> 
> Okay, updates:
> 
> 	Compiled modutils 2.3.19 and the problem persists.
> Arch is i386, AMD K-6.
> 
> 	Result for modprobe -ae (test10-pre5):
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/dc2xx.o
> depmod:         usb_bulk_msg
> depmod:         usb_deregister
> depmod:         usb_free_dev
> depmod:         usb_inc_dev_use
> depmod:         usb_register
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/ov511.o
> depmod:         usb_deregister
> depmod:         usb_free_urb
> depmod:         usb_alloc_urb
> depmod:         usb_register
> depmod:         usb_submit_urb
> depmod:         usb_driver_release_interface
> depmod:         usb_control_msg
> depmod:         usb_set_interface
> depmod:         usb_unlink_urb
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/printer.o
> depmod:         usb_deregister
> depmod:         usb_register
> depmod:         usb_submit_urb
> depmod:         usb_set_interface
> depmod:         usb_unlink_urb
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/scanner.o
> depmod:         usb_bulk_msg
> depmod:         usb_deregister
> depmod:         usb_register
> depmod:         usb_submit_urb
> depmod:         usb_driver_release_interface
> depmod:         usb_unlink_urb
> 
> 	Let me know if you need more info.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
