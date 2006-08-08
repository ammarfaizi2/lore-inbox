Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWHHHRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWHHHRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 03:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWHHHRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 03:17:06 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48506 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932509AbWHHHRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 03:17:05 -0400
Message-ID: <44D83A7D.80600@sw.ru>
Date: Tue, 08 Aug 2006 11:17:17 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management -	A	cpu
 controller
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <20060804153123.GB32412@in.ibm.com>  <44D36FB5.3050002@sw.ru>	 <1154716024.7228.32.camel@galaxy.corp.google.com>  <44D6E98C.9090208@sw.ru> <1154970846.31962.17.camel@galaxy.corp.google.com>
In-Reply-To: <1154970846.31962.17.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>Doesnt the ability to move tasks between groups dynamically affect
>>>>>(atleast) memory controller design (in giving up ownership etc)?
>>>>
>>>>we save object owner on the object. So if you change the container,
>>>>objects are still correctly charged to the creator and are uncharged
>>>>correctly on free.
>>>>
>>>
>>>
>>>Seems like the object owner should also change when the object moves
>>>from one container to another.
> 
> 
>>Consider a file which is opened in 2 processes. one of the processes
>>wants to move to another container then. How would you decide whether
>>to change the file owner or not?
>>
> 
> 
> If a process has sufficient rights to move a file to a new container
> then it should be okay to assign the file to the new container.  
there is no such notion as  "rights to move a file to a new container".
The same file can be opened in processes belonging to other containers.
And you have no any clue whether to have to change the owner or not.

> Though the point is, if a resource (like file) is getting migrated to a
> new container then all the attributes (like owner, #pages in memory
> etc.) attached to that resource (file) should also migrate to this new
> container.  Otherwise the semantics of where does the resource belong
> becomes very difficult.
The same for many other resources. It is a big mistake thinking that most resources
belong to the processes and the owner process can be easily determined.

> And if you really want a resource to not be able to migrate from one
> container then we could define IMMUTABLE flag to indicate that behavior.
I hope not that one used in ext[23]? :)

Kirill

