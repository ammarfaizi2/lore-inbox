Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUEJSt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUEJSt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUEJSt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:49:58 -0400
Received: from zero.aec.at ([193.170.194.10]:1039 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261206AbUEJSt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:49:56 -0400
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace in 2.6.5
References: <1UlcA-6lq-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 10 May 2004 20:49:39 +0200
In-Reply-To: <1UlcA-6lq-9@gated-at.bofh.it> (Fabiano Ramos's message of
 "Mon, 10 May 2004 17:50:08 +0200")
Message-ID: <m365b4kth8.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabiano Ramos <ramos_fabiano@yahoo.com.br> writes:

> Hi All.
>
>      Is ptrace(), in singlestep mode, required to stop after a int 0x80?
>     When tracing a sequence like
>
> 	mov ...
> 	int 0x80
> 	mov ....
>
>     ptrace would notify the tracer after the two movs, but not after the
> int 0x80. I want to know if it is a bug or the expected behaviour.

What happens is that after the int 0x80 the CPU is in ring 0 (you
don't get an trace event in that mode unless you use a kernel debugger). 
Then when the kernel returns the last instruction executed before it is an 
IRET. But the IRET is also executed still in ring 0 and you should not get 
an event for it (you can not even access its code from user space).

So it's expected behaviour.

-Andi

