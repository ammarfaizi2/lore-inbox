Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUA3Rrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUA3Rrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:47:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:58666 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261931AbUA3Rre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:47:34 -0500
Date: Fri, 30 Jan 2004 17:47:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs sparse file failure in glibc "make check"
In-Reply-To: <401A8F68.60904@backtobasicsmgmt.com>
Message-ID: <Pine.LNX.4.44.0401301724030.1542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Kevin P. Fleming wrote:
> 
> No problem, as I said I have a workaround that causes me no pain. It 
> seems that the use of tmpfs for both a traditional filesystem _and_ 
> shmem is what's the root of this problem, what is the real advantage of 
> both functions being performed by the same code?

Fair suggestion, but I don't actually agree that is the root of it.

The (peculiar but predating Linux) semantics of mmap shared writable
on /dev/zero demands that we have something very like a filesystem
handling something very like shared memory: from there on it makes
a lot of sense to have the same code supporting all this.

My accusing finger points in different directions at different moments,
one reason I want to mull it over.  I might say the problem is that
tmpfs struggles to save memory by combining two otherwise distinct
layers (mapping pages and backingstore pages), and many difficulties
spring from that (all the swap/file swizzling).  I might say the
problem is that the non-overcommit memory stuff is just too simplistic.
I might say the problem is that mmap of a sparse file is ill-defined
when the backingstore fills up.

Hugh

