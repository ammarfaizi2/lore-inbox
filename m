Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbUJ0QCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbUJ0QCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUJ0QCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:02:44 -0400
Received: from jade.aracnet.com ([216.99.193.136]:49589 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S262489AbUJ0QCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:02:11 -0400
Date: Wed, 27 Oct 2004 09:01:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>
Subject: Re: news about IDE PIO HIGHMEM bug (was: Re: 2.6.9-mm1)
Message-ID: <1246750000.1098892883@[10.10.2.4]>
In-Reply-To: <1246230000.1098892359@[10.10.2.4]>
References: <58cb370e041027074676750027@mail.gmail.com> <417FBB6D.90401@pobox.com> <1246230000.1098892359@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--"Martin J. Bligh" <mbligh@aracnet.com> wrote (on Wednesday, October 27, 2004 08:52:39 -0700):

>> Bartlomiej Zolnierkiewicz wrote:
>>> We have stuct page of the first page and a offset.
>>> We need to obtain struct page of the current page and map it.
>> 
>> 
>> Opening this question to a wider audience.
>> 
>> struct scatterlist gives us struct page*, and an offset+length pair. The struct page* is the _starting_ page of a potentially multi-page run of data.
>> 
>> The question:  how does one get struct page* for the second, and successive pages in a known-contiguous multi-page run, if one only knows the first page?
> 
> If it's a higher order allocation, just page+1 should be safe. If it just
> happens to be contig, it might cross a discontig boundary, and not obey
> that rule. Very unlikely, but possible.

To repeat what I said in IRC ... ;-)

Actually, you could check this with the pfns being the same when >> MAX_ORDER-1.
We should be aligned on a MAX_ORDER boundary, I think.

However, pfn_to_page(page_to_pfn(page) + 1) might be safer. If rather slower.

M.

