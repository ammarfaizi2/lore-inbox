Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbTDVJy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbTDVJy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:54:29 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:51560 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S263037AbTDVJy1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:54:27 -0400
Date: Tue, 22 Apr 2003 12:06:30 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4 & IRQ balancing
Message-Id: <20030422120630.4048a8b1.philippe.gramoulle@mmania.com>
In-Reply-To: <20030419133837.0118907b.akpm@digeo.com>
References: <20030419015836.6acbaeb6.philippe.gramoulle@mmania.com>
	<20030418175116.75c8aa7b.akpm@digeo.com>
	<20030419153923.6d63e22b.philippe.gramoulle@mmania.com>
	<20030419133837.0118907b.akpm@digeo.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Sat, 19 Apr 2003 13:38:37 -0700
Andrew Morton <akpm@digeo.com> wrote:

  | Philippe Gramoullé <philippe.gramoulle@mmania.com> wrote:
  | >
  | > [ SMP IRQ distribution ]
  | >
  | > Is this what you are looking for ? and are the values changes meaningful ?
  | 
  | Looks good to me.  But it didn't affect your machine at all, did it?

Well, no, i didn't really felt a clear change.
  | 
  | This stuff only counts when the machine is doing a lot of work.  The current
  | IRQ balancer works well under high interrupt frequencies, but does quite the
  | wrong thing if you're doing a lot of softirq work at low interrupt
  | frequencies (gige routing with NAPI).

This box is used as a desktop box, so quite a lots of open applications, but no
real high load/IO except few kernel compiles and BK consistency checks.

Thanks,

Philippe


Booted with "noirqbalance" & started irqbalance:

$ cat /proc/interrupts
           CPU0       CPU1       
  0:      73897  247288143    IO-APIC-edge  timer
  1:      38421         56    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:        177          0    IO-APIC-edge  serial
  8:     107607          0    IO-APIC-edge  rtc
 12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
 15:         32        118    IO-APIC-edge  ide1
 18:      12602       1159   IO-APIC-level  EMU10K1
 19:     454172      15987   IO-APIC-level  uhci-hcd
 20:     494005          0   IO-APIC-level  eth0
 22:     717483      38681   IO-APIC-level  aic7xxx
 23:          0          0   IO-APIC-level  uhci-hcd
NMI:          0          0 
LOC:  247366287  247364170 
ERR:          0
MIS:          0

