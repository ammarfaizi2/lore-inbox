Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUGAXjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUGAXjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 19:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbUGAXjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 19:39:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:65271 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266365AbUGAXjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 19:39:12 -0400
Date: Thu, 1 Jul 2004 16:38:34 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task name handling in proc fs
Message-ID: <20040701233834.GD5090@w-mikek2.beaverton.ibm.com>
References: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com> <20040701151935.1f61793c.akpm@osdl.org> <20040701224215.GC5090@w-mikek2.beaverton.ibm.com> <20040701160335.229cfe03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701160335.229cfe03.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 04:03:35PM -0700, Andrew Morton wrote:
> 
> But this just makes it a bit less racy than it used to be.

Agreed!

> If we need locking around task->comm (and it seems that we do) then
> let's do it.

I'm not sure if there is a need/desire for locking.  But, I don't
have any proc fs history.  What we saw were really badly formed
task names: nulls embedded within strings.  My goal was to simply
provide well formed strings (even if they didn't make sense).

I guess the question is 'how important is it to make sure that
data in these files is consistent/accurate when reported?'.  If it
is highly important, then we need to consider locking down the
task for the duration of gathering all data we want to display
(not just task->comm).  However, my guess is that we would want
to sacrifice this accuracy/consistency to avoid taking locks if
possible.  Again, this is just my opinion and I don't have any
history here ... but would be happy to code up any recommendation.

P.S. Note that these code paths already get the task lock once
as a result of calling get_task_mm().

-- 
Mike
