Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTLSSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 13:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLSSr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 13:47:29 -0500
Received: from auemail2.lucent.com ([192.11.223.163]:48102 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262772AbTLSSr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 13:47:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16355.11079.203110.404785@gargle.gargle.HOWL>
Date: Fri, 19 Dec 2003 11:45:59 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, grundig@teleline.es,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
In-Reply-To: <16336.3156.134104.991694@gargle.gargle.HOWL>
References: <Pine.LNX.4.58.0312041607180.27578@montezuma.fsmlabs.com>
	<16335.44623.99755.811085@gargle.gargle.HOWL>
	<Pine.LNX.4.58.0312041702470.27578@montezuma.fsmlabs.com>
	<16335.45013.813891.503104@gargle.gargle.HOWL>
	<Pine.LNX.4.58.0312042109140.27578@montezuma.fsmlabs.com>
	<16336.3156.134104.991694@gargle.gargle.HOWL>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just to followup, I've downloaded, compiled and installed 2.6.0 and
Len Brown's ACPI patch on my Dell Precision 610MT box and it's works
just fine.  I was never able to get 2.6.0-test11 with ACPI to work,
though I never put in Len's patch on there.  

The system is up and running now in SMP mode, so I think once 2.6.1
comes out with the ACPI updates, we should be all set.

I've got the following ACPI configuration options setup:

  CONFIG_ACPI=y
  CONFIG_ACPI_BOOT=y
  CONFIG_ACPI_INTERPRETER=y
  CONFIG_ACPI_AC=m
  CONFIG_ACPI_BATTERY=m
  CONFIG_ACPI_BUTTON=m
  CONFIG_ACPI_FAN=m
  CONFIG_ACPI_PROCESSOR=m
  CONFIG_ACPI_THERMAL=m
  CONFIG_ACPI_ASUS=m
  CONFIG_ACPI_TOSHIBA=m
  CONFIG_ACPI_DEBUG=y
  CONFIG_ACPI_BUS=y
  CONFIG_ACPI_EC=y
  CONFIG_ACPI_POWER=y
  CONFIG_ACPI_PCI=y
  CONFIG_ACPI_SYSTEM=y
  CONFIG_ACPI_RELAXED_AML=y
  CONFIG_SERIAL_8250_ACPI=y


If I get a chance over Xmas, I'll see about changing the RELAXED_AML
stuff as well.  But looking at my interrupts, they certainly don't
seem too balanced:

    > cat /proc/interrupts 
	       CPU0       CPU1       
      0:   31862628         48    IO-APIC-edge  timer
      1:        504          1    IO-APIC-edge  i8042
      2:          0          0          XT-PIC  cascade
      8:          4          0    IO-APIC-edge  rtc
     11:          0          1    IO-APIC-edge  Cyclom-Y
     12:      25139          0    IO-APIC-edge  i8042
     14:      14906          0    IO-APIC-edge  ide0
     15:      11947          0    IO-APIC-edge  ide1
     17:       6346          1   IO-APIC-level  eth0
     18:      46860          1   IO-APIC-level  aic7xxx, aic7xxx
     19:        140          0   IO-APIC-level  aic7xxx
    NMI:          0          0 
    LOC:   31867092   31867091 
    ERR:          0
    MIS:          0


I've got the following APIC config settings:

  CONFIG_X86_GOOD_APIC=y
  CONFIG_X86_LOCAL_APIC=y
  CONFIG_X86_IO_APIC=y


So I think that 2.6.1 and higher will work out of the box for the
problematic Dell boxes, once the right ACPI patches get added.

John

