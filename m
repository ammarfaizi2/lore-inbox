Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUABJcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 04:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUABJcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 04:32:18 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:38793 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265463AbUABJcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 04:32:16 -0500
Message-ID: <3FF53A9E.7040905@colorfullife.com>
Date: Fri, 02 Jan 2004 10:32:14 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc/patch] wake_up_info() draft ...
References: <Pine.LNX.4.44.0401011921250.1458-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0401011921250.1458-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>On Fri, 2 Jan 2004, Manfred Spraul wrote:
>
>  
>
>>Hi Davide,
>>    
>>
>
>Hi Manfred,
>
>
>  
>
>>I think the patch adds unnecessary bloat, and mandates one particular 
>>use of the wait queue info interface.
>>    
>>
>
>why are you saying so?
>
>  
>
sizeof(waitqueue_t) increases.

>@@ -1658,6 +1659,8 @@
> 		unsigned flags;
> 		curr = list_entry(tmp, wait_queue_t, task_list);
> 		flags = curr->flags;
>+		if (info)
>+			dup_wait_info(&curr->info, info);
> 		if (curr->func(curr, mode, sync) &&
> 		    (flags & WQ_FLAG_EXCLUSIVE) &&
> 		    !--nr_exclusive)
>
IMHO these two lines belong into curr->func, perhaps with a reference 
implementation that uses

struct wait_queue_entry_info {
    wait_queue_t wait;
    struct wait_info info;
};

We have already a callback pointer, so why add special case code into 
the common codepaths? Custom callbacks could handle the special case of 
an info wakeup.

--
    Manfred

