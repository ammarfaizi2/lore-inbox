Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVAFFGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVAFFGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVAFFGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:06:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:47515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262727AbVAFFGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:06:04 -0500
Date: Wed, 5 Jan 2005 21:05:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105210539.19807337.akpm@osdl.org>
In-Reply-To: <20050106045932.GN4597@dualathlon.random>
References: <20050105134457.03aca488.akpm@osdl.org>
	<20050105203217.GB17265@logos.cnet>
	<41DC7D86.8050609@yahoo.com.au>
	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
	<20050105173624.5c3189b9.akpm@osdl.org>
	<Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
	<41DCB577.9000205@yahoo.com.au>
	<20050105202611.65eb82cf.akpm@osdl.org>
	<41DCC014.80007@yahoo.com.au>
	<20050105204706.0781d672.akpm@osdl.org>
	<20050106045932.GN4597@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> The fix is very simple and it is to call wait_on_page_writeback on one
>  of the pages under writeback.

eek, no.  That was causing waits of five seconds or more.  Fixing this
caused the single greatest improvement in page allocator latency in early
2.5.  We're totally at the mercy of the elevator algorithm this way.

If we're to improve things in there we want to wait on _any_ eligible page
becoming reclaimable, not on a particular page.
