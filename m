Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVLUVff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVLUVff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLUVff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:35:35 -0500
Received: from ns1.siteground.net ([207.218.208.2]:21426 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964803AbVLUVfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:35:34 -0500
Date: Wed, 21 Dec 2005 13:35:28 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       nippung@calsoftinc.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded process at getrusage()
Message-ID: <20051221213528.GC4514@localhost.localdomain>
References: <20051221182320.GA4514@localhost.localdomain> <Pine.LNX.4.62.0512211209300.2829@schroedinger.engr.sgi.com> <20051221211135.GB4514@localhost.localdomain> <Pine.LNX.4.62.0512211318070.3443@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512211318070.3443@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 01:22:24PM -0800, Christoph Lameter wrote:
> On Wed, 21 Dec 2005, Ravikiran G Thirumalai wrote:
> 
> > We did look at that. Cases RUSAGE_CHILDREN and RUSAGE_SELF are always called by the 
> > current task, so we can avoid tasklist locking there.
> > getrusage for non-current tasks are always called with RUSAGE_BOTH.
> > We ensure we  always take the siglock for RUSAGE_BOTH case, so that the
> > p->signal* fields are protected and take the tasklist_lock only if we have 
> > to traverse the tasklist hashlist. Isn't this safe?
> 
> Sounds okay. But its complex in the way its is coded now and its easy to 
> assume that one can call getrusage with any parameter from inside the 
> kernel. Maybe we can have a couple of separate functions 
> 
> rusage_children()
> rusage_self()
> rusage_both()
> 
> ?
> 
> Only rusage_both would take a task_struct * parameter. The others would 
> only operate on current. Change all the locations that call getrusage with 
> RUSAGE_BOTH to call rusage_both().

Yes.  This would indeed be better. I will do that change.

Thanks,
Kiran
