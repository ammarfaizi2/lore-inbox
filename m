Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTKFPbH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTKFPbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:31:07 -0500
Received: from gate.corvil.net ([213.94.219.177]:12812 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S263650AbTKFPbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:31:03 -0500
Message-ID: <3FAA68E5.9070804@draigBrady.com>
Date: Thu, 06 Nov 2003 15:29:41 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gianni Tedesco <gianni@scaramanga.co.uk>
CC: Oliver Dain <omd1@cornell.edu>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PACKET_MMAP revisited
References: <176730-2200310329491330@M2W026.mail2web.com>	 <1068116914.6144.1410.camel@lemsip>  <200311060913.41719.omd1@cornell.edu> <1068129060.530.1438.camel@lemsip>
In-Reply-To: <1068129060.530.1438.camel@lemsip>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Tedesco wrote:
> On Thu, 2003-11-06 at 15:13, Oliver Dain wrote:
> 
>>It seems to me that it can't loop in user mode forever.  There is no way to 
>>get data into user mode (the ring buffer) witout going through the kernel.  
>>My understanding is that the NIC doesn't transfer directly to the user mode 
>>ring buffer, but rather to a different DMA buffer.  The kernel must copy it 
>>from the DMA buffer to the ring buffer. Thus once the user mode app has 
>>processed all the data in the ring buffer the kenel _must_ get involved to 
>>get more data to user space.  Currently the data gets there because the NIC 
>>produces an interrupt for each packet (or for every few packets) and when the 
>>kernel handles these the data is copied to user space.  Then, as you point 
>>out, the cost of the RETI can't be avoided.  
> 
> 
> yes, in interrupt context. My point is that that *task* will never go in
> to kernel mode, it will always be running in user mode.

In my experience (PIII 1.2GHz, i815, e100, NAPI), user mode
would read at most 7 packets at a time, even when artificial
busy loops insterted. The max packet rate acheived was
around 120Kpps, but that was limited at the driver level.
Most of the CPU was consumed while doing this (measured with
cyclesoak, especially required since NAPI was used).

Pádraig.

