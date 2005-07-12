Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVGLOkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVGLOkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVGLOiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:38:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58065 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261453AbVGLOgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:36:22 -0400
Date: Tue, 12 Jul 2005 15:36:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] s390: fadvise hint values.
Message-ID: <20050712143620.GA4880@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050712115219.GA28991@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712115219.GA28991@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 01:52:19PM +0200, Martin Schwidefsky wrote:
> Hi Andrew,
> an ugly one. The fadvise hint values for POSIX_FADV_DONTNEED and
> POSIX_FADV_NOREUSE in the kernel and the glibc differ for s390-64
> (and worse the values for s390-31 and s390-64 differ as well ..).
> The glibc always had 6 and 7 instead of 4 and 5 for these two values
> for s390-64. My first reaction was to correct the values in the
> glibc headers but as Ulrich Drepper pointed out that has some
> unwanted consequences:
> 1) the applications build against the wrong values will get -EINVAL
>    and the advice gets ignored, and
> 2) if the values 6 and 7 are ever used for some new advice then
>    these applications might show erratic behaviour.
> I can't say which and how many applications use fadvise so it might
> be a better idea to fix this in the kernel.
> 
> Patch is attached, what do you think ?

I'd rather fix the kernel and do some symbol versioning magic in
glibc.  After all it's their stupidity that caused all these problems.

