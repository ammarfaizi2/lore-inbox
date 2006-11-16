Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424367AbWKPTB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424367AbWKPTB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424364AbWKPTB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:01:57 -0500
Received: from mailer2.psc.edu ([128.182.66.106]:30686 "EHLO mailer2.psc.edu")
	by vger.kernel.org with ESMTP id S1424363AbWKPTB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:01:56 -0500
Message-ID: <455CB59F.4030908@psc.edu>
Date: Thu, 16 Nov 2006 14:01:51 -0500
From: John Heffner <jheffner@psc.edu>
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
MIME-Version: 1.0
To: eli@dev.mellanox.co.il
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: UDP packets loss
References: <60157.89.139.64.58.1163542548.squirrel@dev.mellanox.co.il> <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
In-Reply-To: <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eli@dev.mellanox.co.il wrote:
>> Hi,
>> I am running a client/server test app over IPOIB in which the client sends
>> a certain amount of data to the server. When the transmittion ends, the
>> server prints the bandwidth and how much data it received. I can see that
>> the server reports it received about 60% that the client sent. However,
>> when I look at the server's interface counters before and after the
>> transmittion, I see that it actually received all the data that the client
>> sent. This leads me to suspect that the networking layer somehow dropped
>> some of the data. One thing to not - the CPU is 100% busy at the receiver.
>> Could this be the reason (the machine I am using is 2 dual cores - 4
>> CPUs).
> 
> I still have the following argumet: the network and the network driver are
> capable of transffering data at a high rate and the networking stack is
> unable to keep the pace. If I used TCP probably TCP's flow control would
> eventually slow the whole thing to a rate such all parts can handle. But
> is there a way to overcome this situation and to avoid packets drop? If
> this would happen then TCP would work at higher rates as well?? Perhaps
> increase buffers sizes? Maybe the kernel is not designed to handle packets
> rate like IPOIB can generate?

Increasing buffer sizes is not likely to help your problem.  If the 
receiving machine just can't keep up, you need flow control to avoid 
loss.  There clearly is an upper bound on the packet rate any given 
receiver can handle, and you are hitting it.

BTW, TCP will be significantly faster than UDP because with UDP you 
incur an extra full context switch on every packet.

   -John
