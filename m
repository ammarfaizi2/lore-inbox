Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUJHWy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUJHWy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJHWy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:54:57 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:30345 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S265029AbUJHWxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:53:20 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
Date: Sat, 9 Oct 2004 00:51:18 +0200
User-Agent: KMail/1.6.2
Cc: lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
References: <1097110266.4907.187.camel@arrakis> <200410081214.20907.efocht@hpce.nec.com> <41666E90.2000208@yahoo.com.au>
In-Reply-To: <41666E90.2000208@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410090051.18693.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 12:40, Nick Piggin wrote:
> Erich Focht wrote:
> > Could you please describe the API you had in mind for that?
> > 
> 
> First of all, I think it may be easiest to allow the user to specify
> which cpus belong to which exclusive domains, and have them otherwise
> built in the shape of the underlying topology. So for example if your
> domains look like this (excuse the crappy ascii art):
> 
> 0 1  2 3  4 5  6 7
> ---  ---  ---  ---  <- domain 0
>   |    |    |    |
>   ------    ------   <- domain 1
>      |        |
>      ----------      <- domain 2 (global)
> 
> And so you want to make a partition with CPUs {0,1,2,4,5}, and {3,6,7}
> for some crazy reason, the new domains would look like this:
> 
> 0 1  2  4 5    3  6 7
> ---  -  ---    -  ---  <- 0
>   |   |   |     |   |
>   -----   -     -   -   <- 1
>     |     |     |   |
>     -------     -----   <- 2 (global, partitioned)
> 
> Agreed? You don't need to get fancier than that, do you?
> 
> Then how to input the partitions... you could have a sysfs entry that
> takes the complete partition info in the form:
> 
> 0,1,2,3 4,5,6 7,8 ...
> 
> Pretty dumb and simple.

Hmmm, this is unusable as long as you don't tell me how to create new
levels and link them together. Adding CPUs is the simplest
part. I'm with Matt here, the filesystem approach is the most
elegant. On the other hand something simple for the start wouldn't be
bad. It would show immediately whether Matt's or your way of dealing
with domains is better suited for relinking and reorganising the
domains structure dynamically. Functionality could be something like:
- list domains
- create domain
- add child domains
- link in parent domain
We're building this from bottom (cpus) up and need to take care of the
unlinking of the global domain when inserting something. But otherwise
this could be sufficient.

Regards,
Erich

