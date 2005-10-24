Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVJXDKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVJXDKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 23:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVJXDKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 23:10:33 -0400
Received: from silver.veritas.com ([143.127.12.111]:14429 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750851AbVJXDKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 23:10:33 -0400
Date: Mon, 24 Oct 2005 04:09:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
In-Reply-To: <20051023142712.6c736dd3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510240403090.22131@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
 <20051023142712.6c736dd3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 03:10:32.0697 (UTC) FILETIME=[7ED39E90:01C5D848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >  preprocessor compare that with NR_CPUS.  But I don't think it's worth
> >  being user-configurable: for good testing of both split and unsplit
> >  configs, split now at 4 cpus, and perhaps change that to 8 later.
> 
> I'll make it >= 2 for -mm.

The trouble with >= 2 is that it then leaves the unsplit page_table_lock
path untested, since UP isn't using page_table_lock at all.  While it's
true that the unsplit page_table_lock path has had a long history of
testing, it's not inconceivable that I could have screwed it up.

With the default at 4, I think we've got quite good coverage between
those who configure NR_CPUS down to the 2 they actually have,
and those who leave it at its default or actually have 4.

Hugh
