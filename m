Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271380AbTHOVuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271416AbTHOVu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:50:26 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:60630 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S271380AbTHOVuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:50:22 -0400
Message-ID: <3F3D558D.5050803@colorfullife.com>
Date: Fri, 15 Aug 2003 23:50:05 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] slab debug vs. L1 alignement
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben wrote:

>Currently, when enabling slab debugging, we lose the property of
>having the objects aligned on a cache line size.
>  
>
Correct. Cache line alignment is advisory. Slab debugging is not the 
only case that violates the alignment, for example 32-byte allocations 
are not padded to the 128 byte cache line size of the Pentium 4 cpus. I 
really doubt we want that.

Have you looked at pci_pool_{create,alloc,free,destroy}? The functions 
were specifically written to provide aligned buffers for DMA operations. 
Perhaps SCSI should use them?

--
    Manfred

