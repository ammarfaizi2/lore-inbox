Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUIJIqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUIJIqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUIJIqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:46:46 -0400
Received: from gizmo06bw.bigpond.com ([144.140.70.41]:42125 "HELO
	gizmo06bw.bigpond.com") by vger.kernel.org with SMTP
	id S267294AbUIJIqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:46:43 -0400
Message-ID: <414169F0.1040202@bigpond.net.au>
Date: Fri, 10 Sep 2004 18:46:40 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
References: <413FA9AE.90304@bigpond.net.au> <20040909010610.28ca50e1.akpm@osdl.org> <4140EE3E.5040602@bigpond.net.au> <20040909171450.6546ee7a.akpm@osdl.org> <4141092B.2090608@bigpond.net.au> <20040909200650.787001fc.akpm@osdl.org> <41413F64.40504@bigpond.net.au> <20040909231858.770ab381.akpm@osdl.org> <414149A0.1050006@bigpond.net.au> <20040909235217.5a170840.akpm@osdl.org> <41415B15.1050402@bigpond.net.au> <20040910005454.23bbf9fb.akpm@osdl.org> <4141621D.7020301@bigpond.net.au>
In-Reply-To: <4141621D.7020301@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Andrew Morton wrote:
> 
>>
>> Could you see if this patch fixes the above crash?
>>
>> --- 25/fs/isofs/rock.c~rock-kludge    2004-09-10 00:52:30.394468656 -0700
>> +++ 25-akpm/fs/isofs/rock.c    2004-09-10 00:53:14.544756792 -0700
>> @@ -62,7 +62,7 @@
>>  }                                      
>>  #define MAYBE_CONTINUE(LABEL,DEV) \
>> -  {if (buffer) kfree(buffer); \
>> +  {if (buffer) { kfree(buffer); buffer = NULL; } \
>>    if (cont_extent){ \
>>      int block, offset, offset1; \
>>      struct buffer_head * pbh; \
>> _
>>
>>
>> I sure hope it does, so I don't have to look at rock.c again.
> 
> 
> It does and no sign of the oops or scheduling while atomic messages.

I was mistaken about the schedule while atomic messages.  They showed up 
again when I did the "make install".

>  I 
> still have the original four patches applied.  I'll try again with an 
> unpatched bk16 and let you know the results shortly.
> 

With out of the box bk16 plus your rock.c patch and with 
CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC selected I get no oops in 
in_groupse_p() or kfree() but I still get the scheduling while atomic 
messages when I do "make install".

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

