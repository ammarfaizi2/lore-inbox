Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265770AbSKOEnC>; Thu, 14 Nov 2002 23:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSKOEnC>; Thu, 14 Nov 2002 23:43:02 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:7750 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265770AbSKOEnB>;
	Thu, 14 Nov 2002 23:43:01 -0500
Message-ID: <3DD47D0D.7080801@mvista.com>
Date: Thu, 14 Nov 2002 22:50:21 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework
References: <Pine.LNX.4.44.0211142311160.2750-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Thu, 14 Nov 2002, Corey Minyard wrote:
>
>  
>
>>I haven't received much feedback on getting this included into the 
>>kernel.  I think it's a good idea since the nmi handler was starting to 
>>get messy, especially when you add kdb, NMI watchdogs, etc.
>>    
>>
>
>What protects the handler list from traversal in NMI context whilst we 
>update the list?
>
>	Zwane
>  
>
RCU does.  Basically, the code pulls it from the list atomically wrt to 
the NMI handler, and uses RCU to schedule the actual free of the data to 
be done after all CPUs have gone to idle or returned from interrupts. 
 It's subtle, you have to think about it a little.  But it does work.

-Corey

