Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVDAJI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVDAJI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVDAJI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:08:58 -0500
Received: from general.keba.co.at ([193.154.24.243]:35923 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262652AbVDAJIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:08:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Fri, 1 Apr 2005 11:07:54 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231D8@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Thread-Index: AcU2BZvvgd/4rBgGTNqQgCCbxR4G+wAk5B/w
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, "kus Kusche Klaus" <kus@keba.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The following tests are made with 'IRQ 8' at 95, rtc_wakeup 
> at 89(99):
> > * Heavy mmap load, no oom: max jitter:     42.1% (   51 usec)
> > * Heavy mmap load, oom:    max jitter:  11989.2% (14635 usec)
> >   (but still "missed irqs: 0", so IRQ 8 was also blocked for 14 ms)
> 
> did you get any kernel messages in that time? (about missed 
> irqs, etc.)  
> Please do a 'dmesg -n 0' to minimize the effect of kernel messages.

Excellent, thanks!

It turned out that the latencies are not caused by the kernel
messages themselves, but by sending them to a serial console
(which was off), in all my high latency cases at rtpri 89(99).

After removing the serial console from the boot parameters,
* the OOM timings are back to normal (around 50 microseconds)
* the USB error and remove timings are back to normal
* the USB plugin timings are in the range of the USB read
  (which is up to 1 ms - still bad)

However, latencies at rtprio 2 are still very frustrating
(details will follow).

-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-8919
E-Mail: kus@keba.com
www.keba.com
