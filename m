Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUI0UEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUI0UEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0UEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:04:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:57071 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267313AbUI0UDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:03:33 -0400
Message-ID: <415872E5.1050004@austin.ibm.com>
Date: Mon, 27 Sep 2004 15:07:01 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <Pine.LNX.4.44.0409242123110.14902-100000@dyn319181.beaverton.ibm.com>	 <41583225.4040901@austin.ibm.com> <1096310537.11845.33.camel@dyn319181.beaverton.ibm.com>
In-Reply-To: <1096310537.11845.33.camel@dyn319181.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai wrote:

>On Mon, 2004-09-27 at 08:30, Steven Pratt wrote:
>  
>
>>Ram Pai wrote:
>>    
>>
>>>On Fri, 24 Sep 2004, Ram Pai wrote: 
>>>
>>>      
>>>
>>>>On Thu, 23 Sep 2004, Steven Pratt wrote:
>>>>   
>>>>        
>>>>
>
> ..snip..
>  
>
>>>To summarize you noticed 3 problems:
>>>
>>>1. page cache hits not handled properly.
>>>2. readahead thrashing not accounted.
>>>3. read congestion not accounted.
>>> 
>>>
>>>      
>>>
>>Yes.
>>    
>>
>>>Currently both the patches do not handle all the above cases.
>>> 
>>>
>>>      
>>>
>>No, thrashing was handled in the first patch, and both thrashing and 
>>page cache hits are handled in the second.  Also, it seems to be the 
>>consensus that on normal I/O ignoring queue congestion is the right 
>>behavior.
>>
>>    
>>
>>>So if your patch performs much better than the current one, than
>>>it is the winner anyway.   But past experience has shown that some
>>>benchmark gets a hit for any small change. This happens to be tooo big
>>>a change.
>>>
>>>      
>>>
>>I agree, we need more people to test this.
>>
>>    
>>
>
>
>I will fix the 3 problems you discovered in the current code.
>And lets  compare the two results.
>
Ok, great.

>  However you have more features in
>your patch which will be the differentiating factor between the two
>versions.
>
>1. exponential increase and decrease of window size 
>2. overlapped read of current window and readahead window.
>3. fixed slow-read path.
>4. anything else?
>	
>
No, I think that is it.

>The readsize parameter comes in handy to incorporate the
>the above features.
>  
>
Yes, without it I think you still need to do the average calculations 
that you do today.

Also, remember that we did not re-write the readahead code just for the 
fun of it.  It was simply the most efficient way we came up with to 
address the current issues as well as add the new features.  The actual 
I/O patterns generated are not that different in most cases.

Steve


