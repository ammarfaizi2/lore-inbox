Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUDBKzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUDBKzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:55:46 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:56246 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261931AbUDBKzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:55:45 -0500
Date: Fri, 2 Apr 2004 11:55:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       <vrajesh@umich.edu>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
    fix
In-Reply-To: <200404021221.15197@WOLK>
Message-ID: <Pine.LNX.4.44.0404021152030.4359-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Marc-Christian Petersen wrote:
> 
> dunno if the below is causing your trouble, but is that intentional that 
> page_cache_release(page) is called twice?

It's not pretty, but it is intentional and correct:
the first to balance the page_cache_get higher up (well commented),
the second because add_to_page_cache does a page_cache_get but
remove_from_page_cache does not do the corresponding page_cache_release.

Christoph's problems will be somewhere in Andrea's compound page changes.

Hugh

