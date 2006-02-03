Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWBCUew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWBCUew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWBCUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:34:52 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:30911 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751414AbWBCUev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:34:51 -0500
Message-ID: <43E3BE66.6050200@watson.ibm.com>
Date: Fri, 03 Feb 2006 15:34:46 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clg@fr.ibm.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <20060203201945.GA18224@kroah.com>
In-Reply-To: <20060203201945.GA18224@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Feb 03, 2006 at 10:34:01AM -0800, Dave Hansen wrote:
> 
>>Lastly, is this a place for krefs?  I don't see a real need for a
>>destructor yet, but the idea is fresh in my mind.
> 
> 
> Well, what happens when you drop the last reference to this container?
> Right now, your patch doesn't cause anything to happen, and if that's
> acceptable, then fine, you don't need to use a struct kref.
> 
> But if not, then why have a reference count at all?  :)
> 
> thanks,
> 
> greg k-h
> 

Greg ...

In our pid virtualization patches we removed the object automatically.
I presume that Kirill does the same .... although the code for that is not released.

I am working on converting our pid stuff so to follow the recommendation of Linux/Alan
to just do <container,pid> isolation through pidspaces.

I could release an allocation/ before hand. Based on Kirill's 1/5 patch adoption
(which took Linus's & Dave's naming comments into account)

How do we want to create the container?
In our patch we did it through a /proc/container filesystem.
Which created the container object and then on fork/exec switched over.

How about an additional sys_exec_container( exec_args + "container_name").
This does all the work like exec, but creates new container
with name "..." and attaches task to new container.
If name exists, an error -EEXIST will be raised !

-- Hubertus

