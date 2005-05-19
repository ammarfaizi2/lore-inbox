Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVESMzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVESMzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVESMzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:55:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262485AbVESMzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:55:21 -0400
Message-ID: <428C8C32.2030803@redhat.com>
Date: Thu, 19 May 2005 08:53:06 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: steve <lingxiang@huawei.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
Subject: Re: why nfs server delay 10ms in nfsd_write()?
References: <0IGP00IZRULADZ@szxml02-in.huawei.com> <1116472423.11327.1.camel@mindpipe>
In-Reply-To: <1116472423.11327.1.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Thu, 2005-05-19 at 10:46 +0800, steve wrote:
>  
>
>>i have 2 questions:
>>1.i don't know why do we have to sleep for 10 ms, why not do sync immediately?
>>2.what will happen if we don't sleep for 10ms?
>>when i delete these codes, i get a good result, and the write performace improved from 300KB/s to 18MB/s
>>
>>    
>>
>
>Did you read the comments in the code?
>
>                /*
>                 * Gathered writes: If another process is currently
>                 * writing to the file, there's a high chance
>                 * this is another nfsd (triggered by a bulk write
>                 * from a client's biod). Rather than syncing the
>                 * file with each write request, we sleep for 10 msec.
>                 *
>                 * I don't know if this roughly approximates
>                 * C. Juszak's idea of gathered writes, but it's a
>                 * nice and simple solution (IMHO), and it seems to
>                 * work:-)
>                 */
>  
>

There are certainly many others way to get gathering, without adding an
artificial delay.  There are already delay slots built into the code 
which could
be used to trigger the gathering, so with a little bit different 
architecture, the
performance increases could be achieved.

Some implementations actually do write gathering with NFSv3, even.  Is
this interesting enough to play with?  I suspect that just doing the 
work for
NFSv2 is not...

    Thanx...

       ps
