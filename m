Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVB1AJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVB1AJB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVB1AHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:07:09 -0500
Received: from www.rapidforum.com ([80.237.244.2]:33945 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261212AbVB0Xn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:43:56 -0500
Message-ID: <42225B34.7020104@rapidforum.com>
Date: Mon, 28 Feb 2005 00:43:48 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
References: <4221FB13.6090908@rapidforum.com> <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com> <422239A8.1090503@rapidforum.com> <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No i am only using 4 tasks with Poll-API and non-blocking sockets. Every socket gets a 1 MB 
read-ahead. This are 4000 MB Max on a 8 GB machine.... Shouldnt thrash.

Rik van Riel wrote:
> On Sun, 27 Feb 2005, Christian Schmid wrote:
> 
> 
>>>Christian, how big are the data blocks you sys_readahead, and
>>>how many do you have outstanding at a time ?
>>
>>I am reading 800000 bytes of data as soon as there is less than 200000 
>>data in the cache. I do assume the cache doesnt kill itself. I have 8 GB 
>>machine with 7,5 GB free for caching.
> 
> 
> OK, so you read 800kB with 4000 threads, or 3.2GB of
> readahead data.  The inactive list is quite possibly
> smaller than that, at 1/3 of memory or around 2.6 GB.
> 
> It looks like the cache might be killing itself, through
> readahead thrashing.
> 
