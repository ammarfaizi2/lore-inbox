Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUCVVQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUCVVQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:16:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:16546 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263015AbUCVVQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:16:47 -0500
X-Authenticated: #20450766
Date: Mon, 22 Mar 2004 22:16:01 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Robert_Hentosh@Dell.com, <fleury@cs.auc.dk>,
       <linux-kernel@vger.kernel.org>
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.55.0403221000530.6539@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0403222105380.3493-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Maciej W. Rozycki wrote:

>  Do you really get "spurious 8259A interrupt" messages for the local APIC
> timer???  They don't ever leave the unit bound to the processor -- it has
> to be something else.  What is your contents of /proc/interrupts?

Ok, here's exactly, what I see:
1) during start-up 1 message
spurious 8259A interrupt: IRQ7.
2) at run-time ERR: count increases - sometimes several per
second, sometimes it remains constant for some time.
3) No more "spurious" messages
4) I saw definitely situations, when between 2 /proc/interrupts snapshots
the sum of all (except the timer) interrupts was smaller, than the number
of errors, e.g.

           CPU0 (2nd shot)
  0:      36557  37638 +1081 XT-PIC  timer
  1:         59     65    +6 XT-PIC  i8042
  2:          0      0       XT-PIC  cascade
  5:          0      0       XT-PIC  VIA686A
  8:          3      3       XT-PIC  rtc
  9:          0      0       XT-PIC  acpi, uhci_hcd, uhci_hcd
 10:          0      0       XT-PIC  eth0
 12:         84     84       XT-PIC  i8042
 14:       1910   1918    +8 XT-PIC  ide0
 15:          1      1       XT-PIC  ide1
NMI:         18     18
LOC:      36460  37541 +1081
ERR:         36     57   +21

ide0 + i8042 (keyboard) = 14, whereas errors increased by 21. So, if you
are right, than Alan's wrong (or my understanding of his statement), and
those spurious interrupts occur not only after real ones, or, one real
interrupt can produce several spurious ones.

Thanks
Guennadi
---
Guennadi Liakhovetski


