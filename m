Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbUJ0Sxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbUJ0Sxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUJ0Sxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:53:40 -0400
Received: from holomorphy.com ([207.189.100.168]:8321 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262637AbUJ0StU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:49:20 -0400
Date: Wed, 27 Oct 2004 11:48:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: news about IDE PIO HIGHMEM bug
Message-ID: <20041027184836.GA12934@holomorphy.com>
References: <58cb370e041027074676750027@mail.gmail.com> <417FBB6D.90401@pobox.com> <1246230000.1098892359@[10.10.2.4]> <1246750000.1098892883@[10.10.2.4]> <20041027180816.GA32436@infradead.org> <417FEA09.6080502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FEA09.6080502@pobox.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>> I think this is the wrong level of interface exposed.  Just add two hepler
>> kmap_atomic_sg/kunmap_atomic_sg that gurantee to map/unmap a sg list entry,
>> even if it's bigger than a page.

On Wed, Oct 27, 2004 at 02:33:45PM -0400, Jeff Garzik wrote:
> Why bother mapping anything larger than a page, when none of the users 
> need it?
> P.S. In your scheme you would need four helpers; you forgot kmap_sg() 
> and kunmap_sg().

This is all a non-issue. The page structure just represents little more
than a physical address to the block layer in the context of merging,
so the pfn_to_page(page_to_pfn(...) + ...) bits calculate this properly.
There is just nothing interesting going on here. Generate the page
structure for the piece of the segment, kmap_atomic() it, and it's done.


-- wli
