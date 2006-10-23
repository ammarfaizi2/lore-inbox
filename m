Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWJWJQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWJWJQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWJWJQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:16:03 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:26575 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751840AbWJWJQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:16:01 -0400
Message-ID: <453C877E.6090002@aitel.hist.no>
Date: Mon, 23 Oct 2006 11:12:30 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Christopher Monty Montgomery <xiphmont@gmail.com>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
References: <Pine.LNX.4.44L0.0610201133110.7060-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610201133110.7060-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
>>> You could try putting a printk() just before the BUG() to display the 
>>> values of ehci->reclaim and qh->qh_state.  Maybe also change the BUG() to 
>>>   
>>>       
>> ehci->reclaim=0
>> qh->qh_state=5
>>     
>
> 5 is QH_STATE_COMPLETING.  That explains why the BUG() fires.
>
> At this point it's beyond me.  Monty will have to take it from here.
>
>   
>> During boot I get lots of those "Hardware error, end-of-data detected"
>> messages, but I've never seen it crash during bootup.
>>     
>
> Those messages are from the card reader.  It doesn't seem to be working 
> right.  It returns the "end-of-data" error in response to a PREVENT MEDIUM 
> REMOVAL command
Unlike a cdrom, it doesn't have the means to prevent media removal. :-)
>  and it returns a phase error in response to a READ 
> command.  In spite of the fact that it claims to have a 256 MB card 
> present.
>   
It has slots for several different cards, all the other
slots are empty. 

Perhaps it is broken, but interesting as a "stress-test".
Linux should not crash because of a bad usb thing, just complain.

Helge Hafting

