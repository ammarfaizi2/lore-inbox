Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUFXPvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUFXPvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbUFXPvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:51:09 -0400
Received: from mproxy.gmail.com ([216.239.56.242]:44505 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265766AbUFXPtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:49:13 -0400
Message-ID: <8783be6604062408493cacc648@mail.gmail.com>
Date: Thu, 24 Jun 2004 08:49:09 -0700
From: Ross Biro <ross.biro@gmail.com>
To: David Ashley <dash@xdr.com>
Subject: Re: Cached memory never gets released
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406241448.i5OEmK60025648@xdr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200406241448.i5OEmK60025648@xdr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004 07:48:20 -0700, David Ashley <dash@xdr.com> wrote:

> So we're snowballing but I don't know what mechanism is supposed to actually
> free the cached pages when the system is low on memory. Any advice would
> be welcome.
> 

You may want to examine /proc/meminfo, /proc/slabinfo, and the output
of sysrq-m.

mm/vmscan.c (kswapd) is responsible for freeing most memory.  The
routine you are probably most interested in is shrink_cache.

I would check to make sure that the pages in the icache are backed by
a mapping and if so, that they are clean.   If either of those two
conditions are not met, then the page cannot be thrown away.
