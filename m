Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946867AbWKAMzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946867AbWKAMzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbWKAMzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:55:33 -0500
Received: from mailrelay1.uni-mannheim.de ([134.155.96.50]:34978 "EHLO
	mailrelay1.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S1752089AbWKAMzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:55:32 -0500
Message-ID: <454899E9.1090900@ti.uni-mannheim.de>
Date: Wed, 01 Nov 2006 13:58:17 +0100
From: Guillermo Marcus Martinez <marcus@ti.uni-mannheim.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de> <loom.20061101T120846-320@post.gmane.org>
In-Reply-To: <loom.20061101T120846-320@post.gmane.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Offermanns schrieb:
> Guillermo Marcus <marcus <at> ti.uni-mannheim.de> writes:
>> Note: I am using kernel 2.6.9 for these tests, as it is required by my
>> current setup. Maybe this issue has already been addressed in newer
>> kernel. If that is the case, please let me know.
> 
> Have a look at this article:
> 
> "The evolution of driver page remapping"
> http://lwn.net/Articles/162860/
> 
> It should make things clearer. 
> 
> The "API changes in the 2.6 kernel series" page is also a very good read:
> http://lwn.net/Articles/2.6-kernel-api/
> 
> HTH,
> Rolf

Thanks for the links!

Yes, it looks like a step in the right direction. However, the article
says about vm_insert_page(): "...What it does require is that the page
be an order-zero allocation obtained for this purpose...", therefore
making it also unusable for this case (mmaping a pci_alloc_consistent).

I think the limitation (being order zero), is related to the page
counting, as I understand that for bigger order allocations, only the
first-page counter is incremented (not every page). If that is a
problem, I guess I would also see a problem with my workaround, and I
see none (yet). So I may try in a newer kernel and see if I can use it
to walk the pages on the mmap without using the nopage().

My suggestion would be to add two functions: pci_map_consistent() and
dma_map_coherent() to address this issue, and their corresponding
unmap's. That will make sure all that is needed is done, is a clean and
consistent with the pci_ and dma_ APIs, and fills a mmap requirement not
covered by the other functions.

Best wishes,
Guillermo

