Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUJRRIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUJRRIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJRRIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:08:40 -0400
Received: from mail3.utc.com ([192.249.46.192]:3791 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S263664AbUJRRIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:08:34 -0400
Message-ID: <4173F879.40102@cybsft.com>
Date: Mon, 18 Oct 2004 12:08:09 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
References: <OFF2CA4065.A5BB2E79-ON86256F31.005A287D-86256F31.005A2895@raytheon.com> <20041018165416.GA31259@elte.hu>
In-Reply-To: <20041018165416.GA31259@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
> 
> 
>>>i have released the -U5 Real-Time Preemption patch:
>>>
>>>
>>
>>http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5
>>
>>I am getting build problems - specifically with:
> 
> 
>>  CC [M]  drivers/char/ipmi/ipmi_watchdog.o
> 
> 
>>If I read the patch correctly, this should be recoded as
>>  DECLARE_MUTEX
>>instead, but a quick grep of the source code indicates we have about
>>20 more places where DECLARE_MUTEX_LOCKED is still used. Should I do
>>a global replace on that or is something else needed?
> 
> 
> it's not normally used, and it's much simpler to rewrite those places
> than to implement initialization. (which would be quite hairy)
> 
> 
>>I also had a compile failure in XFS. The messages are:
>>  CC [M]  fs/xfs/quota/xfs_dquot_item.o
>>  CC [M]  fs/xfs/quota/xfs_trans_dquot.o
> 
> 
> ok, i've re-uploaded a new version of -U5 that has this and the 
> ipmi_watchdog compilation problems fixed.
> 
> please check whether it works, XFS does not seem to make use of count>1
> semaphores but one never knows ...
> 
> 	Ingo
> 
> 

Well you just beat me with that one. :) And here is another for aha152x.

--- linux-2.6.9-rc4-mm1/drivers/scsi/aha152x.c.orig     2004-10-18 
12:05:02.891049751 -0500
+++ linux-2.6.9-rc4-mm1/drivers/scsi/aha152x.c  2004-10-18 
12:05:24.360353020 -0500
@@ -1160,7 +1160,7 @@
  static int aha152x_device_reset(Scsi_Cmnd * SCpnt)
  {
         struct Scsi_Host *shpnt = SCpnt->device->host;
-       DECLARE_MUTEX_LOCKED(sem);
+       DECLARE_MUTEX(sem);
         struct timer_list timer;
         int ret, issued, disconnected;
         unsigned long flags;

