Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbVKCQwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVKCQwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbVKCQwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:52:20 -0500
Received: from dvhart.com ([64.146.134.43]:9390 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030375AbVKCQwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:52:19 -0500
Date: Thu, 03 Nov 2005 08:52:20 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>, Mel Gorman <mel@csn.ul.ie>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <309420000.1131036740@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>  <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>  <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>  <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>  <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>  <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org> <Pine.LNX.4.58.0511031613560.3571@skynet>
 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only way to support big areas is to have special zones for them.
> 
> (Then, we may be able to use the special zones for small things too, but 
> under special rules, like "only used for anonymous mappings" where we 
> can just always remove them by paging them out. But it would still be a 
> special area meant for big pages, just temporarily "on loan").

The problem is how these zones get resized. Can we hotplug memory between 
them, with some sparsemem like indirection layer?

Real customers have shown us that their workloads shift, and they have
different needs at different parts of the day. We can't just pick one
size and call it good. It's the same argument as the traditional VM
balancing act between pagecache, user pages, and kernel pages (which 
incidentally, we don't use zones for). We want the system to be able
to use memory wherever it's most needed.

M.

