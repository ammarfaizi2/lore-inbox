Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbULUOkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbULUOkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 09:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbULUOke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 09:40:34 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:45711 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261763AbULUOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 09:40:30 -0500
Date: Tue, 21 Dec 2004 15:39:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: James Pearson <james-p@moving-picture.com>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041221143954.GK2143@dualathlon.random>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org> <20041220192046.GM4630@dualathlon.random> <41C80A04.9070504@moving-picture.com> <20041221132255.GI2143@dualathlon.random> <41C82C2A.9060301@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C82C2A.9060301@moving-picture.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 01:59:06PM +0000, James Pearson wrote:
> I've changed the value of vm_mapped_ratio to 20 - which has a default 
> value of 100 - I guess you're talking about vm_cache_scan_ratio?

yes, I was talking about vm_cache_scan_ratio, you can combine the two
sysctl together just fine.

> I've tried changing just vm_cache_scan_ratio to 20, but it doesn't seem 
> to make any difference - I though a higher vm_cache_scan_ratio value 
> meant less is scanned?

The less pages are scanned, the more likely you won't free enough
pagecache, the more likely you'll shrink dcache/icache.

I see why vm_mapped_ratio makes most of the difference though and
probably it's the easier fix for your problem (though increasing
vm_cache_scan_ratio sure won't make things worse).
