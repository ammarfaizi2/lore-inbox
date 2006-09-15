Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWIONa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWIONa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWIONa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:30:57 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:40599 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751412AbWIONa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:30:57 -0400
Date: Fri, 15 Sep 2006 14:30:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mike Waychison <mikew@google.com>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
In-Reply-To: <20060915003529.8a59c542.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609151425050.22674@blonde.wat.veritas.com>
References: <1158274508.14473.88.camel@localhost.localdomain>
 <20060915001151.75f9a71b.akpm@osdl.org> <20060915003529.8a59c542.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Sep 2006 13:30:21.0740 (UTC) FILETIME=[17E3BEC0:01C6D8CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006, Andrew Morton wrote:
> 
> This assumes that no other heavyweight process will try to modify this
> single-threaded process's mm.  I don't _think_ that happens anywhere, does
> it?  access_process_vm() is the only case I can think of,

"Modify" in the sense of fault into.
Yes, access_process_vm() is all I can think of too.

> and it does down_read(other process's mmap_sem).

If there were anything else, it'd have to do so too (if not down_write).

I too like NOPAGE_RETRY: as you've both observed, it can help to solve
several different problems.

Hugh
