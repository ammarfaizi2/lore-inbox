Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWCIFR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWCIFR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422634AbWCIFR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:17:27 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:39581 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422632AbWCIFR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:17:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sMyNSY4SouV+sRXhHTvY157jKyRk1zzBOZWH230LorI/bPgrrnL53XufAOVt6dVi/uC5+uS1vYHNqvw0GmfSmfG/LMo1JjOBcmonzJIZ171NjvQkVvk7fNSCRqB42ZdJ/DFfvERnEnV8X2ANdH2YXzQ/N72qR2zA+b9gJ6rRP+M=
Message-ID: <440FBA9C.3050109@gmail.com>
Date: Thu, 09 Mar 2006 13:18:20 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16-rc5-m3 PATCH] inotify: add the monitor for the event
 source
References: <440F075F.1030404@gmail.com> <1141836798.12175.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1141836798.12175.1.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2006-03-09 at 00:33 +0800, Yi Yang wrote:
>   
>> Current inotify implementation only focus on change of file system, but it doesn't
>>  know who results in this change, this patch adds three fields to struct inotify_event,
>>  tgid, uid and gid, they will save process ID, user ID and user group ID of the process
>>  which leads to change in the file system, such software as anti-virus can make use 
>> of this feature to monitor who is modifying a specific file.
>>     
>
>
> this patch appears to change the ABI! That is bad bad bad.
>   
a change of struct inotify_event can't change ABI, can you describe it 
more clear?
> Also, how can you guarantee that "current" is valid and meaningful at
> the place you use it to get the user id ??
>   
Of course, current process/thread never disappears before fsnotify_* 
returns.
> Also the process ID part is really bogus, after all the process may have
> exited by the time the inotify client gets to it, and the PID may even
> already have been reused.
>
>   
Your concern is correct, but uid and git can give out some hints, I ever 
considered to
save the name of current process, however that needs a bigger and 
length-variable
inotify_event struct, moreover, to get the full path name of current 
process/thread
in kernel will have a big overhead, so I must select a comprise way. In 
fact, the case
 you said is very few.

