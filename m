Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVKVMeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVKVMeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 07:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKVMeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 07:34:17 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:47590 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964928AbVKVMeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 07:34:16 -0500
Date: Tue, 22 Nov 2005 20:39:43 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] properly account readahead file major faults
Message-ID: <20051122123943.GA4856@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>, akpm@osdl.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20051121140038.GA27349@logos.cnet> <20051122042443.GA4588@mail.ustc.edu.cn> <20051122062321.GA30413@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122062321.GA30413@logos.cnet>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 04:23:21AM -0200, Marcelo Tosatti wrote:
> > With the current accounting logic:
> > - major faults reflect the times one has to wait for real I/O.
> > - the more success read-ahead, the less major faults.
> > - anyway, major+minor faults remain the same for the same benchmark.
> > 
> > With your patch:
> > - major faults are expected to remain the same with whatever read-ahead.
> > - but what's the new meaning of minor faults?
> 
> With the patch minor faults are only those faults which can be serviced
> by the pagecache, requiring no I/O.
> 
> Pages which hit the first time in cache due to readahead _have_ caused
> IO, and as such they should be counted as major faults.

Thanks, so you are changing the semantics. It may be a good idea, though I have
no idea which is more valuable for the people, or whether this change is ok for
the majority, or if it makes linux in line with other UNIX behaviors. Sorry, I
cannot comment on this.

> I suppose that if you want to count readahead hits it should be done
> separately (which is now "sort of" available with the "majflt" field).

Sure. It is hard to collect the exact readahead hit values, for the pages from
active list and pages newly allocated are not distinguishable. But I do manage
to collect the short term values for each readahead, which are sufficient most
of the time.

Regards,
Wu
