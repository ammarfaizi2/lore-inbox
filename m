Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUDVP2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUDVP2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbUDVP2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:28:13 -0400
Received: from fmr10.intel.com ([192.55.52.30]:62937 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S264131AbUDVP2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:28:08 -0400
Subject: Re: IO-APIC on nforce2 [PATCH]
From: Len Brown <len.brown@intel.com>
To: Christian =?ISO-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Allen Martin <AMartin@nvidia.com>, ross@datscreative.com.au,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In-Reply-To: <200404221553.51585.christian.kroener@tu-harburg.de>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
	 <1082606439.16333.188.camel@dhcppc4>
	 <Pine.LNX.4.55.0404221414470.16448@jurand.ds.pg.gda.pl>
	 <200404221553.51585.christian.kroener@tu-harburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1082647660.16337.243.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 11:27:40 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 09:53, Christian Kröner wrote:
> since its becoming fancy to post dmidecode output

Thanks.  BTW. sending the dmidecode directly to me should be sufficient
should you have need to do so again.

> another thing i recently noticed (running 2.6.6-rc2-mm1 
> now) is that the last XT-PIC interrupt is gone now. i had cascade on
> irq2 
> routed as XT-PIC before, now cascade (whatever it is) doesnt exist 
> anymore ;).

Yes, this is normal on ACPI+IOAPIC configs going forward
details here:  http://bugzilla.kernel.org/show_bug.cgi?id=2564

> /proc/interrupts now:
> 
>   0:   32184529    IO-APIC-edge  timer
>   1:       1741    IO-APIC-edge  i8042
>   7:          0    IO-APIC-edge  parport0
>   8:          4    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:       9229    IO-APIC-edge  i8042
>  14:     107111    IO-APIC-edge  ide0
>  15:         92    IO-APIC-edge  ide1
>  16:       3138   IO-APIC-level  ide2, saa7134[0]
>  17:        153   IO-APIC-level  CMI8738
>  19:    2732391   IO-APIC-level  nvidia
>  20:    4315754   IO-APIC-level  ohci_hcd, eth0
>  21: 1167427697   IO-APIC-level  ehci_hcd
>  22:         79   IO-APIC-level  ohci_hcd


> another thing that bugs me a little (a little offtopic here maybe), is
> the 
> irq21 of ehci_hcd seems to get hit about twice as often as the timer
> irq 
> although im not at all using USB...   any suggestions? maybe i start a
> second 
> thread on this one...

Better yet, file a bug and we'll look at your ehci interrupt issue in
detail.

thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

For failure and success case, please attach
1. dmesg -s64000, or serial console using "debug" on cmdline.
  (increase CONFIG_LOG_BUF_SHIFT if it doesn't get back to beginning)
2. /proc/interrupts
3. lspci -v

Please attach the output from acpidmp, available in /usr/sbin/, or in
pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/



