Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbTFRX6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265637AbTFRX6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:58:53 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:21752 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S265635AbTFRX6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:58:51 -0400
Message-ID: <3EF10002.7020308@cox.net>
Date: Wed, 18 Jun 2003 17:12:50 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030603
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Oliver Neukum <oliver@neukum.org>, Robert Love <rml@tech9.net>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <3EE8D038.7090600@mvista.com> <1055459762.662.336.camel@localhost> <20030612232523.GA1917@kroah.com> <200306132201.47346.oliver@neukum.org> <20030618225913.GB2413@kroah.com>
In-Reply-To: <20030618225913.GB2413@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>>If this kmalloc fails, you'll have a hole in the numbers and
>>user space will be very confused. You need to report dropped
>>events if you do this.
> 
> 
> Yes, we should add the sequence number last.
> 

While this is not a bad idea, I don't think you want to make a promise 
to userspace that there will never be gaps in the sequence numbers. When 
this sequence number was proposed, in my mind it seemed perfect because 
then userspace could _order_ multiple events for the same device to 
ensure they got processed in the correct order. I don't know that any 
hotplug userspace implementation is going to be large and complex enough 
to warrant "holding" events until lower-numbered events have been 
delivered. That just seems like a very difficult task with little 
potential gain, but I could very well be mistaken :-)

