Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFSX4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTFSX4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:56:13 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:8435 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262030AbTFSX4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:56:08 -0400
Message-ID: <3EF250EF.1010802@mvista.com>
Date: Thu, 19 Jun 2003 17:10:23 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <Pine.LNX.4.44.0306191700010.1987-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0306191700010.1987-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>On Thu, 19 Jun 2003, Steven Dake wrote:
>  
>
>>A serialization methodology can be built on /sbin/hotplug, but it has 
>>all of the problems that Linus previously talked about for a kernel 
>>event queue.  The difference is that the problem is moved to userland.
>>    
>>
>
>Having event ordering is a trivial matter, and I'm not against adding a
>sequence number to /sbin/hotplug as part of the environment, for example. 
>
>What I worry about is the situation where one big deamon handles 
>everything, which makes it impossible to "hook in" to the thing without 
>understanding the one big thing.
>
>The thing that makes /sbin/hotplug so wonderful is that it's stateless,
>and if you want to hook into it, it's absolutely _trivial_.  Look at the 
>default script there in redhat-9 for example, and it's obvious how to hook 
>up to certain events etc.
>
>And why do people care about serialization anyway? Really? The whole 
>notion is ludicrous. /sbin/hotplug _shouldn't_ be serialized. 
>Serialization is bad. You should look at whatever problems you have with 
>it now, and ask yourself whether maybe it should be done some other way 
>entirely.
>  
>
Serialization is important for the case of a device state change 
occuring rapidly.  An example is a device add and then remove, which 
results in (if out of order) the add occuring after the remove, leaving 
a dead device node in the filesystem.  This is tolerable.  What isn't as 
tolerable is a remove and then an add, where the add occurs out of order 
first.  In this case, a device node should exist on the filesystem, but 
instead doesn't because the remove has come along and removed it.

This occurance does happen much more often then you might think.  When 
changing disk partitions, for example, items are removed and then added 
several times before the devices are finally instantiated.

Definately to be avoided.

Thanks
-steve

>		Linus
>
>
>
>  
>

