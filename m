Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVCJU5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVCJU5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVCJU5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:57:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6551 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262743AbVCJU4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:56:34 -0500
Date: Thu, 10 Mar 2005 12:54:48 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9) +
 prezeroing (Version 4)
Message-Id: <20050310125448.5b52dcba.pj@engr.sgi.com>
In-Reply-To: <1110485835.24355.1.camel@localhost>
References: <20050307193938.0935EE594@skynet.csn.ul.ie>
	<1110239966.6446.66.camel@localhost>
	<Pine.LNX.4.58.0503101421260.2105@skynet>
	<20050310092201.37bae9ba.pj@engr.sgi.com>
	<1110478613.16432.36.camel@localhost>
	<20050310121124.488cb7c5.pj@engr.sgi.com>
	<1110485835.24355.1.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> Shouldn't a particular task know what the policy should be when it is
> launched? 

No ... but not necessarily because it isn't known yet, but rather also
because it might be imposed earlier in the job creation, before the
actual task hierarchy is manifest.  This point goes to the heart of one
of the motivations for cpusets themselves.

On a big system, one might have OpenMP threads inside MPI tasks inside
jobs being managed by a batch manager, running on a subset of the
system.  The system admins may need to impose these policy decisions
from the outside, and not uniformly across the entire batch managed
arena.  The cpuset becomes the named object, to which such attributes
accrue, to take affect on whatever threads, tasks, or jobs end up
thereon.

Do a google search for "mixed openmp mpi", or for "hybrid openmp mpi",
to find examples of such usage, then imagine such jobs running inside a
batch manager, on a portion of a larger system.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
