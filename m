Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUDWVXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUDWVXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUDWVXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:23:03 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:29960 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261405AbUDWVW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:22:59 -0400
Message-ID: <408989E3.5010009@techsource.com>
Date: Fri, 23 Apr 2004 17:25:55 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: root@chaos.analogic.com, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898730.50009@candelatech.com>
In-Reply-To: <40898730.50009@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ben Greear wrote:
> Richard B. Johnson wrote:
> 
>> Actually not. You need a FIFO to cache your bits into buffers of bytes
>> anyway. Depending upon the length of the FIFO, you can "rubber-band" a
>> lot of rotational latency. When you are dealing with a lot of drives,
>> you are never going to have all the write currents turn on at the same
>> time anyway because they are (very) soft-sectored, i.e., block
>> replacement, etc.
> 
> 
> Wouldn't this pretty much guarantee worst-case latency scenario for 
> reading, since
> on average at least one of your 32 disks is going to require a full 
> rotation
> (and probably a seek) to find it's bit?


Only for the first bit of a block.  For large streams of reads, the 
fifos will keep things going, except for occasionally as drives drift in 
their relative rotation positions which can cause some delays.


