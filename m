Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVCHVse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVCHVse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVCHVsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:48:31 -0500
Received: from minimail.digi.com ([66.77.174.15]:10989 "EHLO minimail.digi.com")
	by vger.kernel.org with ESMTP id S261612AbVCHVro convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:47:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Date: Tue, 8 Mar 2005 15:47:45 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E2@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Thread-Index: AcUkKHZSofSm422oRGCs/9OWhkeovg==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>, "Wen Xiong" <wenxiong@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Who needs to know if a port is open or not?
>
<snipped some code> 
>
> +static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char
*buf)

> No, please delete these, and the other sysfs files that duplicate the
> same info that you can get by using the standard Linux termios calls.
> There is no need for them here.
> 
> thanks,
> greg k-h

Hi Greg, Wendy, all,

Our serial port monitoring tools need to know these things, and to
find them out *without* opening up the serial port to do an ioctl().

For example, lets say a customer has a modem connected to a serial port.

If you were to open up the port with an "stty -a" to get the current 
settings and signals, you would unintentionally raise RTS and DTR.

Now the modem sees DTR raised, and might react to it by mistake.

Usually raising and dropping RTS/DTR quickly on a modem won't hurt
anything,
but its not particularly a "good" when the modem is not expecting it.

This is why we export the various signals/stats/signals to sysfs (used
to be proc),
so our management tools can get the information about the serial port
without being
intrusive by opening up the port.

Scott
