Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTDOS0F (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTDOS0E 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:26:04 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:2250 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262964AbTDOSZm (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:25:42 -0400
Date: Tue, 15 Apr 2003 14:33:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Message-ID: <200304151436_MC3-1-3487-215F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:


> OK right. As far as I can see, the algorithm in the RAID1 code
> is used to select the best drive to read from? If that is the
> case then I don't think it could make better decisions given
> more knowledge.


  How about if it just asks the elevator whether or not a given read
is a good fit with its current workload?  I saw in 2.5 where the balance
code is looking at the number of pending requests and if it's zero then
it sends it to that device.  Somehow I think something better than
that could be done, anyway.


> It seems to me that a better way to layer it would be to have
> the complex (ie deadline/AS/CFQ/etc) scheduler handling all
> requests into the raid block device, then having a raid
> scheduler distributing to the disks, and having the disks
> run no scheduler (fifo).


 That only works if RAID1 is working at the physical disk level (which
it should be AFAIC but people want flexibility to mirror partitions.)


> In practice the current scheme probably works OK, though I
> wouldn't know due to lack of resources here :P


 I've been playing with the 2.4 read balance code and have some
improvements, but real gains need a new approach.

(cc'd to linux-raid)

--
 Chuck
