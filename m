Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbTLRBZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 20:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTLRBZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 20:25:30 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:42677 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264892AbTLRBZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 20:25:25 -0500
Message-ID: <3FE10204.2030708@namesys.com>
Date: Thu, 18 Dec 2003 04:25:24 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jshankar <jshankar@CS.ColoState.EDU>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
       Mike Fedyk <mfedyk@matchmail.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system
References: <3FF18FD8@webmail.colostate.edu>
In-Reply-To: <3FF18FD8@webmail.colostate.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jshankar wrote:

>Hello,
>
>Please provide some more insight.
>
>Suppose a filesystem issues a write command to the disk with around 10 4K 
>Blocks  to be written. SCSI device point of view i don't get what is the 
>parallel I/O.
>It has only 1 write command. If some other sends a write request it needs to 
>be queued. But the next question arises how the write data would be handled. 
>Does it mean the SCSI does not give a response for the block of data written. 
>In otherwords does it mean that the response would be given after all the 
>block of data is written for a single write request.
> 
>Thanks
>Jay
>
>
>
>
>  
>
>>===== Original Message From Mike Fedyk <mfedyk@matchmail.com> =====
>>On Wed, Dec 17, 2003 at 05:25:49PM -0500, Richard B. Johnson wrote:
>>    
>>
>>>to the physical media. There are special file-systems (journaling)
>>>that guarantee that something, enough to recover the data, is
>>>written at periodic intervals.
>>>      
>>>
>>Most journaling filesystems make guarantees on the filesystem meta-data, but
>>not on the data.  Some like ext3, and reiserfs (with suse's journaling
>>patch) can journal the data, or order things so that the data is written
>>before any pointers (ie meta-data) make it to the disk so it will be harder
>>to loose data.
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Filesystems don't usually wait on the IO to complete before submitting 
more IO in response to the next write() syscall.  They can do this by 
batching a whole bunch of operations into one committed transaction.

In reiser4 we do this more carefully than other filesystems such as 
reiserfs v3, and as a result every fs operation is fully atomic.

-- 
Hans


