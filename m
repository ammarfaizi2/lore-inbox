Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVCICg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVCICg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVCICg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:36:59 -0500
Received: from minimail.digi.com ([66.77.174.15]:47499 "EHLO minimail.digi.com")
	by vger.kernel.org with ESMTP id S261361AbVCICg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 21:36:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ patch 4/7] drivers/serial/jsm: new serial device driver
Date: Tue, 8 Mar 2005 20:36:57 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E0B3C89A2@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ patch 4/7] drivers/serial/jsm: new serial device driver
Thread-Index: AcUkO0Hxze3b4c6iRoOrVBB//TY/SQAFG/8A
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Wen Xiong" <wenxiong@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > If you were to open up the port with an "stty -a" to get the current

> > settings and signals, you would unintentionally raise RTS and DTR.
>
> Why not fix the driver to not change the current line settings if it
is
> not being opened for the first time?  That seems like a much simpler
way
> to solve this, and probably the saner way, as you don't want any user
to
> be able to mess up your modem...
>
> thanks,
> 
> greg k-h

Oh, when the port is already open, the driver correctly would not muck
with DTR/RTS.

I am talking about when the port is currently not open.

On first port open, DTR (and usually RTS) will always be raised.
The serial device would see this DTR raise, and under some
circumstances,
react to it...

We have customers that use *really* *really* old serial devices on
our products, (we are talking 110 baud and even 50 baud (!!!)),
where an unintentional raise of DTR/RTS will freak the device out.

At any rate, that's the reason I exported the values to sysfs in the
original "dgnc" (outside-the-kernel-sources) driver.

Thanks,
Scott
