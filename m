Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbUKXQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbUKXQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbUKXQzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:55:46 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262668AbUKXQxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:53:10 -0500
Date: Wed, 24 Nov 2004 16:41:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: akpm@osdl.org, <nanhai.zou@intel.com>, <chrisw@osdl.org>,
       <torvalds@osdl.org>, <tony.luck@intel.com>, <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
In-Reply-To: <20041124152250.GA4797@mschwid3.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44.0411241631310.5118-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Martin Schwidefsky wrote:
> 
> In principle the patch is fine (it works and fixes a problem).
> 
> I tried to find out why s390 needs its own setup_arg_pages32 function.
> After I've compared the function with the common setup_arg_pages several
> times and still couldn't find a reason for it I just removed the function.
> Still works fine. I think the reason to introduce setup_arg_pages32 has
> been the STACK_TOP define which needs to reflect the smaller address
> space for 31 bit programs. Since the change that made TASK_SIZE look
> at the TIF_31BIT bit to return the correct value for 31 and 64 bit
> programs STACK_TOP is just correct as well. 
> 
> In short, just remove setup_arg_pages32.

Tell me I'm being silly, Martin, but wouldn't it be wiser to stick with
setup_arg_pages32 (with Nanhai's patch) for 2.6.10, then remove it after?

I'm cautious here because about six months ago I sent Andrew a patch
which eliminated setup_arg_pages32 (or equiv) from the three arches,
but the x86_64 one just wouldn't boot on Andrew's machine.  Both hch
and I spent hours staring at the code, neither of us could work out why.

Now, s390 may be greatly superior ;) but all the setup_arg_pages32
redefining is twisty weird stuff - good to be rid of it, but right now?

Hugh

