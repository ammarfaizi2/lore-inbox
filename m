Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTDZOvi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTDZOvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 10:51:38 -0400
Received: from holomorphy.com ([66.224.33.161]:22968 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261339AbTDZOvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 10:51:37 -0400
Date: Sat, 26 Apr 2003 08:03:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <20030426150345.GV8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mm mailing list <linux-mm@kvack.org>,
	Andrew Morton <akpm@digeo.com>
References: <459930000.1051302738@[10.10.2.4]> <Pine.LNX.4.44.0304261034180.27719-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304261034180.27719-100000@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Martin J. Bligh wrote:
>> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just shove
>> libraries directly above the program text? Red Hat seems to have patches to
>> dynamically tune it on a per-processes basis anyway ...

On Sat, Apr 26, 2003 at 10:37:11AM -0400, Rik van Riel wrote:
> What could be done is leave the stack where it is, but have
> malloc() space and mmap() space grow towards each other:
> 0                                            3G
> | |prog | malloc -->         <-- mmap | stack |
> The stack will get the stack size ulimit size and the space
> between where malloc and mmap start should be about 2.7 GB.
> That 2.7 GB will of course by divided between malloc and mmap,
> but the division will be done dynamically based on whoever
> needs the space.  Much better than the current static 1:1.7
> division...

My internal proposals (backed by code) already include this in addition
to relocating the stack (whose kernel side is trivial).


-- wli
