Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVLZXRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVLZXRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVLZXRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:17:45 -0500
Received: from hermes.domdv.de ([193.102.202.1]:13325 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1750792AbVLZXRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:17:44 -0500
Message-ID: <43B07A17.5040707@domdv.de>
Date: Tue, 27 Dec 2005 00:17:43 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15rc6: ide oops+panic
References: <43AB20DA.2020506@domdv.de> <20051223053621.6c437cee.akpm@osdl.org>
In-Reply-To: <20051223053621.6c437cee.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Thanks.  Are you able to identify the most-recent kernel version which
> didn't do this?
> 

Bartlomiej's workaround (mount with "barrier=0") doesn't seem to help to
workaround the problem. I had one BUG/oops/panic (the same as reported)
after 96 hours of uptime and another one after only a few minutes of uptime.

Some more info on the disk setup (all partitions including root):

hda(1)/hdc(1)/hde(2) <-> 2x md raid5 <-> dm-crypt <-> lvm2 <-> ext3

(1) AMD8111
(2) PDC20268

Swap is set up as:

hda(1)/hdc(1)/hde(2) <-> dm-crypt <-> swap

(1) AMD8111
(2) PDC20268

I could start trying to find out where the problem started but will have
to start with 2.6.13 as I had other problems with earlier kernels.
Please let me know if you want me to go through this as each test run
will probably take a few days.

BTW: To prevent bit error speculations, just before initially reporting
the problem I did run >200 hours of memtest with no errors and all
memory is ECC.

If it helps, here is some information from /proc/interrupts:

           CPU0       CPU1
  0:     357569    1104266    IO-APIC-edge  timer
  1:          1         35    IO-APIC-edge  i8042
  8:          0          1    IO-APIC-edge  rtc
  9:        240       2288   IO-APIC-level  acpi
 12:          1         92    IO-APIC-edge  i8042
 14:       4509     115633    IO-APIC-edge  ide0
 15:       1822     117156    IO-APIC-edge  ide1
 16:          1        195   IO-APIC-level  ohci_hcd:usb4
 19:        875          2   IO-APIC-level  eth0
 20:       1376     115699   IO-APIC-level  ide2, ide3
 21:          0          3   IO-APIC-level  ohci1394, ohci_hcd:usb2,
ohci_hcd:usb3
 22:          0          4   IO-APIC-level  ehci_hcd:usb1
 23:          0          0   IO-APIC-level  ohci_hcd:usb5, AMD AMD8111
NMI:        221        161
LOC:    1460699    1461160
ERR:          0
MIS:          0

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
