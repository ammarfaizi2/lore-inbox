Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbUBDHSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUBDHSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:18:06 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:26826 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266309AbUBDHSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:18:04 -0500
Date: Tue, 03 Feb 2004 23:17:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Alok Mooley <rangdi@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
Message-ID: <1180000.1075879076@[10.10.2.4]>
In-Reply-To: <1075876826.14166.314.camel@nighthawk>
References: <20040204050915.59866.qmail@web9704.mail.yahoo.com> <1075874074.14153.159.camel@nighthawk>  <35380000.1075874735@[10.10.2.4]> <1075875756.14153.251.camel@nighthawk>  <38540000.1075876171@[10.10.2.4]> <1075876826.14166.314.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There are a couple of special cases that might be feasible without making
>> an ungodly mess. PTE pages spring to mind (particularly as they can be
>> in highmem too). They should be reasonably easy to move (assuming we can
>> use rmap to track them back to the process they belong to to lock them ...
>> hmmm ....)
> 
> We don't do any pte page reclaim at any time other than process exit and
> there are plenty of pte pages we can just plain free anyway.  Anthing
> that's completely mapping page cache, for instance.
> 
> In the replacement case, taking mm->page_table_lock, doing the copy, and
> replacing the pointer from the pmd should be all that it takes.  But, I
> wonder if we could miss any sets of the pte dirty bit this way...

As long as we make sure the process doesn't run during the move, I don't
see why it'd be a problem. But I am less than convinced that rmap will
lead us back from the PTE page to the mm, at least w/o modification.

M.

