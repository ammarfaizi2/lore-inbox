Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVCYEJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVCYEJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVCYEJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:09:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8861 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261180AbVCYEJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:09:38 -0500
Message-ID: <42438EED.4020202@pobox.com>
Date: Thu, 24 Mar 2005 23:09:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Collins <matt@signalz.com>
CC: Bernard Blackham <bernard@blackham.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Promise SX8 performance issues and CARM_MAX_Q
References: <20050323175707.GA10481@blackham.com.au> <4241F8BA.6070108@pobox.com> <4241FAF9.1080702@signalz.com>
In-Reply-To: <4241FAF9.1080702@signalz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Collins wrote:
> Jeff Garzik wrote:
> 
>> Bernard Blackham wrote:
>>
>>> Hi,
>>>
>>> Playing with a recently acquired Promise SX8 card, we've found
>>> similar performance results to Matt's post to lkml a few months back
>>> at http://marc.theaimsgroup.com/?l=linux-kernel&m=110175890323356&w=2
>>>
>>> It appears that the driver is only submitting one command at a time
>>> per port, which is at least one cause of the slowdowns. By raising
>>> CARM_MAX_Q from 1 to 3 in drivers/block/sx8.c (it was 3 in an
>>> earlier pre-merge incarnation of carmel.c), we're getting very
>>> notable speed improvements, with no side effects just yet.
>>>
>>> Knowing very little about what this change has actually done, I've a
>>> few questions:
>>>  - Should this be considered dangerous?
>>>  - Why was it taken from 3 to 1?
>>>  - Is CARM_MAX_Q a number defined (or limited) by the hardware?
>>
>>
>>
>> In multi-port stress tests, we couldn't get SX8 to function reliably 
>> without locking up or corrupting data, with more than one outstanding 
>> command.
>>
>> Maybe a new firmware has solved this by now.
>>
>>     Jeff
>>
>>
>>
> Indeed there does seem to be new firmware out as of 2/23/05. I ran my 
> tests with the 9/10/04 firmware but I did not adjust the CARM_MAX_Q 
> value. Do either of you happen to know what firmware revisions you 
> tested under?
> 
> I've put the machine with the SX8 controller into production despite the 
> performance issues so I'm not going to be of any use for testing 
> revisions to the driver :(

The driver was developed on a pre-production board, so its entirely 
possible Promise fixed this issue.

The driver should be solid for _at least_ CARM_MAX_Q==31, presuming that 
the firmware doesn't choke.

Anybody willing to
(a) change CARM_MAX_Q
(b) use the latest firmware
(c) stress the card with fsx, badblocks, iozone, and other tools
     on -multiple ports- simultaneously.

?

	Jeff



