Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbUJ0SWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbUJ0SWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUJ0SWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:22:12 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:43022 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262528AbUJ0SIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:08:44 -0400
Date: Wed, 27 Oct 2004 19:08:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>
Subject: Re: news about IDE PIO HIGHMEM bug (was: Re: 2.6.9-mm1)
Message-ID: <20041027180816.GA32436@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>
References: <58cb370e041027074676750027@mail.gmail.com> <417FBB6D.90401@pobox.com> <1246230000.1098892359@[10.10.2.4]> <1246750000.1098892883@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246750000.1098892883@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To repeat what I said in IRC ... ;-)
> 
> Actually, you could check this with the pfns being the same when >> MAX_ORDER-1.
> We should be aligned on a MAX_ORDER boundary, I think.
> 
> However, pfn_to_page(page_to_pfn(page) + 1) might be safer. If rather slower.

I think this is the wrong level of interface exposed.  Just add two hepler
kmap_atomic_sg/kunmap_atomic_sg that gurantee to map/unmap a sg list entry,
even if it's bigger than a page.

