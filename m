Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTILLJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTILLJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:09:52 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43794 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261201AbTILLJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:09:50 -0400
Date: Fri, 12 Sep 2003 13:18:08 +0200
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Rahul Karnik <rahul@genebrew.com>, rusty@linux.co.intel.com,
       riel@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
Message-ID: <20030912111808.GA13973@hh.idb.hist.no>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> <3F614912.3090801@genebrew.com> <3F614C1F.6010802@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F614C1F.6010802@nortelnetworks.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 12:31:27AM -0400, Chris Friesen wrote:
> Rahul Karnik wrote:
> >Rusty Lynch wrote:
> >
> >>The patch below uses a notifier list for other components to register
> >>to be called when an out of memory condition occurs.
> >
> >
> >How does this interact with the overcommit handling? Doesn't strict 
> >overcommit also not oom, but rather return a memory allocation error? 
> >Could we not add another overcommit mode where oom conditions cause a 
> >kernel panic?
> 
> If you have real, true strict overcommit, then it can cause you to have 
> errors much earlier than expected.
> 
> Imagine a process that consumes 51% of memory.  With strict overcommit, 
> that process cannot fork() since there is not enough memory.

Note that this "memory" is RAM+swap.  So you can avoid allocation
failure by giving your strict overcommit box much more swap space.

The allocations will be backed by swap, this won't slow the machine
down at all because it isn't used normally.  Or to put it another
way - you'll use that extra swap only in those situations where
you otherwise get allocation failure or OOM killing.

Helge Hafting
