Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUBDTof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUBDTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:44:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:55765 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264163AbUBDTo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:44:28 -0500
Subject: Re: Active Memory Defragmentation: Our implementation & problems
From: Dave Hansen <haveblue@us.ibm.com>
To: Timothy Miller <miller@techsource.com>
Cc: root@chaos.analogic.com, Alok Mooley <rangdi@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <40214A11.3060007@techsource.com>
References: <20040204185446.91810.qmail@web9705.mail.yahoo.com>
	 <Pine.LNX.4.53.0402041402310.2722@chaos>  <40214A11.3060007@techsource.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075923832.27944.391.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Feb 2004 11:43:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 11:37, Timothy Miller wrote:
> Would memory fragmentation have any appreciable impact on L2 cache line 
> collisions?
> Would defragmenting it help?

Nope.  The L2 lines are 32 or 64 bytes long, and the only unit we can
defrag in is pages which are 4k.  Since everything is aligned, a
cacheline cannot cross a page.  

> In the case of the Opteron, there is a 1M cache that is (I forget) N-way 
> set associative, and it's physically indexed.  If a bunch of pages were 
> located such that there were a disproportionately large number of lines 
> which hit the same tag, you could be thrashing the cache.
>
> There are two ways to deal with this:  (1) intelligently locates pages
> in physical memory; (2) hope that natural entropy keeps things random 
> enough that it doesn't matter.

You're talking about page coloring now.  That a whole different debate. 
I think it's been discussed here before. :)  It's good.  It's bad.  It's
good.  It's bad.  

--dave

