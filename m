Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbTCQOvd>; Mon, 17 Mar 2003 09:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261720AbTCQOvd>; Mon, 17 Mar 2003 09:51:33 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:18324 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id <S261719AbTCQOvc>; Mon, 17 Mar 2003 09:51:32 -0500
Date: Mon, 17 Mar 2003 10:02:21 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Paul Albrecht <palbrecht@uswest.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
In-Reply-To: <002401c2eb78$cca714e0$d5bb0243@oemcomputer>
Message-ID: <Pine.LNX.4.44.0303171001030.2571-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, Paul Albrecht wrote:

> ... Why does the kernel page fault on text pages, present in the page
> cache, when a program starts? Couldn't the pte's for text present in the
> page cache be resolved when they're mapped to memory?

The mmap() syscall only sets up the VMA info, it doesn't
fill in the page tables. That only happens when the process
page faults.

Note that filling in a bunch of page table entries mapping
already present pagecache pages at exec() time might be a
good idea.  It's just that nobody has gotten around to that
yet...

