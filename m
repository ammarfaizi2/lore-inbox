Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266270AbUBDGkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 01:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUBDGkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 01:40:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:17100 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266270AbUBDGkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 01:40:39 -0500
Subject: Re: Active Memory Defragmentation: Our implementation & problems
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alok Mooley <rangdi@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <38540000.1075876171@[10.10.2.4]>
References: <20040204050915.59866.qmail@web9704.mail.yahoo.com>
	 <1075874074.14153.159.camel@nighthawk>  <35380000.1075874735@[10.10.2.4]>
	 <1075875756.14153.251.camel@nighthawk>  <38540000.1075876171@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1075876826.14166.314.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Feb 2004 22:40:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-03 at 22:29, Martin J. Bligh wrote:
> There are a couple of special cases that might be feasible without making
> an ungodly mess. PTE pages spring to mind (particularly as they can be
> in highmem too). They should be reasonably easy to move (assuming we can
> use rmap to track them back to the process they belong to to lock them ...
> hmmm ....)

We don't do any pte page reclaim at any time other than process exit and
there are plenty of pte pages we can just plain free anyway.  Anthing
that's completely mapping page cache, for instance.

In the replacement case, taking mm->page_table_lock, doing the copy, and
replacing the pointer from the pmd should be all that it takes.  But, I
wonder if we could miss any sets of the pte dirty bit this way...

--dave

