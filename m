Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVKPQbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVKPQbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbVKPQbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:31:50 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8384 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030383AbVKPQbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:31:49 -0500
Subject: Re: [Lhms-devel] Re: 2.6.14-mm2
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <437B5801.4010204@jp.fujitsu.com>
References: <20051110203544.027e992c.akpm@osdl.org>
	 <437B2C82.6020803@jp.fujitsu.com> <1132147036.7915.19.camel@localhost>
	 <437B5801.4010204@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 17:31:44 +0100
Message-Id: <1132158704.19290.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 01:02 +0900, Kamezawa Hiroyuki wrote: 
> > Can you explain in a little bit more detail why this matters, and
> > exactly how it fixes your problem.  I'm not sure it's correct.
> > 
> Ah, okay.
> 
> It's just because free_area[] is not initaialized at all if this is not called.
> It is list.next and list.prev has bad value.
> Then, the first free_page(page) will cause panic.

Hmmm.  I _think_ you're just trying to do some things at runtime that I
didn't intend.  In the patch I pointed to in the last mail, look at what
I did in hot_add_zone_init().  It does some of what
free_area_init_core() does, but only the most minimal bits.  Basically:

       zone_wait_table_init(zone, size_pages);
       init_currently_empty_zone(zone, phys_start_pfn, size_pages);
       zone_pcp_init(zone);

Your way may also be valid, but I broke out init_currently_empty_zone()
for a reason, and I think this was it.  I don't think we want to be
calling free_area_init_core() itself at runtime.

-- Dave

