Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVAGXGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVAGXGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVAGXAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:00:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:21196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261699AbVAGW7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:59:15 -0500
Date: Fri, 7 Jan 2005 15:03:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: pmarques@grupopie.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
Message-Id: <20050107150315.3c1714a4.akpm@osdl.org>
In-Reply-To: <m1d5wgrir7.fsf@clusterfs.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org>
	<41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<41DEDF87.8080809@grupopie.com>
	<m1llb5q7qs.fsf@clusterfs.com>
	<20050107132459.033adc9f.akpm@osdl.org>
	<m1d5wgrir7.fsf@clusterfs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
>
> > And the whole idea is pretty flaky really - how can one precalculate how
> > much memory an arbitrary md-on-dm-on-loop-on-md-on-NBD stack will want to
> > use?  It really would be better if we could drop the whole patch and make
> > reiser4 behave more sanely when its writepage is called with for_reclaim=1.
> 
> Reiser4 doesn't use this for ->writepage(), by the way. This is used by
> tree balancing code to assure that balancing cannot get -ENOMEM in the
> middle of tree modification, because undo is _so_ very complicated.

Oh.  And that involves performing I/O, yes?

Why does the filesystem risk going oom during the rebalance anyway?  Is it
doing atomic allocations?
