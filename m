Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966428AbWKNWyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966428AbWKNWyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966431AbWKNWyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:54:38 -0500
Received: from smtp07.dc2.safesecureweb.com ([65.36.255.231]:7145 "EHLO
	smtp07.dc2.safesecureweb.com") by vger.kernel.org with ESMTP
	id S966428AbWKNWyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:54:37 -0500
Message-ID: <026801c7083f$cc80e670$0732700a@djlaptop>
From: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
To: <eli@dev.mellanox.co.il>, <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>
References: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il>
Subject: Re: UDP packets loss
Date: Tue, 14 Nov 2006 17:54:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: <eli@dev.mellanox.co.il>
To: <linux-kernel@vger.kernel.org>; <linux-net@vger.kernel.org>
Sent: Tuesday, November 14, 2006 5:15 PM
Subject: UDP packets loss


> Hi,
> I am running a client/server test app over IPOIB in which the client sends
> a certain amount of data to the server. When the transmittion ends, the
> server prints the bandwidth and how much data it received. I can see that
> the server reports it received about 60% that the client sent. However,
> when I look at the server's interface counters before and after the
> transmittion, I see that it actually received all the data that the client
> sent. This leads me to suspect that the networking layer somehow dropped
> some of the data. One thing to not - the CPU is 100% busy at the receiver.
> Could this be the reason (the machine I am using is 2 dual cores - 4
> CPUs).
>
> The secod question is how do I make the interrupts be srviced by all CPUs?
> I tried through the procfs as described by IRQ-affinity.txt but I can set
> the mask to 0F bu then I read back and see it is indeed 0f but after a few
> seconds I see it back to 02 (which means only CPU1).
>
> One more thing - the device I am using is capable of generating MSIX
> interrupts.
>
> Thanks from advance
> Eli
>
> -

Yes. The packet counters tell that the data was received by the interface. 
However, the interface may be faster than the application that ultimately 
receives the data so that the kernel eventually runs out of buffers used to 
store the temporary data. When this happens, the kernel just drops them. 
Since UDP is not "reliable", it can't ask the sender to send them again when 
it has resources available. If you need all the data, use a TCP/IP stream 
protocol, in other words, a connection. That way, you will get all the data, 
even if you are writing it to a slow disk.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 (somewhere). IT removed email  for 
engineers!
New Book: http://www.AbominableFirebug.com


