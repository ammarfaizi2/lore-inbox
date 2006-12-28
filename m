Return-Path: <linux-kernel-owner+w=401wt.eu-S932663AbWL1Aad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWL1Aad (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWL1Aad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:30:33 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:53634 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932663AbWL1Aac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:30:32 -0500
Date: Thu, 28 Dec 2006 09:29:34 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Sanely size hash tables when using large base pages.
Message-ID: <20061228002934.GA18755@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20061226061652.GA598@linux-sh.org> <20061226074257.GA5853@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061226074257.GA5853@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2006 at 03:42:57PM +0800, Fengguang Wu wrote:
> On Tue, Dec 26, 2006 at 03:16:52PM +0900, Paul Mundt wrote:
> >  	pidhash_shift = max(4, fls(megabytes * 4));
> >  	pidhash_shift = min(12, pidhash_shift);
> >  	pidhash_size = 1 << pidhash_shift;
> >  
> > +	size = pidhash_size * sizeof(struct hlist_head);
> > +	if (unlikely(size < PAGE_SIZE)) {
> > +		size = PAGE_SIZE;
> > +		pidhash_size = size / sizeof(struct hlist_head);
> > +		pidhash_shift = 0;
> 
> But pidhash_shift is not the order of page ;-)
> 
Ah, you're right. I'll drop the pidhash changes and resubmit. Thanks.
