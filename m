Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268098AbUH2Qle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbUH2Qle (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUH2Qle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:41:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6313 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268098AbUH2Qlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:41:32 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: sched_domains + NUMA issue
Date: Sun, 29 Aug 2004 09:40:31 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       nathanl@austin.ibm.com
References: <20040829111855.GB26072@krispykreme>
In-Reply-To: <20040829111855.GB26072@krispykreme>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408290940.31903.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 29, 2004 4:18 am, Anton Blanchard wrote:
> Hi,
>
> We are seeing errors in the sched domains debug code when SMT + NUMA is
> enabled. Nathan pointed out that the recent change to limit the number
> of nodes in a scheduling group may be causing this - in particular
> sched_domain_node_span.
>
> It looks like ia64 are the only ones implementing a reasonable
> node_distance, the others just do:
>
> #define node_distance(from,to) (from != to)
>
> On these architectures I wonder if we should disable the
> sched_domain_node_span code since we will just get a random grouping of
> cpus.

Hmm... for now that's probably a good idea.  There's no CONFIG_NUMA_* value we 
could key off of to figure out if node_distance is sane, so it's probably our 
only option.

Jesse
