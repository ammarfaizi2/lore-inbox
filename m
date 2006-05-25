Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWEYWd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWEYWd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbWEYWd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:33:26 -0400
Received: from ozlabs.org ([203.10.76.45]:43149 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030490AbWEYWdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:33:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17526.12463.412158.700850@cargo.ozlabs.ibm.com>
Date: Fri, 26 May 2006 08:33:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/33] readahead: refactor __do_page_cache_readahead()
In-Reply-To: <20060525093039.21b4246b.akpm@osdl.org>
References: <20060524111246.420010595@localhost.localdomain>
	<348469538.91213@ustc.edu.cn>
	<20060525093039.21b4246b.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> > @@ -302,6 +303,8 @@ __do_page_cache_readahead(struct address
> >  			break;
> >  		page->index = page_offset;
> >  		list_add(&page->lru, &page_pool);
> > +		if (page_idx == nr_to_read - lookahead_size)
> > +			__SetPageReadahead(page);
> >  		ret++;
> >  	}
> 
> OK.  But the __SetPageFoo() things still give me the creeps.

I just hope that Wu Fengguang, or whoever is making these patches,
realizes that on some architectures, doing __set_bit on one CPU
concurrently with another CPU doing set_bit on a different bit in the
same word can result in the second CPU's update getting lost...

Paul.
