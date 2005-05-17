Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVEQNMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVEQNMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVEQNMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:12:23 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5487
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261443AbVEQNMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:12:16 -0400
Date: Tue, 17 May 2005 15:12:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: christoph <christoph@scalex86.org>, linux-mm <linux-mm@kvack.org>,
       shai@scalex86.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in node memory alignment
Message-ID: <20050517131202.GQ26073@g5.random>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw> <1116274451.1005.106.camel@localhost> <Pine.LNX.4.62.0505161240240.13692@ScMPusgw> <1116276439.1005.110.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116276439.1005.110.camel@localhost>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 01:47:19PM -0700, Dave Hansen wrote:
> Just because it complains doesn't mean that anything is actually
> wrong :)
> 
> Do you know which pieces of code actually break if the alignment doesn't
> meet what that warning says?

Be sure in early 2001 the alpha wildfire wasn't booting without having
natural alingment from the 2^order allocation, after several days of
debugging and crashing eventually I figured it out and added the printk
(it couldn't be a BUG since it was early in the boot to see it). The
kernel stack on x86 w/o 4k stacks depends on the natural alignment of
the 2^order buddy allocations for example. No idea how much other code
would break with not naturally aligned 2^order allocations.
