Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbUDYCu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUDYCu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 22:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUDYCu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 22:50:57 -0400
Received: from fmr10.intel.com ([192.55.52.30]:61881 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262719AbUDYCuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 22:50:50 -0400
Subject: Re: Two problems after upgrade tto 2.4.26
From: Len Brown <len.brown@intel.com>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F981B@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F981B@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082861443.3160.18.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Apr 2004 22:50:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-23 at 04:22, Martin Knoblauch wrote:

Re: keyboard/mouse instability with ACPI enabled starting in 2.4.26

> >Does /proc/interrupts show any acpi events?
> >Did it in 2.4.23?
> >
> Len,
> 
>   some ACPI Interrupts:
> 
> cat /proc/interrupts
>            CPU0
>   0:      31464          XT-PIC  timer
>   1:        570          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   3:          5          XT-PIC  HiSax
>   8:          2          XT-PIC  rtc
>   9:       1197          XT-PIC  acpi
>  10:       1695          XT-PIC  eth0, usb-uhci, Texas Instruments
>  PCI1420, Texas Instruments PCI1420 (#2)
>  12:       5460          XT-PIC  PS/2 Mouse
>  14:      18052          XT-PIC  ide0
>  15:         11          XT-PIC  ide1

kill acpid and
# cat /proc/acpi/event
to see what the events are.
We we are working on a GPE issue related to spurious
ACPI interrupts right now, but I'd actually expect
2.4.26 to get _fewer_ acpi interrupts than 2.4.25, not more.

Re: fan running more
it would be interesting if you notice a temperature difference
between the releases in /proc/acpi/thermal...

eg.
cat /proc/acpi/thermal_zone/THRM/temperature
temperature:             37 C


FAN isn't always controlled by ACPI.  If it is, you'll see it
in the dmesg like this:
ACPI: Power Resource [PFAN] (off)
In either case, it may be that we're running hotter (say idle
isn't working right), or we're running the fan more often by mistake.

For idle, you can compare the /proc/acpi/processor/CPU0/power
file in the two releases to see if one release is getting into
a deeper power-saving state than the other.

Eg, this centrino box isn't getting into C3 because USB is active.

cat /proc/acpi/processor/CPU0/power
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00000010]
   *C2:                  promotion[C3] demotion[C1] latency[001]
usage[00370077]
    C3:                  promotion[--] demotion[C2] latency[085]
usage[00000000]


cheers,
-Len


