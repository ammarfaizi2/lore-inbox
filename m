Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUKSJql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUKSJql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbUKSJqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:46:40 -0500
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:48513 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261191AbUKSJqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:46:35 -0500
Date: Fri, 19 Nov 2004 10:46:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041119094620.GA32322@elf.ucw.cz>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <Pine.LNX.4.58.0411181047590.2222@ppc970.osdl.org> <E1CUrwu-0004Mh-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUrwu-0004Mh-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The GFP_IO and GFP_FS pages are the _real_ protectors. They don't dip into
> > the (very limited) set of pages, they say "we can still free 90% of
> > memory, we just have to ignore that dangerous 10%".
> 
> I don't see how this makes more problems to userspace filesystems.
> When you clear GFP_IO or GFP_FS for an allocation you are limiting
> yourself from freeing some sort of memory.  But that will not make it
> easier to actually _get_ that memory.
> 
> With FUSE the allocation is NOT limited.  Deadlock will not happen
> since page writeback is non-blocking, so while more FUSE backed pages
> can't be written, other filesystem's pages can be written back.  The
> situation is better not worse.
>
> What am I missing?

I believe problem is when there are no other filesystem's
pages.... and at that point FUSE is worse than kernel filesystems
because you do not have reserved pools to use for freeing memory.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
