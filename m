Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbTJJPdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTJJPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:33:47 -0400
Received: from ns.suse.de ([195.135.220.2]:65253 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262917AbTJJPdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:33:44 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 1339] New: sleeping function called from invalid	context
References: <200010000.1065798616@[10.10.2.4].suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Oct 2003 17:33:40 +0200
In-Reply-To: <200010000.1065798616@[10.10.2.4].suse.lists.linux.kernel>
Message-ID: <p734qyhxg2z.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:
> 
> Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
> in_atomic():0, irqs_disabled():1
> Call Trace:
>  [<c011bd58>] __might_sleep+0x88/0x90
>  [<c010c55f>] save_v86_state+0x6f/0x1f0

Old bug. We already discussed it some time ago, but didn't get to a conclusion.

It's really the might_sleep that is buggy here.

>  [<c010d017>] handle_vm86_fault+0xb7/0xa10
>  [<c0141e21>] do_no_page+0x191/0x2f0
>  [<c0140fc6>] zeromap_pte_range+0x36/0x70
>  [<c010b070>] do_general_protection+0x0/0xa0
>  [<c010a399>] error_code+0x2d/0x38
>  [<c010a1ef>] syscall_call+0x7/0xb
>
> I don't have a method to reproduce - this just appeared in the log.

Run dosemu.

-Andi
