Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbTGLO7C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbTGLO7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:59:02 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52371 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265886AbTGLO7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:59:00 -0400
Date: Sat, 12 Jul 2003 16:13:43 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
Message-ID: <20030712151343.GA9483@mail.jlokier.co.uk>
References: <20030710053944.GA27038@mail.jlokier.co.uk> <16141.15245.367725.364913@charged.uio.no> <20030710150012.GA29113@mail.jlokier.co.uk> <16141.32852.39625.891724@charged.uio.no> <20030710153557.GD29113@mail.jlokier.co.uk> <16141.63602.314666.241727@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16141.63602.314666.241727@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> The first one should fix the problem of the kernel missing replies
> while we are busy trying to resend a request.

This by itself doesn't fix the problem of too-fast timeout errors on
soft mounts (e.g. returning EIO within <0.1s).

I am still seeing the fs get into a state where each time a large file
is written, it reports EIO (but writes successfully anyway).  And "ls
-R" still shows EIO errors also.

> The second, solves a problem of resource starvation. The fact that we
> can currently just submit arbitrary numbers of asynchronous requests
> means that we can exhaust resources to the point where the socket
> starts dropping replies.
> This patch limits the number of outstanding asynchronous requests to
> 16 per socket (the maximum number of xprt/transport slots).

I haven't tried this yet.  It doesn't apply to 2.5.74 due to the calls
to io_schedule().

- Jamie
