Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbUCACyn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 21:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUCACyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 21:54:43 -0500
Received: from alt.aurema.com ([203.217.18.57]:45472 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262222AbUCACyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 21:54:39 -0500
Message-ID: <4042A5E8.9040706@aurema.com>
Date: Mon, 01 Mar 2004 13:54:32 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Lutomirski <luto@myrealbox.com>
CC: John Lee <johnl@aurema.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.jgj0bdi.b3u6qk@ifi.uio.no> <404297D1.5010301@myrealbox.com>
In-Reply-To: <404297D1.5010301@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:
> How hard would it be to make shares hierarchial?  For example (quoted 
> names are just descriptive):
> 
>      "guaranteed" (10 shares)       "user" (5 shares)
>                |                          |
>       -----------------            -----------------
>       |               |            |               |
>  "root" (1)      "apache" (2)    "bob" (5)       "fred" (5)
>       |               |            |               |
> (more groups?)    (web servers)   etc.            etc.
> 
> 
> This way one user is prevented from taking unfair CPU time by launcing 
> too many processes, apache gets enough time no matter what, etc.  In 
> this scheme, numbers of shares would only be comparable if they are 
> children of the same node.  Also, it now becomes safe to let users 
> _increase_ priorities of their processes -- it doesn't affect anyone else.
> 
> Ignoring limts, this should be just an exercise in keeping track of 
> shares and eliminating the 1/420 limit in precision.  It would take some 
> thought to figure out what nice should do.
> 

As Peter Chubb has stated such control is possible and is available on 
Tru64, Solaris and Windows with Aurema's (<http://www.aurema.com>) 
ARMTech product.  The CKRM project also addresses this issue.

> 
> Also, could interactivity problems be solved something like this:
> 
>   prio = (  (old EBS usage ratio) - 0.5  ) * i + 0.5
> 
> "i" would be a per-process interactivity factor (normally 1, but higher 
> for interactive processes) which would only boost them when their CPU 
> usage is low.  This makes interactive processes get their timeslices 
> early (very high priority at low CPU consumption) but prevents abuse by 
> preventing excessive CPU consumption.  This could even by set by the 
> (untrusted) process itself.
> 

Interactive processes do very well under EBS without any special treatment.

Programs such as xmms aren't really interactive processes although they 
usually have a very low CPU usage rate like interactive processes.  What 
distinguishes them is their need for REGULAR access to the CPU.  It's 
unlikely that such a modification would help with the need for regularity.

Once again I'll stress that in order to cause xmms to skip we had to (on 
a single CPU machine) run a kernel build with -j 16 which causes a 
system load well in excess of 10 and is NOT a normal load.  Under normal 
loads xmms performs OK.

> 
> I imagine that these two together would nicely solve most interactivity 
> and fairness issues -- the former prevents starvation by other users and 
> the latter prevents latency caused by large numbers of CPU-light tasks.
> 
> 
> Is this sane?

Yes.  Fairness between users rather than between tasks is a sane desire 
but beyond the current scope of EBS.

> And does it break the O(1) promotion algorithm?

No, it would not break the O(1) promotion algorithm.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

