Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbVHERKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbVHERKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVHERKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:10:00 -0400
Received: from graphe.net ([209.204.138.32]:15771 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263037AbVHERJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:09:23 -0400
Date: Fri, 5 Aug 2005 10:09:19 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Adam Litke <agl@us.ibm.com>, linux-kernel@vger.kernel.org, dwg@au1.ibm.com
Subject: Re: [RFC] Demand faulting for large pages
In-Reply-To: <20050805164702.GY8266@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508051001010.30363@graphe.net>
References: <1123255298.3121.46.camel@localhost.localdomain>
 <20050805155307.GV8266@wotan.suse.de> <1123259847.3121.91.camel@localhost.localdomain>
 <20050805164702.GY8266@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Andi Kleen wrote:

> > Unless I am missing something, the call to follow_hugetlb_page() in
> > get_user_pages() is just an optimization.  Removing it means
> > follow_page() will be called individually for each PAGE_SIZE page in the
> > huge page.  We can probably do better but I didn't want to cloud this
> > patch with that logic.
> 
> The problem is that get_user_pages needs to handle the case of a large
> page not yet being faulted in properly. The SLES9 implementation did
> some changes for this.
> 
> You don't change it at all, so I'm suspect it doesn't work yet.
> 
> It's a common case - think people doing raw IO on huge pages shared memory.

Seems that follow_page calls follow_huge_addr for huge pages. 
follow_huge_addr is arch specific and so we would need to verify that all 
arches do the right things if the page is not present.


