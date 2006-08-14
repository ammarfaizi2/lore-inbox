Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWHNFFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWHNFFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 01:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWHNFFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 01:05:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751850AbWHNFFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 01:05:40 -0400
Date: Sun, 13 Aug 2006 21:58:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       riel@redhat.com, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-Id: <20060813215853.0ed0e973.akpm@osdl.org>
In-Reply-To: <1155530453.5696.98.camel@twins>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 06:40:53 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Testcase:
> 
> Mount an NBD device as sole swap device and mmap > physical RAM, then
> loop through touching pages only once.

Fix: don't try to swap over the network.  Yes, there may be some scenarios
where people have no local storage, but it's reasonable to expect anyone
who is using Linux as an "enterprise storage platform" to stick a local
disk on the thing for swap.

That leaves MAP_SHARED, but mm-tracking-shared-dirty-pages.patch will fix
that, will it not?
