Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUFCJnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUFCJnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 05:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUFCJnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 05:43:16 -0400
Received: from zero.aec.at ([193.170.194.10]:19975 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261984AbUFCJnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 05:43:14 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
 2.6.7-rc2-bk2
References: <22L0f-5Ci-11@gated-at.bofh.it> <22O7J-8dw-11@gated-at.bofh.it>
	<22Wf4-5Xv-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 03 Jun 2004 11:43:10 +0200
In-Reply-To: <22Wf4-5Xv-23@gated-at.bofh.it> (Ingo Molnar's message of "Thu,
 03 Jun 2004 11:00:14 +0200")
Message-ID: <m3ise9564x.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>> You want to replace the arch-specific module_alloc() function for
>> this. Or even better, reset the NX bit only on executable sections (in
>> the arch-specific module_finalize(), using mod->core_text_size and
>> mod->init_text_size).  No generic changes necessary.
>
> this reminds me of another issue: x86_64 currently seems to manually map
> the whole module via PAGE_KERNEL_EXEC. Andi, we could change it to use
> vmalloc_exec(), right?

Nope, the manual map is needed. On x86-64 kernels are linked in the
"kernel" code model and the modules must be within 2GB of the main
kernel text.  vmalloc space is elsewhere.

To fix this you would need to link the modules with -fPIC and 
add a full dynamic linker to the module loader, which would
probably not be worth the effort.

-Andi

