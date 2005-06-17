Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVFQEVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVFQEVC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 00:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVFQEVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 00:21:02 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15176
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261911AbVFQEU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 00:20:58 -0400
Date: Fri, 17 Jun 2005 06:20:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mason@suse.de
Subject: Re: [patch] vm early reclaim orphaned pages
Message-ID: <20050617042046.GR9664@g5.random>
References: <1118978590.5261.4.camel@npiggin-nld.site> <20050616203446.796473a7.akpm@osdl.org> <1118979750.5261.12.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118979750.5261.12.camel@npiggin-nld.site>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Fri, Jun 17, 2005 at 01:42:29PM +1000, Nick Piggin wrote:
> Yeah that is a problem I was worried about. Perhaps just stripping
> PageReferenced and putting it on the *front* of the inactive list
> would be better?

I thought about putting in font instead of the tail too.

But then I also thought this after all is truncate that will literally
free some ram, and in turn it'll delay the VM shrinking a bit (i.e.
kswapd will stop shortly after truncate started). Plus there's no reason
to assume kswapd was running when truncate was invoked.

So overall I think the basic idea is to move it in the inactive list and
to strip the referenced bit, either at the head or tail probably doesn't
make much difference, they have opposite pros/cons.

The front sounds conceptually safer even if tail probably works better
in practice.

> Will do. Thanks.

Thanks!
