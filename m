Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163985AbWLGXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163985AbWLGXVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163989AbWLGXVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:21:30 -0500
Received: from zrtps0kn.nortel.com ([47.140.192.55]:46689 "EHLO
	zrtps0kn.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163985AbWLGXV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:21:28 -0500
Message-ID: <4578A1F1.7050907@nortel.com>
Date: Thu, 07 Dec 2006 17:21:21 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
References: <45785DDD.3000503@nortel.com> <20061207232207.01af3a79@localhost.localdomain>
In-Reply-To: <20061207232207.01af3a79@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2006 23:21:33.0046 (UTC) FILETIME=[6EB8C160:01C71A56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

>>The "oom-thresh" value maps to the max expected memory consumption for 
>>that process.  As long as a process uses less memory than the specified 
>>threshold, then it is immune to the oom-killer.

> You've just introduced a deadlock. What happens if nobody is over that
> predicted memory and the kernel uses more resource ?

Based on the discussion with Jesper, we fall back to regular behaviour. 
  (Or possibly hang or reboot, if we added another switch).

>>On an embedded platform this allows the designer to engineer the system 
>>and protect critical apps based on their expected memory consumption. 
>>If one of those apps goes crazy and starts chewing additional memory 
>>then it becomes vulnerable to the oom killer while the other apps remain 
>>protected.

> That is why we have no-overcommit support. Now there is an argument for
> a meaningful rlimit-as to go with it, and together I think they do what
> you really need.

No overcommit only protects the system as a whole, not any particular 
processes.  The purpose of this is to protect specific daemons from 
being killed when the system as a whole is short on memory.  Same 
rationale as for oomadj, but different knob to twiddle.

Chris
