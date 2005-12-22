Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVLVRzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVLVRzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVLVRzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:55:49 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:64642 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030239AbVLVRzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:55:48 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
Date: Thu, 22 Dec 2005 09:55:46 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <43A480C0.9080201@ru.mvista.com> <200512200011.57052.david-b@pacbell.net> <43A95713.6020405@ru.mvista.com>
In-Reply-To: <43A95713.6020405@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512220955.46916.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 December 2005 5:22 am, Vitaly Wool wrote:
> David Brownell wrote:
> 
> >>The list setting commands are pretty essential and will not add a lot to 
> >>the assembly code.
> >
> >I'm not totally averse to such changes, but you don't seem to be making
> >the best arguments.  Example:  they're clearly not "essential" because
> >transfer queues work today with the lists at the spi_message level.
> 
> One more reason for that that came out only recently: suppore we're 
> adding transfers to an already configured message (i. e. with some 
> transfers set up already). This 'chaning' may happen for some kinds of 
> devices.

What would those devices be?  Have you looked at how, say, 802.15.4
wireless stacks would need to work?  I'm thinking those will be
interesting for some embedded Linux folk.  There are probably at least
half a dozen such Zigbee-capable radio chips that hook up through SPI,
and they're not always hooked up to 8-bit CPUs!


By the way, I'd say the framework already chains transfers, and what
you're proposing is that drivers be able to do so more flexibly.


> And in case transfers is an array, we should either be apriory  
> aware of whether the chaining will take place or allocate an array large 
> enough to hold additional transfers. Neither of these look good to me, 
> and having a linked list of transfers will definitely solve this problem.

Well, that's the guts of the good example I was hoping you would share.
I'll be posting a refresh of this code soonish; maybe you can provide 
a complete patch, changing all the code over to use list-not-array?

My own reasons for liking the notion of spi_transfer list membership
are to enable such transfer shuffling within the controller drivers,
more than at the spi_device driver level.  If both layers will see some
benefits, then it's likely a good change.  ;)

- Dave
