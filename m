Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVIWH5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVIWH5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVIWH5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:57:17 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:51029 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750734AbVIWH5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:57:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D/4oZpDTCmTmxTXCR2dHxpKWkt+rtf+REFmJgiDZ1PkocbwBvcVr5nrcFDL0xah5kEN2PGZVEot1A5ShBNv+gl8IM+qdxuNPCeh8px6lsYAmegRHawm9M/Rt4iH/omWYtkDytVVYndtpozxoHyyJhKEuLbsNW/pA4xx6nMmozaM=  ;
Message-ID: <4333B588.9060503@yahoo.com.au>
Date: Fri, 23 Sep 2005 17:58:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       clameter@engr.sgi.com
Subject: Re: making kmalloc BUG() might not be a good idea
References: <20050922.231434.07643075.davem@davemloft.net> <4333A109.2000908@yahoo.com.au> <200509230909.54046.ioe-lkml@rameria.de>
In-Reply-To: <200509230909.54046.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi,
> 
> On Friday 23 September 2005 08:30, Nick Piggin wrote:
> 
>>David S. Miller wrote:
>>
>>>I'm sort-of concerned about this change:
>>>
>>>   [PATCH] __kmalloc: Generate BUG if size requested is too large.
>>>
>>>it opens a can of worms, and stuff that used to generate
>>>-ENOMEM kinds of failures will now BUG() the kernel.
>>
>>Making it WARN might be a good compromise.
> 
> 
> Which has the potential to spam the logs with a user triggerable event
> without even killing the responsible process.
> Same problem, just worse.
> 

As opposed to potentially taking the system down? I don't
think so.

> I could live with a solution that enables it based on a config.
> 

Then you'll get people not enabling it on real workloads, or
tuning it off if it bugs them. No, the point of having a WARN
there is really for people like SGI to detect a few rare failure
cases when they first boot up their 1024+ CPU systems. It is not
going to spam anyone's logs (and if it does it *needs* fixing).

What you don't want is to kill the responsible process, because
at that point they're deep in the kernel, probably holding other
locks and resources.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
