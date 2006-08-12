Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWHLX3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWHLX3D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWHLX3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 19:29:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50893 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964955AbWHLX3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 19:29:02 -0400
Date: Sat, 12 Aug 2006 16:28:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-Id: <20060812162857.d85632b9.akpm@osdl.org>
In-Reply-To: <20060810110627.GM11829@suse.de>
References: <20060810110627.GM11829@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 13:06:27 +0200
Jens Axboe <axboe@suse.de> wrote:

> Ok maybe that is a little too strong, but I am indeed seeing some very
> sucky behaviour with softirqs here. The block layer uses it for doing
> request completions

I wasn't even aware that this change had been made.  I don't recall (and I
cannot locate) any mailing list discussion of it.

Maybe I missed the discussion.  But if not, this is yet another case of
significant changes getting into mainline via a git merge and sneaking
under everyone's radar.


It seems like a bad idea to me.  Any additional latency at all in disk
completion adds directly onto process waiting time - we do a _lot_ of
synchronous disk IO.

There is no mention in the changelog of any observed problems which this
patch solves.  Can we revert it please?
