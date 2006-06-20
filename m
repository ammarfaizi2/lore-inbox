Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWFTAkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWFTAkA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWFTAkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:40:00 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:27496 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965011AbWFTAj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:39:59 -0400
Message-ID: <44974430.8050807@oracle.com>
Date: Mon, 19 Jun 2006 17:41:20 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bongani Hlope <bhlope@mweb.co.za>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
References: <44909A32.3010304@oracle.com>	<200606150738.18724.bhlope@mweb.co.za> <20060619174006.647e02c7.akpm@osdl.org>
In-Reply-To: <20060619174006.647e02c7.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Bongani Hlope <bhlope@mweb.co.za> wrote:
>>> @@ -342,7 +341,10 @@ static int acpi_ec_poll_read(union acpi_
>>>  			return_VALUE(-ENODEV);
>>>  	}
>>>
>>> -	spin_lock_irqsave(&ec->poll.lock, flags);
>>> +	if (down_interruptible(&ec->polling.sem)) {
>>                                                      ^^^^
>> isn't this suppose to be: &ec->poll.sem
> 
> Good question.   Did it get resolved?

I posted a corrected patch that does that.
No responses from the ACPI people.

~Randy

