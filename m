Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUJ0Pyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUJ0Pyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUJ0PxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:53:23 -0400
Received: from jade.aracnet.com ([216.99.193.136]:46759 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S262488AbUJ0PxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:53:09 -0400
Date: Wed, 27 Oct 2004 08:52:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>
Subject: Re: news about IDE PIO HIGHMEM bug (was: Re: 2.6.9-mm1)
Message-ID: <1246230000.1098892359@[10.10.2.4]>
In-Reply-To: <417FBB6D.90401@pobox.com>
References: <58cb370e041027074676750027@mail.gmail.com> <417FBB6D.90401@pobox.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bartlomiej Zolnierkiewicz wrote:
>> We have stuct page of the first page and a offset.
>> We need to obtain struct page of the current page and map it.
> 
> 
> Opening this question to a wider audience.
> 
> struct scatterlist gives us struct page*, and an offset+length pair. The struct page* is the _starting_ page of a potentially multi-page run of data.
> 
> The question:  how does one get struct page* for the second, and successive pages in a known-contiguous multi-page run, if one only knows the first page?

If it's a higher order allocation, just page+1 should be safe. If it just
happens to be contig, it might cross a discontig boundary, and not obey
that rule. Very unlikely, but possible.

M.

