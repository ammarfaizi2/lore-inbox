Return-Path: <linux-kernel-owner+w=401wt.eu-S1161031AbXALH5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbXALH5n (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbXALH5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:57:42 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:38533 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161031AbXALH5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:57:41 -0500
Date: Thu, 11 Jan 2007 23:57:40 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
 <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, Linus Torvalds wrote:

> On Thu, 11 Jan 2007, Viktor wrote:
> > 
> > OK, madvise() used with mmap'ed file allows to have reads from a file
> > with zero-copy between kernel/user buffers and don't pollute cache
> > memory unnecessarily. But how about writes? How is to do zero-copy
> > writes to a file and don't pollute cache memory without using O_DIRECT?
> > Do I miss the appropriate interface?
> 
> mmap()+msync() can do that too.
> 
> Also, regular user-space page-aligned data could easily just be moved into 
> the page cache. We actually have a lot of the infrastructure for it. See 
> the "splice()" system call.

it seems to me that if splice and fadvise and related things are 
sufficient for userland to take care of things "properly" then O_DIRECT 
could be changed into splice/fadvise calls either by a library or in the 
kernel directly...

looking at the splice(2) api it seems like it'll be difficult to implement 
O_DIRECT pread/pwrite from userland using splice... so there'd need to be 
some help there.

i'm probably missing something.

-dean
