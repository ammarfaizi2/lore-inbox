Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751997AbWCHBVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbWCHBVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWCHBVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:21:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751997AbWCHBVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:21:24 -0500
Date: Tue, 7 Mar 2006 17:23:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
Message-Id: <20060307172337.1d97cd80.akpm@osdl.org>
In-Reply-To: <200603081212.03223.kernel@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	<200603081151.13942.kernel@kolivas.org>
	<20060307171134.59288092.akpm@osdl.org>
	<200603081212.03223.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> > but, but.  If prefetching is prefetching stuff which that game will soon
> > use then it'll be an aggregate improvement.  If prefetch is prefetching
> > stuff which that game _won't_ use then prefetch is busted.  Using yield()
> > to artificially cripple kprefetchd is a rather sad workaround isn't it?
> 
> It's not the stuff that it prefetches that's the problem; it's the disk 
> access.

But the prefetch code tries to avoid prefetching when the disk is otherwise
busy (or it should - we discussed that a bit a while ago).

Sorry, I'm not trying to be awkward here - I think that nobbling prefetch
when there's a lot of CPU activity is just the wrong thing to do and it'll
harm other workloads.
