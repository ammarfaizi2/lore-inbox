Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265149AbUETVz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUETVz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 17:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUETVz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 17:55:26 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:8199 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265149AbUETVzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 17:55:25 -0400
Date: Thu, 20 May 2004 14:56:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Message-Id: <20040520145658.3a7bf7df.akpm@osdl.org>
In-Reply-To: <16557.4709.694265.314748@napali.hpl.hp.com>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16556.19979.951743.994128@napali.hpl.hp.com>
	<20040519234106.52b6db78.davem@redhat.com>
	<16556.65456.624986.552865@napali.hpl.hp.com>
	<20040520120645.3accf048.akpm@osdl.org>
	<16557.1651.307484.282000@napali.hpl.hp.com>
	<20040520203532.A11902@infradead.org>
	<16557.4709.694265.314748@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2004 21:54:17.0797 (UTC) FILETIME=[FFAFE750:01C43EB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Thu, 20 May 2004 20:35:32 +0100, Christoph Hellwig <hch@infradead.org> said:
> 
>   Christoph> IMHO this is exactly the wrong way around.  It should be
>   Christoph> __ARCH_WANT_* or something like that so new architectures
>   Christoph> don't carry the old garbage around by default.  There's
>   Christoph> far too many new architectures keeping old syscalls by
>   Christoph> accident.
> 
> Feel free to do that.  I was trying not to break anything and I'm
> _certain_ I would have gotten it wrong if I had reversed the sense.
> 
> I think the current patch is an improvement, so unless someone comes
> up with something better, I'd like to see it applied.

I do agree that ARCH_WANT_FOO is easier to understand and more idiomatic.

An alternative might be to remove all the ifdefs, build with
-ffunction-sections and let the linker drop any unreferenced code...
