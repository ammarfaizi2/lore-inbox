Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTDZOZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTDZOZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 10:25:04 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:34688 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261165AbTDZOZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 10:25:03 -0400
Date: Sat, 26 Apr 2003 10:37:11 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: TASK_UNMAPPED_BASE & stack location
In-Reply-To: <459930000.1051302738@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304261034180.27719-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Martin J. Bligh wrote:

> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just shove
> libraries directly above the program text? Red Hat seems to have patches to
> dynamically tune it on a per-processes basis anyway ...

What could be done is leave the stack where it is, but have
malloc() space and mmap() space grow towards each other:

0                                            3G
| |prog | malloc -->         <-- mmap | stack |

The stack will get the stack size ulimit size and the space
between where malloc and mmap start should be about 2.7 GB.

That 2.7 GB will of course by divided between malloc and mmap,
but the division will be done dynamically based on whoever
needs the space.  Much better than the current static 1:1.7
division...

