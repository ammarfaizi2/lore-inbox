Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVDAGrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVDAGrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVDAGrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:47:17 -0500
Received: from general.keba.co.at ([193.154.24.243]:29517 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262456AbVDAGqw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:46:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, USB: High latency?
Date: Fri, 1 Apr 2005 08:46:47 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231D4@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, USB: High latency?
Thread-Index: AcU2EW97VAy0QFv5Qj+ltxq8VhurrgAc2gXg
From: "kus Kusche Klaus" <kus@keba.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The latencies are almost certainly caused by the USB host 
> controller 
> > > driver.  I'm planning improvements to uhci-hcd which should 
> > > help reduce 
> > > the latency, but it will still be on the large side.  And I 
> > > won't have 
> > > time to write the changes to the driver for several months.
> > 
> > Any numbers about the expected "large side"? 
> > We would need <30 microseconds irq latency,
> > and <<1 milliseconds rt application latency.
> 
> The biggest advantage would come from using a bottom-half 
> handler to do 
> most of the work.  Right now the uhci-hcd driver does 
> everything in its 
> interrupt handler.  This would certainly help IRQ latency; it 
> might not 
> affect application latency very much.

Sounds very reasonable, thanks. Also helps application latency,
because with the RT patches, I can tune the rt prio of softirq
execution (that's where bottom-half goes, doesn't it?) w.r.t. the
rt prio of the application threads.

However, if I understand things correctly, if you really need 
to disable all interrupts while doing the USB work, it will not
make any difference if IRQs are disabled while you are in the
USB IRQ handler, or if they are disabled for the same amount of 
work/time in the bottom-half code.

> I'll try adding a bottom half in my next series of patches.  
> Maybe it will 
> be ready in time to appear in the -mm kernels before 2.6.12-final is 
> released.

> We'll see what happens with the upcoming changes.  Maybe 
> you'll be able to 
> test them for me?

Basically, yes (as long as our company doesn't decide to stop the
linux experiments).

However, I depend on Ingo's RT patch, which is against the -rc series,
not against the -mm series. So I will probably not be able to apply
patches created against -mm.

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
