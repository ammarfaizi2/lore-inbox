Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUDSOkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUDSOkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:40:22 -0400
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:3051 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264225AbUDSOkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:40:17 -0400
Message-ID: <4083E4C8.4090202@samwel.tk>
Date: Mon, 19 Apr 2004 16:40:08 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: nl, en-us, en
MIME-Version: 1.0
To: John Que <qwejohn@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NIC inerrupt
References: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
In-Reply-To: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Que wrote:
> Hello,
> 
> I want to count the number of times I reach an NIC receive
> interrupt.
> 
> I added a global static variable of type int , and initialized
> it to 0 ; each time I am in the rx_interrupt of the card I incerement
> it by one;
> I got large , non sensible numbers after one or two seconds;
> 
> So  for debug I added printk each time I increment it in rx_interrupt.
> 
> What I see is that there are  unreasonable jumps in the number
> 
> for instance , it inceremnts sequntially from 1 to 80,then jums to 4500, 
> increments a little sequentially to 4580, and the jums again to
> 11000 ;
> 
> Is it got to do with it that this is in interrupt?
> Any idea what it can be ?

You're probably reading the kernel output from syslog. Syslog 
periodically reads out the printks from the kernel. With the amount of 
printks you're doing you are probably printing info for about 4500 
interrupts between every time syslog checks for new kernel output, while 
the kernel buffer that is used to store this information can only handle 
   enough data for 80 interrupts.

--Bart
