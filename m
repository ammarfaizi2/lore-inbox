Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422982AbWAMVoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422982AbWAMVoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWAMVoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:44:12 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:30457 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1422982AbWAMVoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:44:11 -0500
Message-ID: <43C81F2B.3020802@namesys.com>
Date: Fri, 13 Jan 2006 13:44:11 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: use __GFP_NOFAIL instead of yield and retry
 loop for allocation
References: <Pine.LNX.4.58.0601130932090.17696@sbz-30.cs.Helsinki.FI>	<20060112234238.01979912.akpm@osdl.org>	<Pine.LNX.4.58.0601130944360.20349@sbz-30.cs.Helsinki.FI> <20060112235548.0e1e4343.akpm@osdl.org>
In-Reply-To: <20060112235548.0e1e4343.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you guys think you could write some nice long comments on these flags
regarding what they mean and the policies for using them?

I gotta tell you, lots of people end up just guessing as best as they can.

Hans

Andrew Morton wrote:

>Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>  
>
>>Hi,
>>
>>Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>>    
>>
>>>> -      retry:
>>>> -	jl = kzalloc(sizeof(struct reiserfs_journal_list), GFP_NOFS);
>>>> -	if (!jl) {
>>>> -		yield();
>>>> -		goto retry;
>>>> -	}
>>>> +	jl = kzalloc(sizeof(struct reiserfs_journal_list),
>>>> +		     GFP_NOFS | __GFP_NOFAIL);
>>>>        
>>>>
>>On Thu, 12 Jan 2006, Andrew Morton wrote:
>>    
>>
>>>yup, that's what __GFP_NOFAIL is for: to consolidate and identify all those
>>>places which want to lock up when we're short of memory...  They all need
>>>fixing, really.
>>>      
>>>
>>Out of curiosity, are there any potential problems with combining GFP_NOFS 
>>and __GFP_NOFAIL? Can we really guarantee to give out memory if we're not 
>>allowed to page out?
>>
>>    
>>
>
>GFP_NOFS increases the risk (relative to GFP_KERNEL) because page reclaim
>can do less things than GFP_KERNEL to free memory.
>
>GFP_NOFS allocations can still perform swapspace writes, however.  GFP_NOIO
>cannot even do that.
>
>
>  
>

