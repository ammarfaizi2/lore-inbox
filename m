Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVCBAex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVCBAex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 19:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVCBAex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 19:34:53 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:33927 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262135AbVCBAev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 19:34:51 -0500
Message-ID: <42250A25.1030807@yahoo.com.au>
Date: Wed, 02 Mar 2005 11:34:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Corey Minyard <minyard@acm.org>
CC: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       Sergey Vlasov <vsu@altlinux.ru>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New operation for kref to help avoid locks
References: <42209BFD.8020908@acm.org>	 <20050226232026.5c12d5b0.vsu@altlinux.ru> <4220F6C8.4020002@acm.org>	 <20050301201528.GA23484@kroah.com>	 <1109710964.6293.166.camel@laptopd505.fenrus.org>	 <4224E499.5060800@acm.org> <1109715256.6293.180.camel@laptopd505.fenrus.org> <4224FC33.6040405@acm.org> <42250299.8080709@yahoo.com.au> <422508A6.9070605@acm.org>
In-Reply-To: <422508A6.9070605@acm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard wrote:
> Nick Piggin wrote:

>> Is get_with_check actually going to be useful for anything? It
>> seems like it promotes complex and potentially unsafe schemes.
> 
> 
> It is certainly more complex to use this, and I'm guessing that's why 
> Greg rejected it.  Certainly a valid problem.
> 
>>
>> eg. In your queue example, it would usually be better to have
>> a refcount for being on queue, and entry_completed would remove
>> the entry from the queue and accordingly drop the refcount. The
>> release function would then just free it.
> 
> 
> True.  But if things picked up entries of the queue and incremented 
> their refcount, then you would need a lock.  The same technique would 
> apply.  But your example would be the more common one, I would think.
> 

Well, but you take a lock in your system too, to protect the
queue (ie. in get_working_entry()).

Nick

