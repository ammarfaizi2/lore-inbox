Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264186AbUDVQN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbUDVQN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbUDVQN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:13:58 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:21698 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S264186AbUDVQMt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:12:49 -0400
From: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
To: Len Brown <len.brown@intel.com>
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Thu, 22 Apr 2004 18:15:58 +0200
User-Agent: KMail/1.6.2
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com> <200404221553.51585.christian.kroener@tu-harburg.de> <1082647660.16337.243.camel@dhcppc4>
In-Reply-To: <1082647660.16337.243.camel@dhcppc4>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404221815.58702.christian.kroener@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 17:27, you wrote:
> On Thu, 2004-04-22 at 09:53, Christian Kröner wrote:
> > since its becoming fancy to post dmidecode output
>
> Thanks.  BTW. sending the dmidecode directly to me should be sufficient
> should you have need to do so again.
>
> > another thing i recently noticed (running 2.6.6-rc2-mm1
> > now) is that the last XT-PIC interrupt is gone now. i had cascade on
> > irq2
> > routed as XT-PIC before, now cascade (whatever it is) doesnt exist
> > anymore ;).
>
> Yes, this is normal on ACPI+IOAPIC configs going forward
> details here:  http://bugzilla.kernel.org/show_bug.cgi?id=2564
>
> > /proc/interrupts now:
> >
> >   0:   32184529    IO-APIC-edge  timer
> >   1:       1741    IO-APIC-edge  i8042
> >   7:          0    IO-APIC-edge  parport0
> >   8:          4    IO-APIC-edge  rtc
> >   9:          0   IO-APIC-level  acpi
> >  12:       9229    IO-APIC-edge  i8042
> >  14:     107111    IO-APIC-edge  ide0
> >  15:         92    IO-APIC-edge  ide1
> >  16:       3138   IO-APIC-level  ide2, saa7134[0]
> >  17:        153   IO-APIC-level  CMI8738
> >  19:    2732391   IO-APIC-level  nvidia
> >  20:    4315754   IO-APIC-level  ohci_hcd, eth0
> >  21: 1167427697   IO-APIC-level  ehci_hcd
> >  22:         79   IO-APIC-level  ohci_hcd
> >
> >
> > another thing that bugs me a little (a little offtopic here maybe), is
> > the
> > irq21 of ehci_hcd seems to get hit about twice as often as the timer
> > irq
> > although im not at all using USB...   any suggestions? maybe i start a
> > second
> > thread on this one...
>
> Better yet, file a bug and we'll look at your ehci interrupt issue in
> detail.
>
> thanks,
> -Len
>
> How to file a bug against ACPI:
>
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>
> For failure and success case, please attach
> 1. dmesg -s64000, or serial console using "debug" on cmdline.
>   (increase CONFIG_LOG_BUF_SHIFT if it doesn't get back to beginning)
> 2. /proc/interrupts
> 3. lspci -v
>
> Please attach the output from acpidmp, available in /usr/sbin/, or in
> pmtools:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Since I don't know which category of ACPI bugtracking my "bug" fits into I 
send the symptom here:

cat /proc/interrupts

  0:   41075417    IO-APIC-edge  timer
  1:      27326    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     226123    IO-APIC-edge  i8042
 14:     152298    IO-APIC-edge  ide0
 15:         92    IO-APIC-edge  ide1
 16:      28174   IO-APIC-level  ide2, saa7134[0]
 17:      86370   IO-APIC-level  CMI8738
 19:    3500294   IO-APIC-level  nvidia
 20:    5858400   IO-APIC-level  ohci_hcd, eth0
 21: 2678002320   IO-APIC-level  ehci_hcd
 22:         79   IO-APIC-level  ohci_hcd
NMI:      13435 
LOC:   40935121 
ERR:          0
MIS:          0

and the same only 5 seconds later:

  0:   41082729    IO-APIC-edge  timer
  1:      27350    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     226123    IO-APIC-edge  i8042
 14:     152313    IO-APIC-edge  ide0
 15:         92    IO-APIC-edge  ide1
 16:      28243   IO-APIC-level  ide2, saa7134[0]
 17:      86515   IO-APIC-level  CMI8738
 19:    3500917   IO-APIC-level  nvidia
 20:    5859792   IO-APIC-level  ohci_hcd, eth0
 21: 2679242125   IO-APIC-level  ehci_hcd
 22:         79   IO-APIC-level  ohci_hcd
NMI:      13438 
LOC:   40942396 
ERR:          0
MIS:          0

It seems as if irq21 (ehci_hcd) got hit 1 239 805 times in only 5 seconds 
without me even using USB in that period.


Please tell me into which category I should file this issue and I will happily 
file a bug report right after...

thanks, christian.
