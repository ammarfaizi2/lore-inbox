Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVCAVyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVCAVyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCAVyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:54:38 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:25744 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262073AbVCAVyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:54:35 -0500
Message-ID: <4224E499.5060800@acm.org>
Date: Tue, 01 Mar 2005 15:54:33 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, Sergey Vlasov <vsu@altlinux.ru>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New operation for kref to help avoid locks
References: <42209BFD.8020908@acm.org>	 <20050226232026.5c12d5b0.vsu@altlinux.ru> <4220F6C8.4020002@acm.org>	 <20050301201528.GA23484@kroah.com> <1109710964.6293.166.camel@laptopd505.fenrus.org>
In-Reply-To: <1109710964.6293.166.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Tue, 2005-03-01 at 12:15 -0800, Greg KH wrote:
>  
>
>>On Sat, Feb 26, 2005 at 04:23:04PM -0600, Corey Minyard wrote:
>>    
>>
>>>Add a routine to kref that allows the kref_put() routine to be
>>>unserialized even when the get routine attempts to kref_get()
>>>an object without first holding a valid reference to it.  This is
>>>useful in situations where this happens multiple times without
>>>freeing the object, as it will avoid having to do a lock/semaphore
>>>except on the final kref_put().
>>>
>>>This also adds some kref documentation to the Documentation
>>>directory.
>>>      
>>>
>>I like the first part of the documentation, that's nice.
>>
>>But I don't like the new kref_get_with_check() function that you
>>implemented.  If you look in the -mm tree, kref_put() now returns if
>>this was the last put on the reference count or not, to help with lists
>>of objects with a kref in it.
>>
>>Perhaps you can use that to implement what you need instead?
>>    
>>
Yes, that helps a lot.  I had actually already implemented something 
like that :).  But that's a different thing than avoiding the lock.

It's just that with the I2C stuff, you may be calling kref_put() 20-30 
times for a single operation.  That's a lot of lock/unlock operations.  
But it is wierd, so I understand.  Thanks.

>
>note that I'm not convinced the "lockless" implementation actually is
>faster. It still uses an atomic variable, which is just as expensive as
>taking a lock normally...
>  
>
Just doing an atomic operation is not faster than doing a lock, an 
atomic operation, then an unlock?  Am I missing something?

-Corey
