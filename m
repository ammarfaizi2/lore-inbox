Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTE0Uok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbTE0UoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:44:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28823 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264174AbTE0UmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:42:09 -0400
Date: Tue, 27 May 2003 22:55:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527205516.GZ845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305272032.03645.m.c.p@wolk-project.de> <20030527201028.GJ3767@dualathlon.random> <200305272224.22567.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272224.22567.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, Marc-Christian Petersen wrote:
> I try to backport BIO and then AS for quite over 2 weeks now, but it
> seems, at least for me, that it's an impossible mission ;(

You're nuts, that's not only incredibly silly it's not even needed for
what you want.

What you want is the proper io scheduler abstraction interface. With
that in place, you can port the 2.5 io schedulers without too much
trouble. They have very little dependencies on bio itself ('bio' has
become on of the most abused terms in 2.5. I use it only to describe the
io structure).

You basically need to pin down users that directly manipulate the queue
to extract/insert requests. So step one is doing elv_add_request(),
elv_next_request, and elv_remove_request(). That is a 1:1 mapping to
what 2.4 has right now, so you should be able to accomplish this change
without changing how the code works.

But still, why on earth waste your time with something like this now
when we are so close to 2.6? 2.4 is a stable code base, it should stay
that way. I'm really not interested in more esoteric 2.4 backports, the
vendor kernels are bad enough as it is.

-- 
Jens Axboe

