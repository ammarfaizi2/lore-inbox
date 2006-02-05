Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWBENDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWBENDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 08:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWBENDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 08:03:21 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:27521 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751756AbWBENDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 08:03:21 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E5F6B3.9080901@s5r6.in-berlin.de>
Date: Sun, 05 Feb 2006 13:59:31 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Johannes Berg <johannes@sipsolutions.net>, Andy Wingo <wingo@pobox.com>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 4/4] firewire: add mem1394
References: <1138919238.3621.12.camel@localhost>	 <1138920185.3621.24.camel@localhost>	 <1138966521.4914.42.camel@localhost.localdomain> <1138967225.3621.44.camel@localhost>
In-Reply-To: <1138967225.3621.44.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.484) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> On Fri, 2006-02-03 at 12:35 +0100, Andy Wingo wrote:
>>On Thu, 2006-02-02 at 23:43 +0100, Johannes Berg wrote:
>>
>>>+	spin_lock(&dev_list_lock);
>>
>>Stupid question: are you sure that something coming from an interrupt
>>handler won't try to grab this lock? For example from a cable unplug?
> 
> Yes, I'm pretty sure (but I hope some of the firewire experts will chime
> in) -- but if you unplug or anything the node only goes into 'limbo' and
> afaict if it is ever cleaned up then that comes from a thread context.

The lock will only be taken in non-atomic context. In particular, if a 
mem1394 device is to be removed after cable unplug, the code will be run 
by knodemgrd.

What is more recommendable for mutual exclusion in non-atomic context 
(here also with very low probality of lock contention, given the current 
implementation of ieee1394) --- a mutex or a spinlock?
-- 
Stefan Richter
-=====-=-==- --=- --=-=
http://arcgraph.de/sr/
