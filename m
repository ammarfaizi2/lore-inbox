Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWHUEaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWHUEaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 00:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWHUEaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 00:30:09 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:53976 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S964861AbWHUEaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 00:30:07 -0400
Date: Mon, 21 Aug 2006 10:02:57 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: kill unnecessary timer in fdtable_defer
Message-ID: <20060821043257.GD5433@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060820131542.GN6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820131542.GN6371@htj.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:15:42PM +0900, Tejun Heo wrote:
> free_fdtable_rc() schedules timer to reschedule fddef->wq if
> schedule_work() on it returns 0.  However, schedule_work() guarantees
> that the target work is executed at least once after the scheduling
> regardless of its return value.  0 return simply means that the work
> was already pending and thus no further action was required.

Hmm.. Is this really true ? IIRC, schedule_work() checks pending
work based on bit ops on work->pending and clear_bit() is not
a memory barrier. So, if I see work->pending = 1 in free_fdtable_work(), how
do I know that the work function is already executing and
missed the new work that I had queued ?


Thanks
Dipankar
