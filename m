Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUDNUXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUDNUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:22:55 -0400
Received: from [63.107.13.101] ([63.107.13.101]:31152 "EHLO mail.metavize.com")
	by vger.kernel.org with ESMTP id S261611AbUDNUVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:21:23 -0400
Message-ID: <407D9D2F.3010901@metavize.com>
Date: Wed, 14 Apr 2004 13:21:03 -0700
From: Dirk Morris <dmorris@metavize.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Davide Libenzi <davidel@xmailserver.org>, Ben Mansell <ben@zeus.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
References: <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com> <407D7BFF.4010700@metavize.com> <20040414193947.GE12105@mail.shareable.org>
In-Reply-To: <20040414193947.GE12105@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>Dirk Morris wrote:
>  
>
>>I need them to be handled like normal events. (I can explain more off 
>>list if you'd like)
>>    
>>
>
>Did you read my explanation of how to do this using the present epoll
>behaviour using _fewer_ syscalls than you are asking for?
>  
>
Ah yes, I just went back and read it.
 From what I understand you're proposing to remove the fd from the set 
lazily instead of immediately.
Which will save system calls in the cases were the HUP/ERR condition 
does not occur during the 'disabled' time.

In my case, which you may choose to disregard, this condition is not 
irregular or in any way a special case.
So the revision you have proposed is just an optimization.
You could even use this same optimization with the disable feature 
(disable it lazily) and get even better performance with the same number 
of syscalls you proposed.

I see no downside, except that it no longer conforms to the semantics of 
poll and select.
Whether or not its worth it to deviate from this behavior over such a 
detail, I don't know. :)



