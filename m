Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVINQx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVINQx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVINQx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:53:57 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:2754 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1030279AbVINQx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:53:56 -0400
Message-ID: <43285599.9040002@cs.wisc.edu>
Date: Wed, 14 Sep 2005 11:53:45 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Christie <michaelc@cs.wisc.edu>
CC: Alan Stern <stern@rowland.harvard.edu>, Anton Blanchard <anton@samba.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rc1] sym scsi boot hang
References: <Pine.LNX.4.44L0.0509141052410.5064-100000@iolanthe.rowland.org> <4328553D.10501@cs.wisc.edu>
In-Reply-To: <4328553D.10501@cs.wisc.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> Alan Stern wrote:
> 
>> On Wed, 14 Sep 2005, Anton Blanchard wrote:
>>
>>
>>> Hi,
>>>
>>>
>>>> If that's the cause, it's probably a double down of the host scan
>>>> semaphore somewhere in the code.  alt-sysrq-t should work in this case,
>>>> can you get a stack trace of the blocked process?
>>>
>>>
>>> It appears to be this patch:
>>>
>>>  [SCSI] SCSI core: fix leakage of scsi_cmnd's
>>>
>>>  From:         Alan Stern <stern@rowland.harvard.edu>
>>
>>
>>
>>> And in particular it looks like the scsi_unprep_request in
>>> scsi_queue_insert is causing it. The following patch fixes the boot
>>> problems on the vscsi machine:
>>
>>
>>
>> In general the scsi_unprep_request routine is correct and needs to be
>> there.  The one part that might be questionable is the assignment to
>> req->special.  It may turn out that the real solution is to have
>> scsi_execute set req->special to NULL; I assumed it would be NULL already
>> but perhaps I was wrong.
> 
> 
> I think we have scsi_execute and friends setting REQ_SPECIAL. This is 
> could cause a problem becuase it does not have a scsi_request.
> 

well now actually it won't becuase sc_request should be null for those 
scsi_execute block pc commands I think.
