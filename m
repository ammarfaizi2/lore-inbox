Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVIURfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVIURfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIURfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:35:04 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:56028 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751298AbVIURfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:35:00 -0400
Message-ID: <433199B9.2080208@nortel.com>
Date: Wed, 21 Sep 2005 11:34:49 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: help interpreting oom-killer output
References: <43308131.5040104@nortel.com> <20050921133701.GB5532@dmt.cnet>
In-Reply-To: <20050921133701.GB5532@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 17:34:54.0947 (UTC) FILETIME=[C7813330:01C5BED2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Tue, Sep 20, 2005 at 03:37:53PM -0600, Christopher Friesen wrote:

>>oom-killer: gfp_mask=0xd0

> So this must be a DMA allocation (see gfp_mask). Stick a "dump_stack()" 
> to find out who is the allocator.

Checking in gfp.h, I see:

#define __GFP_DMA       0x01
#define __GFP_HIGHMEM   0x02
#define __GFP_WAIT      0x10    /* Can wait and reschedule? */
#define __GFP_HIGH      0x20    /* Should access emergency pools? */
#define __GFP_IO        0x40    /* Can start physical IO? */
#define __GFP_FS        0x80    /* Can call down to low-level FS? */
#define GFP_KERNEL      (__GFP_WAIT | __GFP_IO | __GFP_FS)

Thus, it looks like it's not a dma allocation.  By my reading, it 
appears to be a standard GFP_KERNEL.

Chris
