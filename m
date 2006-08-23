Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWHWO6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWHWO6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWHWO6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:58:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:63937 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964909AbWHWO6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:58:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=povCRtEPnJvV2JCNEXcn99ZIXMqsK6mlj3Ey5HDul5f9yWt+fqQc0pcH99pl5z6zUqTtbjaNPhBbsF/rP7VohwDFm/9Xd9wZz30WWY2onWVFbR7RrJvz3FF8kfdF5cJnYil0s0TvN8U8ALKE5DicUMa/P/bkeGt1aNuky4ZQbjU=
Message-ID: <6bffcb0e0608230758sebc711fu9e41bff305966253@mail.gmail.com>
Date: Wed, 23 Aug 2006 16:58:15 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Shailabh Nagar" <nagar@watson.ibm.com>
Subject: Re: Possible memory leak in kernel/delayacct.c
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Balbir Singh" <balbir@in.ibm.com>
In-Reply-To: <44EB5794.9020205@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b0943d9e0608190358i7cb93b75g1b52d2f1b7e6f1a@mail.gmail.com>
	 <44EB5794.9020205@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/08/06, Shailabh Nagar <nagar@watson.ibm.com> wrote:
> Catalin Marinas wrote:
> > Hi Shailabh,
> >
> > Michal was running some kmemleak tests and there are about 20 orphan
> > pointers reported in delayacct.c. The allocation backtrace is:
> >
> > orphan pointer 0xf548fde0 (size 76):
> >  c0174674: <kmem_cache_zalloc>
> >  c01591ee: <__delayacct_tsk_init>
> >  c0127e06: <copy_process>
> >  c0128cd2: <do_fork>
> >  c0104d39: <sys_clone>
> >
> > I'm not sure whether the leak occurs but there might be a path where
> > task_struct is freed and the task->delays pointer is lost. Could you
> > please have a look at this? Thanks.
> >
>
> One possibility for the leak is a missing free for tsk->delays on a
> failed fork. Were the kmemleak tests causing fork failures to happen ?
> What was being run in userspace ? Since the tsk->delays get allocated
> from a slab, it should be easy enough to detect.
>
> Could you try the patch below ? Its also being used for an oops reported
> for delay accounting.

The problem seems to be fixed. Thanks.

$ ls /tmp/ml* | wc -l
20

$ cat /tmp/ml* | grep -c __delayacct_tsk_init
0

> Thanks,
> Shailabh

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
