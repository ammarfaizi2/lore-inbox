Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269697AbUJGWSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269697AbUJGWSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269852AbUJGWQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:16:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:56770 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269858AbUJGWP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:15:26 -0400
Subject: RE: [ckrm-tech] [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
Cc: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPIEMNCHAA.mef@cs.princeton.edu>
References: <NIBBJLJFDHPDIBEEKKLPIEMNCHAA.mef@cs.princeton.edu>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097186807.17473.22.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 07 Oct 2004 15:06:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 21:12, Marc E. Fiuczynski wrote:
> > ... thus making supporting interesting NUMA machines
> > and SMT machines easier.
> 
> Would you be so kind and elaborate on the SMT part.
> 
> Marc

Contrary to Paul's posting that no one saw, SMT is not a typo. ;)  What
I was trying to get at is that there are already several differing
implementations of SMT (Synchronous Multi-Threading) with different
names and different characteristics.  Right now, they're all kind of
handled the same.  In the future, however, I see each architecture
defining their own SD_SIBLING_INIT for sibling domains, allowing their
own cache timings, balancing rates, etc.  I feel that it would be easier
to support potentially complicated and/or dynamic sibling 'CPU'
relationships with my patch.  We've already run into some issues with
hotplugging the siblings of 'real' CPUs on/off, and how the current
sched_domains handles that.  Currently, as the code is static and based
on config options rather than runtime variables, it tends to leave a
single CPU in it's own domain, balancing amongst itself with no sibling
(b/c it's been hotplugged off and CONFIG_SCHED_SMT is on).  My code was
written with dynamic runtime changes in mind to prevent these kinds of
suboptimal situations.

-Matt

