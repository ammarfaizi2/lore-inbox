Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUJEXe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUJEXe2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUJEXeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:34:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:55736 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266183AbUJEXbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:31:23 -0400
Message-ID: <41632E89.5020308@sgi.com>
Date: Tue, 05 Oct 2004 18:30:17 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <200410042157.i94Lv7UC104750@fsgi900.americas.sgi.com> <20041005164842.A19754@infradead.org>
In-Reply-To: <20041005164842.A19754@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> This looks pretty nice already, but a few small but important issues
> need sorting out.
> 
>  - The interface between pci_dma.c and the lowlevel code is still wrong -
>    and because of the additional 32bit direct translation in this code drop
>    it got even worse because you might be calling into a function just to
>    error out again.
>    Please implement my suggestions from month ago, it's not a lot of work.
>  - various sall baclls take bus_number and devfs but no pci domain, while
>    the normal SAL calls do, I think you should make the kernel code aware
>    of pci domains so the prom can introduce them seamlessly
>  - is doing SAL calls from irq context really safe?  Also why do you need
>    different SAL calls for shub vs ice error?  The prom should be easily
>    able to find out what hub a given nasid corresponds to.
>  - the patch reformats various unrelated or only slightly related files.
>    Please don't do that - in general the new style is better than the old
>    one, but it doesn't belong in this patchA
>  - there's a SNDRV_SHUB_GET_IOCTL_VERSION ioctl define added but never
>    used.  In fact it looks like all SNDRV_SHUB_ values are unused now?
> 

Christoph,

Thanks for the review. We're working on spinning up a new version with these changes.

Also the issue of where to put sn_pci_set_vchan().... I had originally put it in 
include/asm-ia64/sn/io.h, but then this file doesn't get picked up for generic and others...

So I'm looking for some guidance... almost seems like putting it in qla1280.c is the most obvious - 
since it is only used there and then there isn't include file fooling around to do.

-- Pat
