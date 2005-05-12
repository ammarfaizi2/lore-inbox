Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVELV1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVELV1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVELV0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:26:54 -0400
Received: from iabervon.org ([66.92.72.58]:43013 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262130AbVELVYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:24:54 -0400
Date: Thu, 12 May 2005 17:24:27 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Matt Mackall <mpm@selenic.com>
cc: Petr Baudis <pasky@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org, mercurial@selenic.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4e vs git network pull
In-Reply-To: <20050512205735.GE5914@waste.org>
Message-ID: <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Matt Mackall wrote:

> Does this need an HTTP request (and round trip) per object? It appears
> to. That's 2200 requests/round trips for my 800 patch benchmark.

It requires a request per object, but it should be possible (with
somewhat more complicated code) to overlap them such that it doesn't
require a serial round trip for each. Since the server is sending static
files, the overhead for each should be minimal.

> How does git find the outstanding changesets?

In the present mainline, you first have to find the head commit you
want. I have a patch which does this for you over the same
connection. Starting from that point, it tracks reachability on the
receiving end, and requests anything it doesn't have.

For the case of having nothing to do, it should be a single one-line
request/response for a static file (after which the local end determines
that it has everything it needs without talking to the server).

	-Daniel
*This .sig left intentionally blank*

