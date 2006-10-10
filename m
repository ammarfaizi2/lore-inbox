Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWJJSNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWJJSNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWJJSNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:13:37 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:23448 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S964912AbWJJSNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:13:36 -0400
Date: Tue, 10 Oct 2006 19:12:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Greg KH <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 07/19] invalidate_complete_page() race fix
In-Reply-To: <20061010171451.GH6339@kroah.com>
Message-ID: <Pine.LNX.4.64.0610101909450.18380@blonde.wat.veritas.com>
References: <20061010165621.394703368@quad.kroah.org> <20061010171451.GH6339@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Oct 2006 18:12:41.0939 (UTC) FILETIME=[AD5CBA30:01C6EC97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Greg KH wrote:

> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Andrew Morton <akpm@osdl.org>
> 
> If a CPU faults this page into pagetables after invalidate_mapping_pages()
> checked page_mapped(), invalidate_complete_page() will still proceed to remove
> the page from pagecache.  This leaves the page-faulting process with a
> detached page.  If it was MAP_SHARED then file data loss will ensue.
> 
> Fix that up by checking the page's refcount after taking tree_lock.

I may have lost the plot, but I think this patch has already proved
to cause problems for NFS in 2.6.18: not good to put it into 2.6.17
stable while it's awaiting refinement for 2.6.18 stable.

Hugh
