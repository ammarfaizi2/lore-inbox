Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVCJEIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVCJEIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVCJEHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:07:39 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:25596 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261769AbVCJEFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:05:40 -0500
Date: Wed, 9 Mar 2005 20:04:17 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: RE: Direct io on block device has performance regression on 2.6.x
 kernel
In-Reply-To: <200503100347.j2A3lRg28975@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0503092000210.4446@qynat.qvtvafvgr.pbz>
References: <200503100347.j2A3lRg28975@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Chen, Kenneth W wrote:

>> Also, I'm rather peeved that we're hearing about this regression now rather
>> than two years ago.  And mystified as to why yours is the only group which
>> has reported it.
>
> 2.6.X kernel has never been faster than the 2.4 kernel (RHEL3).  At one point
> of time, around 2.6.2, the gap is pretty close, at around 1%, but still slower.
> Around 2.6.5, we found global plug list is causing huge lock contention on
> 32-way numa box.  That got fixed in 2.6.7.  Then comes 2.6.8 which took a big
> dip at close to 20% regression.  Then we fixed 17% regression in the scheduler
> (fixed with cache_decay_tick).  2.6.9 is the last one we measured and it is 6%
> slower.  It's a constant moving target, a wild goose to chase.
>
> I don't know why other people have not reported the problem, perhaps they
> haven't got a chance to run transaction processing db workload on 2.6 kernel.
> Perhaps they have not compared, perhaps they are working on the same problem.
> I just don't know.

Also the 2.6 kernel is Soo much better in the case where you have many 
threads (even if they are all completely idle) that that improvement may 
be masking the regression that Ken is reporting (I've seen a 50% 
performance hit on 2.4 with just a thousand or two threads compared to 
2.6). let's face it, a typical linux box today starts up a LOT of stuff 
that will never get used, but will count as an idle thread.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
