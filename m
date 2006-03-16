Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbWCPUjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWCPUjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWCPUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:39:24 -0500
Received: from netblock-66-159-230-160.dslextreme.com ([66.159.230.160]:56463
	"EHLO sphinx.zankel.net") by vger.kernel.org with ESMTP
	id S932724AbWCPUjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:39:23 -0500
Message-ID: <4419CCCD.8070208@zankel.net>
Date: Thu, 16 Mar 2006 12:38:37 -0800
From: Chris Zankel <chris@zankel.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: davem@davemloft.net
CC: linux-kernel@vger.kernel.org
Subject: Cache Aliasing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am stuck trying to figure out why the sparc64 implementation for cache 
aliasing actually works:

 From my understanding, any kernel (or driver) function can 
allocate/free pages with __page_alloc() / free_page(). I couldn't find 
any place, however, where the cache is flushed in either case, so there 
might be some residue in the cache.

During allocation of user pages, the sparc64 implementation might 
temporarily map that page to a cache-coherent location (TLBTEMP_BASE+x) 
for {clear|copy}_user_page. At that time, however, couldn't there  still 
be dirty lines in the other 'half' of the cache from the previous kernel 
allocation?

I'd appreciate any direction where I could find more information about 
this scenario or where I should look in the kernel code.

Thanks,
-Chris

