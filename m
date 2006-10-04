Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWJDAGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWJDAGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWJDAGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:06:23 -0400
Received: from gw.goop.org ([64.81.55.164]:62398 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030414AbWJDAGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:06:22 -0400
Message-ID: <4522FB04.1080001@goop.org>
Date: Tue, 03 Oct 2006 17:06:28 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: tim.c.chen@linux.intel.com
CC: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       leonid.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <1159916644.8035.35.camel@localhost.localdomain>
In-Reply-To: <1159916644.8035.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen wrote:
> Hi Herbet,
>
> The patch "Let WARN_ON/WARN_ON_ONCE return the condition"
> http://kernel.org/git/?
> p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=684f978347deb42d180373ac4c427f82ef963171
>
> introduced 40% more 2nd level cache miss to tbench workload
> being run in a loop back mode on a Core 2 machine.  I think the
> introduction of the local variables to WARN_ON and WARN_ON_ONCE
>
> typeof(x) __ret_warn_on = (x);
> typeof(condition) __ret_warn_once = (condition);
>
> results in the extra cache misses.  In our test workload profile, we see
> heavily used functions like do_softirq and local_bh_enable 
> takes a lot longer to execute.  
>
> The modification below helps fix the problem.  I made a slight
> modification to sched.c to get around a gcc bug.
>   

How does the generated code change?  Doesn't evaluating the condition 
multiple times have the potential to cause problems?

    J
