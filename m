Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292550AbSCDRZg>; Mon, 4 Mar 2002 12:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292557AbSCDRZS>; Mon, 4 Mar 2002 12:25:18 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:23461 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292550AbSCDRZL>; Mon, 4 Mar 2002 12:25:11 -0500
Date: Mon, 04 Mar 2002 12:24:42 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
Message-ID: <1210360000.1015262682@tiny>
In-Reply-To: <200203041457.g24EvvU01682@localhost.localdomain>
In-Reply-To: <200203041457.g24EvvU01682@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, March 04, 2002 08:57:57 AM -0600 James Bottomley <James.Bottomley@steeleye.com> wrote:


>> 2) ordered tags force ordering of all writes the drive is processing.
>> For some workloads, it will be forced to order stuff the journal code
>> doesn't care about at all, perhaps leading to lower performance than
>> the simple wait_on_buffer() we're using now.
> 
>> 2a) Are the filesystems asking for something impossible?  Can drives
>> really write block N and N+1, making sure to commit N to media before
>> N+1 (including an abort on N+1 if N fails), but still keeping up a
>> nice seek free stream of writes? 
> 
> These are the "big" issues.  There's not much point doing all the work to 
> implement ordered tags, if the end result is going to be no gain in 
> performance.

Right, 2a seems to be the show stopper to me.  The good news is 
the existing patches are enough to benchmark the thing and see if
any devices actually benefit.  If we find enough that do, then it
might be worth the extra driver coding required to make the code
correct.

> 
>> 4) If some scsi drives come with writeback on by default, do they also
>> turn it on under high load like IDE drives do? 
> 
> Finally, an easy one...the answer's "no".  The cache control bits are the only 
> way to alter caching behaviour (nothing stops a WCE=1 operating as write 
> through if the drive wants to, but a WCE=0 cannot operate write back).

good to hear, thanks.

-chris

