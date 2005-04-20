Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVDTO6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVDTO6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 10:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVDTO6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 10:58:36 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44480 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261627AbVDTO6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 10:58:30 -0400
Message-ID: <42666E10.80207@jp.fujitsu.com>
Date: Wed, 20 Apr 2005 23:58:24 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       hari@in.ibm.com
Subject: Re: [RFC][PATCH] nameing reserved pages [0/3]
References: <426644DA.70105@jp.fujitsu.com>	 <1114000447.6238.64.camel@laptopd505.fenrus.org>	 <426663E8.3080502@jp.fujitsu.com> <1114007431.6238.79.camel@laptopd505.fenrus.org>
In-Reply-To: <1114007431.6238.79.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2005-04-20 at 23:15 +0900, Kamezawa Hiroyuki wrote:
>  
>
>MCA's probably shouldn't set PG_reserved; I don't see why they should.
>They could just steal the page and "leak" it.
>  
>
Actually leaked pages cannot be hot-removed/replaced. So we have to 
trace which pages is removed by MCA.
I think Set PG_reserved and set page->private = Removed_by_MCA is a 
simple idea.

>>>/dev/memstate really looks like a bad idea to me as well... I rather
>>>have less than more /dev/*mem*
>>> 
>>>
>>>      
>>>
>>For showing page usage and its "location", I've thought of other 
>>interface, sysfs, procfs...
>>But I have no idea.
>>    
>>
>
>Why do you want this exported to userspace? There is absolutely no way
>you can get this exported race free without shutting the VM down, and
>without being race free this information has absolutely no meaning !!
>  
>
No meaning ? 
Before memory-hotremove, we can guessing whether memory is hot-removable 
or not.
As you say , this is not atomic and not fully responsible.

After failing memory-hotremove, detecting why hot-remove was failed is 
very important.
I think ,when memory hot-remove faild, memory area is isolated until it 
is pushed back by an operator.
We can get a real snapshot of specified memory area.

Regards,
-- Kame

