Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTAVW5b>; Wed, 22 Jan 2003 17:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbTAVW5b>; Wed, 22 Jan 2003 17:57:31 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:14837 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S263977AbTAVW5a>; Wed, 22 Jan 2003 17:57:30 -0500
Message-ID: <3E2F2350.8050107@mvista.com>
Date: Wed, 22 Jan 2003 16:03:44 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Sanders <developer_linux@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux application level timers?
References: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
In-Reply-To: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try select().

Depending on your architecture (ie: if requests come in via TCP file 
descriptors) you can use select.  Select takes as an argument a timeout 
value.  You can calculate the minimum timeout value for a set of 
timeouts by finding the minimum, and use that as your select timeout. 
 Before each time you call select, you can figure out all the timeout 
values to find the minimum select period.  This way you can control what 
you do when with the timeout.  After the select, you can then calculate 
which timeouts have occured and act on them appropriately.

I use this for example to detect when a function should be polled while 
also waiting on event-driven i/o from a tcp socket.  I also use this to 
detect when a heartbeat message should have been received but was not in 
the alloted time, causing the socket to close and reconnect.

Thanks
-steve

Tom Sanders wrote:

>I'm writing an application server which receives
>requests from other applications. For each request
>received, I want to start a timer so that I can fail
>the application request if it could not be completed
>in max specified time.
>
>Which Linux timer facility can be used for this?
>
>I have checked out alarm() and signal() system calls,
>but these calls doesn't take an argument, so its not
>possible to associate application request with the
>matured alarm.
>
>Any inputs?
>
>Thanks in advance,
>Tom
>
>__________________________________________________
>Do you Yahoo!?
>Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
>http://mailplus.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

