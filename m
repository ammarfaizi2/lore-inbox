Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUIHN0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUIHN0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUIHNGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:06:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15243 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267597AbUIHNE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:04:27 -0400
Date: Wed, 8 Sep 2004 15:05:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908130552.GC20132@elte.hu>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908134903.A31498@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908134903.A31498@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > wrt. unused generic functions - why dont we drop them link-time?
> 
> make explicit what you can do easily instead of relying on the
> compiler. It allows to get rid of your horrible generic_ hacks, cuts
> down compile time and makes explicit to anyone looking at the code and
> Kconfig which architectures use this.

i disagree. It's the same as the VFS model: we have generic_block_bmap()
which a filesystem might or might not make use of. It's still around
even if no filesystem makes use of it but do we care? I'd prefer fixing
our linking logic to get rid of unused functions than complicating code
and the architecture with conditionals.

is there any architecture that cannot make use of kernel/hardirq.c _at
all_?

	Ingo
