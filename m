Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTFLQjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTFLQjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:39:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:21499 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264893AbTFLQjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:39:41 -0400
Date: Thu, 12 Jun 2003 22:25:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612165559.GE1438@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com> <16104.40370.828325.379995@charged.uio.no> <20030612155345.GB1438@in.ibm.com> <20030612163045.GK6754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612163045.GK6754@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 05:30:45PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jun 12, 2003 at 09:23:45PM +0530, Dipankar Sarma wrote:
> 
> > Lockfree d_lookup() gives us significant benefits in larger
> > SMP machines.
> 
> I wonder if they outweight debugging time wasted after any change...

Several sets of numbers have been published in lkml on this.
I will work on sending out my updates to the vfs locking document
you wrote ASAP. AFAICS, most dcache APIs work as is despite lockfree
lookup. As long as we follow those rules, we should be ok.

> 
> Note that for vfsmounts proposed RCU patch had been utterly useless -
> practically all improvements had been from separate lock for vfsmounts
> (see akpm tree).

Yes and that is why Maneesh's patch had two parts. In that case benefit
came from reducing acquisition of dcache_lock by the first part itself -
using a separate lock for vfsmounts. It does not seem possible to 
split up dcache_lock any further without very significant changes in vfs.
The acquisition of vfsmount_lock by itself was not significant enough
to really warrant lockfree lookup.

Thanks
Dipankar
