Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264872AbUD2V1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264872AbUD2V1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUD2V1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:27:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:24813 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264872AbUD2VZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:25:50 -0400
Date: Thu, 29 Apr 2004 14:28:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jmoyer@redhat.com, carson@taltos.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, andrea@suse.de, davem@redhat.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-Id: <20040429142807.1fa4c5ea.akpm@osdl.org>
In-Reply-To: <20040429210951.GB20453@logos.cnet>
References: <382320000.1082759593@taltos.ny.ficc.gs.com>
	<16527.4259.174536.629347@segfault.boston.redhat.com>
	<20040429210951.GB20453@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > Andrea fixed this in his tree by deferring the page free to process context
> > instead of BUG()ing on PageLRU(page).
> 
> Yeap, his fix looks OK.

It does.

It would be nice to change

	if (in_interrupt())

to

	if (in_interrupt() || ((count++ % 10000) == 0))

just to exercise that code path a bit more.

