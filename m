Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVBYUb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVBYUb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 15:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVBYUb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 15:31:59 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:20743 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261330AbVBYUbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 15:31:50 -0500
Date: Fri, 25 Feb 2005 21:34:35 +0100
To: tony osborne <tonyosborne_a@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why one stack per thread and one heap for all the threads?
Message-ID: <20050225203435.GB1249@hh.idb.hist.no>
References: <BAY14-F4195FF14B317E75D3A8EAD95650@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAY14-F4195FF14B317E75D3A8EAD95650@phx.gbl>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 12:03:19PM +0000, tony osborne wrote:
> Hi,
> 
> I wish to be personally CC'ed the answers/comments posted to the list in 
> response to this post
> 
> 
> why in multithreading, each thread has its own stack, but all share the 
> same heap?
> I understand that one stack is needed for each thread as each could have 
> its own procedure call. but why we don't associate a heap for each thread 
> since each thread can also create dynamically its own data?
> 
> 
Because stack memory management is so simple - all memory above the
stack pointer is assumed to be free.  (Or below, depending
on which way the stack grows.)  You allocate more
simply by incrementing the stack pointer, and free memory by
decrementing it.  Such a structure isn�'t trivially shareable!

Heaps on the other hand, have more complex memory management.
You call into a routine, such as malloc() to reserve memory
there.  Having several threads doing so simultaneosuly is not
a problem, so there is no need for separate heaps.  Separate heaps
would waste memory, as the threads might have very different needs
for memory.  Sharing is better, when possible.

If you want separate memory for each thread, consider separate processes
instead.

Helge Hafting
