Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266541AbUAWGyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUAWGwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:52:15 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:37073 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266541AbUAWGtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:49:42 -0500
Message-ID: <4010C2BF.7090806@cyberone.com.au>
Date: Fri, 23 Jan 2004 17:44:15 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       nevdull@us.ibm.com, dvhart@us.ibm.com
Subject: Re: [PATCH] clarify find_busiest_group
References: <224300000.1074839500@[10.10.2.4]>
In-Reply-To: <224300000.1074839500@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>Fix a minor nit with the find_busiest_group code. No functional change,
>but makes the code simpler and clearer. This patch does two things ... 
>adds some more expansive comments, and removes this if clause:
>
>      if (*imbalance < SCHED_LOAD_SCALE
>                      && max_load - this_load > SCHED_LOAD_SCALE)
>		*imbalance = SCHED_LOAD_SCALE;
>
>If we remove the scaling factor, we're basically conditionally doing:
>
>	if (*imbalance < 1)
>		*imbalance = 1;
>
>Which is pointless, as the very next thing we do is to remove the scaling
>factor, rounding up to the nearest integer as we do:
>
>	*imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;
>
>Thus the if statement is redundant, and only makes the code harder to read ;-)
>

Thanks Martin,
You are right. The redundant code was left over from an older
version. Thanks for the comments too.

Andrew would you like me to take small changes like this and
feed them to you, or are you happy enough to pick them up?
No doubt there will be a a few more.


