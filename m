Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTLLTiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTLLTiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:38:02 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:20733 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261868AbTLLTht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:37:49 -0500
Message-ID: <3FDA1AF7.8010604@pacbell.net>
Date: Fri, 12 Dec 2003 11:45:59 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312121404110.677-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312121404110.677-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Fri, 12 Dec 2003, David Brownell wrote:
>>I'd split step 4 into "4a" (device descriptors) and "4b"
>>(config descriptors) ... and then re-factor so 1..4a is
>>the same code as normal khubd enumeration.  ...
> 
> Sure.  Although depending how you do it, step 3 might be different (reuse 
> the old address vs. assign a new address).  Also the failure paths will be 
> different.  But that could all be handled with proper refactoring.

That logic has always been a bit strange -- picking out the
address _before_ it starts the reset/set_address/get_descriptor
code.  Here's where that strangeness actually helps ... :)


>>That would also reduce the length of time the address0_sem
>>is held,
> 
> 
> It would?  How so?

It would be dropped after the address is assigned (the bus
no longer has an "address zero") ... rather than waiting
until after the device was configured and all its interfaces
were probed.  I think that's the issue Oliver alluded to in
his followup to your comment.

- Dave


