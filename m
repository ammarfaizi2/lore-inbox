Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWAKO3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWAKO3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWAKO3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:29:40 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:27025 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932384AbWAKO3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:29:39 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Thu, 12 Jan 2006 01:29:15 +1100
User-Agent: KMail/1.9
Cc: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au>
In-Reply-To: <43C4F8EE.50208@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120129.16315.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 23:24, Peter Williams wrote:
> Martin J. Bligh wrote:
> > That seems broken to me ?
>
> But, yes, given that the problem goes away when the patch is removed
> (which we're still waiting to see) it's broken.  I think the problem is
> probably due to the changed metric (i.e. biased load instead of simple
> load) causing idle_balance() to fail more often (i.e. it decides to not
> bother moving any tasks more often than it otherwise would) which would
> explain the increased idle time being seen.  This means that the fix
> would be to review the criteria for deciding whether to move tasks in
> idle_balance().

Look back on my implementation. The problem as I saw it was that one task 
alone with a biased load would suddenly make a runqueue look much busier than 
it was supposed to so I special cased the runqueue that had precisely one 
task.

Cheers,
Con
