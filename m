Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbTDNVNF (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTDNVNF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:13:05 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:57753 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263933AbTDNVNE (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:13:04 -0400
Message-ID: <3E9B2720.7020803@cox.net>
Date: Mon, 14 Apr 2003 14:24:48 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-hotplug-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
References: <20030414190032.GA4459@kroah.com> <200304142209.56506.oliver@neukum.org> <20030414203328.GA5191@kroah.com> <200304142311.01245.oliver@neukum.org>
In-Reply-To: <200304142311.01245.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:

>>>Now let's be conservative and assume 16KB unswappable memory
>>>per task. Now we take the famous 4000 disk case. 64MB. A lot
>>>but probably not deadly. But multiply this by 15 and the machine is
>>>absolutely dead.
>>
>>Ok, then the "Enterprise Edition" of the distros that expect to handle
>>4000 disks will have to add the following patch to their version of the
>>hotplug package.
>>
>>In the meantime, the other 99% of current Linux users will exist just
>>fine :)
> 
> 
> Well, for a little elegance you might introduce subdirectories for each type
> of hotplug event and use only them.
> 

Personally, this is one reason why I'd much rather see a daemon-based model 
where each interested daemon can "subscribe" to the messages it is interested 
in. It's very possible (and likely, i.e. udev) that the steps involved for the 
daemon to respond to the hotplug event are so lightweight that creating a 
subprocess to handle them would be very wasteful.

Also, this lends itself to multiple levels of messaging: say, for example, 
userspace partitioning. How would the proposed scheme manage to invoke the 
userspace partition reading _after_ udev has done its job? If udev itself 
generated a message into the queue after the device node had been created, the 
partitioning code could listen for that instead of the native hotplug event.

