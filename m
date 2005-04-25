Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVDYWvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVDYWvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVDYWvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:51:40 -0400
Received: from fmr19.intel.com ([134.134.136.18]:41373 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261274AbVDYWvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:51:22 -0400
From: "Bob Woodruff" <robert.j.woodruff@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Timur Tabi" <timur.tabi@ammasso.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
Cc: <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: RE: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbsimplementation
Date: Mon, 25 Apr 2005 15:51:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcVJ5zR+UqmxlNOHTZ6BgvvwWxsZngAAD5MA
In-Reply-To: <20050425153542.70197e6a.akpm@osdl.org>
Message-ID: <ORSMSX408FRaqbC8wSA00000014@orsmsx408.amr.corp.intel.com>
X-OriginalArrivalTime: 25 Apr 2005 22:51:04.0840 (UTC) FILETIME=[42E46880:01C549E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Andrew Morton wrote,
>Yes, we expect that all the pages which get_user_pages() pinned will become
>unpinned within the context of the syscall which pinned the pages.  Or
>shortly after, in the case of async I/O.

>This is because there is no file descriptor or anything else associated
>with the pages which permits the kernel to clean stuff up on unclean
>application exit.  Also there are the obvious issues with permitting
>pinning of unbounded amounts of memory.

There definitely needs to be a mechanism to prevent people from pinning
too much memory. We saw issues in the sourceforge stack and some of the
vendors stacks where we could lock memory till the system hung. 
In the sourceforge InfiniBand stack, we put in a 
check to make sure that people did not pin too much memory. 
It was sort of a crude/bruit force mechanism, but effective. I think that we
limited people from locking down more that 1/2 of kernel memory or
70 % of all memory (it was tunable with a module option) and if they
exceeded
the limit, their requests to register memory would begin to fail. 
Arlin can provide details on how we did it or people can look at the 
IBAL code for an example. 

woody



