Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUCDWOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUCDWOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:14:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48538 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261976AbUCDWOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:14:35 -0500
Date: Thu, 4 Mar 2004 17:14:30 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Peter Zaitsev <peter@mysql.com>,
       <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <20040304175821.GO4922@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403041711500.20043-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Andrea Arcangeli wrote:
> On Thu, Mar 04, 2004 at 07:12:23AM -0500, Rik van Riel wrote:

> > All the CPUs use the _same_ mm_struct in kernel space, so
> > all VM operations inside the kernel are effectively single 
> > threaded.
> 
> so what, the 3:1 has the same bottleneck too.

Not true, in the 3:1 split every process has its own
mm_struct and they all happen to share the top GB with
kernel stuff.  You can do a copy_to_user on multiple
CPUs efficiently.

> or maybe you mean the page_table_lock hold during copy-user that Andrew
> mentioned? (copy-user doesn't mean "all VM operations" not sure if you
> meant this or the usual locking of every 2.4/2.6 kernel out there)

True, there are some other operations.  However, when
you consider the fact that copy-user operations are
needed for so many things they are the big bottleneck.

Making it possible to copy things to and from userspace
in a lockless way will help performance quite a bit...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

