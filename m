Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVDAGdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVDAGdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVDAGdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:33:25 -0500
Received: from general.keba.co.at ([193.154.24.243]:33100 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262017AbVDAGdT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:33:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory stick
Date: Fri, 1 Apr 2005 08:33:17 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231D3@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory stick
Thread-Index: AcU2FGVM/7a7npvbShytYmk1zWdh/gAbgjiw
From: "kus Kusche Klaus" <kus@keba.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Latency is the subject of a separate email.  Does this 
> > > increase in latency 
> > > occur only when you see the errors, or whenever you do a 
> large data 
> > > transfer?  In fact, I would suspect the errors to _decrease_ 
> > > the latency 
> > > with respect to a normal transfer.
> > 
> > I observe from <1 to 2 ms on successful transfers, and around 15 ms
> > latency when things go wrong.
> 
> I hate to ask this question; it sounds an awful lot like 
> "Monty Python and
> the Holy Grail", but...  Is that IRQ latency or application latency?

With Ingo's RT kernels, it is not possible for me to tell the 
difference, because IRQ handlers are also running as kernel threads,
scheduled by the scheduler according to their rt prio
(which is around 50 by default, 95 for the RTC IRQ in my case).

I can tell for sure that the RTC IRQ handler was not executed
in that time, but I can't tell if that's because IRQs were blocked
or because it didn't get scheduled.

> I can't think of any reason why IRQ latency should change 
> during the error 
> handling.  Application latency might change because the SCSI 
> error handler 
> could start using up a lot of CPU time.  I don't know what 
> priority it 
> runs at; you can check with ps.

Ingo just suggested that error handling (writing kernel messages
to console/disk) in general is causing the trouble. 
I'll check that and post the results.

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
