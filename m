Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWCUSCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWCUSCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWCUSCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:02:06 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45961 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932370AbWCUSCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:02:02 -0500
Subject: Re: [PATCH: 002/017]Memory hotplug for new nodes v.4.(change name
	old add_memory() to arch_add_memory())
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: y-goto@jp.fujitsu.com, akpm@osdl.org, tony.luck@intel.com, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20060318102653.57c6a2af.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060317162757.C63B.Y-GOTO@jp.fujitsu.com>
	 <1142615538.10906.67.camel@localhost.localdomain>
	 <20060318102653.57c6a2af.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:00:12 -0800
Message-Id: <1142964013.10906.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 10:26 +0900, KAMEZAWA Hiroyuki wrote:
> If *determine node* function is moved to arch specific parts,
> memory hot add need more and more codes to determine  paddr -> nid in arch
> specific codes. Then, we have to add new paddr->nid function even if new nid is
> passed by firmware. We *lose* useful information of nid from firmware if 
> add_memory() has just 2 args, (start, end).  

What I'm saying is that I'd like add_memory() to be just that, for
adding memory.

At some point in the process, you need to export the NUMA node layout to
the rest of the system, to say which pages go in which node.  I'm just
saying that you should do that _before_ add_memory().

add_memory() should support adding memory to more than one node.  If any
hypervisor or hardware happens to have memory added in one contiguous
chunk, it can not simply call add_memory().  _That_ firmware would be
forced to do the NUMA parsing and figure out how many times to call
add_memory().  

Let me reiterate: the process of telling the system which pages are in
which node should be separate from telling the system that there *are*
currently pages there now.

-- Dave

