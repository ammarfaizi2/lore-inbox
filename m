Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVCICOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVCICOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVCICAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:00:17 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7033 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262301AbVCIBzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:55:33 -0500
Date: Tue, 08 Mar 2005 19:54:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: select(2), usbserial, tty's and disconnect
In-reply-to: <3FPL5-7pH-29@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <422E5766.3040104@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3FPL5-7pH-29@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Pommnitz wrote:
> Hello all,
> currently it seems that select keeps blocking when the USB device behind
> ttyUSBx gets unplugged. My understanding is, that select should return
> when the next call to one of the operations (read/write) will not block.
> This is certainly true for failing with ENODEV. So, is this an issue
> that will be fixed or should I poll (not the syscall) the device? Or is 
> there another way to monitor for a vanishing tty (it should not be USB 
> specific).

If you just do a blocking read() on the USB serial port, what happens 
when you pull the device? At one point (2.4.20 is the last I checked) 
nothing happened when you did this, the process would just sit there 
forever. There was discussion at one point about doing a tty_hangup() 
when the USB device was disconnected (this causes the read() to return 
with 0 bytes and future open attempts to fail), and a patch was put out 
to do this. I thought this had been merged, but I could be wrong.

I should think that if that works, then your select should be working as 
well..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


