Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTDSN11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 09:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbTDSN10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 09:27:26 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:52629 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S263389AbTDSN1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 09:27:25 -0400
Date: Sat, 19 Apr 2003 15:39:23 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4 & IRQ balancing
Message-Id: <20030419153923.6d63e22b.philippe.gramoulle@mmania.com>
In-Reply-To: <20030418175116.75c8aa7b.akpm@digeo.com>
References: <20030419015836.6acbaeb6.philippe.gramoulle@mmania.com>
	<20030418175116.75c8aa7b.akpm@digeo.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Fri, 18 Apr 2003 17:51:16 -0700
Andrew Morton <akpm@digeo.com> wrote:

  |  $ cat /proc/interrupts 
  | >            CPU0       CPU1       
  | >   0:   47851610          0    IO-APIC-edge  timer
  | >   1:      51789          0    IO-APIC-edge  i8042
  | >   2:          0          0          XT-PIC  cascade
  | >   3:        171          0    IO-APIC-edge  serial
  | >   8:     772066          0    IO-APIC-edge  rtc
  | >  12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
  | >  15:         58          1    IO-APIC-edge  ide1
  | >  16:      47047          0   IO-APIC-level  ohci1394
  | >  18:     391753          0   IO-APIC-level  EMU10K1
  | >  19:     911863          0   IO-APIC-level  uhci-hcd
  | >  20:     261806          0   IO-APIC-level  eth0
  | >  22:     273648          0   IO-APIC-level  aic7xxx
  | 
  | It is supposed to do that.

Ok.

  | 
  | You might as well beat the rush; boot with the `noirqbalance' option and
  | run http://people.redhat.com/arjanv/irqbalance/.  We want to pull the
  | irq balancer out of the kernel altogether.

Ok, i booted with noriqbalance, removed nmi_watchdog=1 and ran irqbalance 0.06.

Now after few minutes of activity :

# cat /proc/interrupts 

           CPU0       CPU1       
  0:      73897     577734    IO-APIC-edge  timer
  1:       3297         18    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:        177          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
 12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
 15:         10          1    IO-APIC-edge  ide1
 18:          0          0   IO-APIC-level  EMU10K1
 19:       8366          0   IO-APIC-level  uhci-hcd
 20:       1306          0   IO-APIC-level  eth0
 22:      30753        965   IO-APIC-level  aic7xxx
 23:          0          0   IO-APIC-level  uhci-hcd
NMI:          0          0 
LOC:     649138     649349 
ERR:          0
MIS:          0

and about 30 seconds later ( mail checking )

# cat /proc/interrupts 
           CPU0       CPU1       
  0:      73897     676905    IO-APIC-edge  timer
  1:       3571         18    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:        177          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
 12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
 15:         10          1    IO-APIC-edge  ide1
 18:          0          0   IO-APIC-level  EMU10K1
 19:      15866          0   IO-APIC-level  uhci-hcd
 20:       1377          0   IO-APIC-level  eth0
 22:      34408        965   IO-APIC-level  aic7xxx
 23:          0          0   IO-APIC-level  uhci-hcd
NMI:          0          0 
LOC:     748312     748523 
ERR:          0
MIS:          0

Is this what you are looking for ? and are the values changes meaningful ?

Thanks,

Philippe
