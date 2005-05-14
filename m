Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVENVsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVENVsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVENVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:48:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261512AbVENVsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:48:07 -0400
Message-ID: <4286720E.9000201@pobox.com>
Date: Sat, 14 May 2005 17:47:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin LaHaise <bcrl@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc/patch] libata -- port configurable delays
References: <20050513185850.GA5777@kvack.org>	 <1116019231.26693.499.camel@localhost.localdomain>	 <42853687.1050402@pobox.com> <1116105095.20545.55.camel@localhost.localdomain>
In-Reply-To: <1116105095.20545.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2005-05-14 at 00:21, Jeff Garzik wrote:
> 
>>>If your chipset implements the 400nS lockout in hardware it certainly
>>>seems to make sense. Nice to know someone has put it in hardware
>>
>>No, it's just mostly irrelevant under SATA.
> 
> 
> libata is for PATA devices too.

Yes, but Ben has SATA, which is the hardware in question.

The 400nS delay which interests you so much in this thread isn't the 
interesting delay.  The 400nS delay isn't going away.  The 
udelay(10)-in-a-loop is what slows things down, and shows up on Ben's 
profiles.

The best solution is to convert PIO from polling to interrupt driven, so 
that we're not beating up the bus (big reason for the udelay).


>>The ATA registers are transmitted to the device in a single packet, 
>>called a FIS, when the Command or Device Control register is written.
>>
>>When the device updates its status, or completes a command, it sends a 
>>FIS from device to controller, instructing the controller to update its 
>>cached copy of the Status register.
> 
> 
> The controller in ATA style behaviour isn't required to have the status
> register valid at the point the FIS is written. It probably does but it
> isn't required.

After a tiny period of time, it's required to have set the BSY bit.

	Jeff


