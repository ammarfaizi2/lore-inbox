Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUHaJrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUHaJrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHaJrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:47:21 -0400
Received: from ozlabs.org ([203.10.76.45]:29131 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267595AbUHaJrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:47:20 -0400
Date: Tue, 31 Aug 2004 19:43:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-ID: <20040831094348.GH26072@krispykreme>
References: <20040830204332.24da5615.akpm@osdl.org> <200408310411.i7V4B8Vs027772@magilla.sf.frob.com> <20040831102902.A19619@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831102902.A19619@infradead.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just about every architecture hasa line
> 
> +	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)  ? 0x80 : 0));
> 
> you probably want a one-liner inline wrapper with a descriptive name
> around this

Yep, and it looks like only some architectures got this recent change:

        ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
                                 !test_thread_flag(TIF_SINGLESTEP) ?  0x80 : 0));

Is there a reason this shouldnt be propogated to all architectures?

Anton
