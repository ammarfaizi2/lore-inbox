Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVHKSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVHKSFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVHKSFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:05:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51623 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932334AbVHKSFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:05:05 -0400
Date: Thu, 11 Aug 2005 23:30:44 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rusty@au1.ibm.com, bmark@us.ibm.com
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050811180044.GD4546@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050810171145.GA1945@us.ibm.com> <20050811171451.GA5108@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811171451.GA5108@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 06:14:51PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 10, 2005 at 10:11:45AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This patch is an experiment in use of RCU for individual code paths that
> > read-acquire the tasklist lock, in this case, unicast signal delivery.
> > It passes five kernbenches on 4-CPU x86, but obviously needs much more
> > testing before it is considered for serious use, let alone inclusion.
> 
> I think we should switch over tasklist_lock to RCU completely instead of
> adding suck hacks.  I've started lots of preparation work to get rid of
> tasklist_lock users outside of kernel/, especialy getting rid of any
> use in modules.

That would be really helpful, specially the ones in drivers/char/tty*.c :)

When I worked on this last (a year or so ago), it seemed that I would
need to put a number of additional structures under RCU control.
It would be better to gradually move it towards RCU rather than
trying make all the readers lock-free.

Thanks
Dipankar
