Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUKRTba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUKRTba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbUKRTaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:30:17 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:33674 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262932AbUKRT2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:28:15 -0500
To: torvalds@osdl.org
CC: alan@lxorguk.ukuu.org.uk, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
In-reply-to: <Pine.LNX.4.58.0411181047590.2222@ppc970.osdl.org> (message from
	Linus Torvalds on Thu, 18 Nov 2004 10:55:05 -0800 (PST))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
  <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>  <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <1100798975.6018.26.camel@localhost.localdomain> <Pine.LNX.4.58.0411181047590.2222@ppc970.osdl.org>
Message-Id: <E1CUrwu-0004Mh-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 20:28:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The GFP_IO and GFP_FS pages are the _real_ protectors. They don't dip into
> the (very limited) set of pages, they say "we can still free 90% of
> memory, we just have to ignore that dangerous 10%".

I don't see how this makes more problems to userspace filesystems.
When you clear GFP_IO or GFP_FS for an allocation you are limiting
yourself from freeing some sort of memory.  But that will not make it
easier to actually _get_ that memory.

With FUSE the allocation is NOT limited.  Deadlock will not happen
since page writeback is non-blocking, so while more FUSE backed pages
can't be written, other filesystem's pages can be written back.  The
situation is better not worse.

What am I missing?

Thanks,
Miklos
