Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262963AbTCSCxH>; Tue, 18 Mar 2003 21:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262964AbTCSCxH>; Tue, 18 Mar 2003 21:53:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:54446 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262963AbTCSCxG>;
	Tue, 18 Mar 2003 21:53:06 -0500
Date: Tue, 18 Mar 2003 19:04:07 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: async@cc.gatech.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limits on SCHED_FIFO tasks
Message-Id: <20030318190407.37a39db1.akpm@digeo.com>
In-Reply-To: <3E77C40D.4090700@mvista.com>
References: <20030318185135.D1361@tokyo.cc.gatech.edu>
	<3E77C40D.4090700@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 03:03:49.0969 (UTC) FILETIME=[2A59B410:01C2EDC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> If the issue is regaining control after some RT task goes into a loop, 
> the way this is usually done is to keep a session around with a higher 
> priority.  Using this concept, one might provide tools that, from 
> userland, insure that such a session exists prior to launching the 
> "suspect" code.  I fail to see the need for this sort of code in the 
> kernel.

That works, until your shell calls ext3_mark_inode_dirty(), which blocks on
kjournald activity.  kjournald is SCHED_OTHER, and never runs...


