Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbTHUOre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTHUOre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:47:34 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:43920 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262732AbTHUOrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:47:33 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Wes Janzen <superchkn@sbcglobal.net>
Subject: Re: 2.6.0-test3-mm3 reserve IRQ for isapnp (2.6.0-test3-mm3 <sigh>)
Date: Thu, 21 Aug 2003 16:47:08 +0200
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <3F440387.5090902@sbcglobal.net> <200308211223.05614.schlicht@uni-mannheim.de> <3F44B493.1080403@sbcglobal.net>
In-Reply-To: <3F44B493.1080403@sbcglobal.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308211647.09541.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 August 2003 14:01, Wes Janzen wrote:
> Thanks, I was supposed to try that too, but I forgot ;-)
>
> So I tried it.  Doesn't work...  It does change the IRQ assignments, but
> I don't think there would be any hope of it running without ACPI.  Isn't
> ACPI required for IRQ sharing?  If not then it might work.

No, ACPI is not required for interrupt sharing... So it might work ;-)

> It uses 6 IRQ's just between the IDE and USB...the thing's stuffed with
> cards.  Add video, SB16, 2 serial ports, parallel...well, you get the
> idea.
>
> Now if VIA would have made it correctly in the first place...
>
> Wes

Have you tried my patch? I'm running a kernel with this patch, ACPI enabled 
and "pci=noacpi". 16 IRQ's won't be enough for me, too, as you can see here:

           CPU0
  0:     348795    IO-APIC-edge  timer
  1:        627    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:          5    IO-APIC-edge  serial
  8:          2    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 14:      12240    IO-APIC-edge  ide0
 15:         11    IO-APIC-edge  ide1
 16:      31827   IO-APIC-level  nvidia
 17:       1461   IO-APIC-level  eth0
 18:          4   IO-APIC-level  bttv0
 19:      13213   IO-APIC-level  EMU10K1
 21:      11567   IO-APIC-level  uhci-hcd, uhci-hcd, uhci-hcd, ehci_hcd

And everything works just fine... (despite my broken BIOS ;-)

  Thomas
