Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWCGQHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWCGQHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWCGQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:07:54 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59709 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751140AbWCGQHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:07:54 -0500
Message-ID: <440DAF7D.1050605@cfl.rr.com>
Date: Tue, 07 Mar 2006 11:06:21 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bcrl@kvack.org, drepper@gmail.com, da-x@monatomic.org,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
References: <440CE336.3080504@cfl.rr.com> <20060306.190428.23731173.davem@davemloft.net> <440D06E9.1020901@cfl.rr.com> <20060306.220237.07925602.davem@davemloft.net>
In-Reply-To: <20060306.220237.07925602.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2006 16:09:26.0641 (UTC) FILETIME=[81C80E10:01C64201]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14309.000
X-TM-AS-Result: No--9.990000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> The whole idea is to figure out what socket gets the packet
> without going through the IP and TCP stack at all, in the
> hardware interrupt handler, using a tiny classifier that's
> very fast and can be implemented in hardware.
> 

AFAIK, "going through the IP and TCP stack" just means passing a quick 
packet classifier to locate the corresponding socket.  It would be nice 
to be able to possibly offload that to the hardware, but you don't need 
to throw out the baby ( tcp/ip stack ) with the bathwater to get there.

Maybe some sort of interface could be constructed to allow the higher 
layers to pass down some sort of ASL type byte code classifier to the 
NIC driver, which could either call it via the kernel software ASL 
interpreter, or convert it to firmware code to load into the hardware.

> Please wrap your brain around the idea a little longer than
> the 15 or so minutes you have thus far... thanks.
> 

I've had my brain wrapped around these sort of networking problems for 
over 10 years now, so I think I have a fair handle on things.  Certainly 
enough to carry on a discussion about it.

>> Yes, we can and should have a 6 times speed up, but as I've explained 
>> above, NT has had that for 10 years without having to push TCP into user 
>> space.
> 
> That's complete BS.

Error, does not compute.

Your holier than thou attitude does not a healthy discussion make.  I 
explained the methods that have been in use on NT to achieve a 6 fold 
decrease in cpu utilization for bulk network IO, and how it can be 
applied to the Linux kernel without radical changes.  If you don't 
understand it, then ask sensible questions, not just cry "That's 
complete BS!"

We already have O_DIRECT aio for disk drives that can do zero copy, 
there's no reason not to apply that to the network stack as well.


