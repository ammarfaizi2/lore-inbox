Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUDSVxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUDSVxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUDSVxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:53:05 -0400
Received: from zero.aec.at ([193.170.194.10]:27915 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261907AbUDSVxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:53:03 -0400
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: task switching at Page Faults
References: <1MN62-7wz-5@gated-at.bofh.it> <1MNpu-7QI-35@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 19 Apr 2004 23:52:48 +0200
In-Reply-To: <1MNpu-7QI-35@gated-at.bofh.it> (Fabiano Ramos's message of
 "Mon, 19 Apr 2004 22:20:16 +0200")
Message-ID: <m3zn97tz2n.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabiano Ramos <ramos_fabiano@yahoo.com.br> writes:
> kernel", about 2.4, and the authors: 
>     1)assure that there is no process switch during
> the execution of an eception handler (aka syscall).
> they emphasize it.

They're wrong. First the system call or exception can
block and then when kernel code returns to user space
it always checks if the time slice hasn't expired.

>     2) say that the execption handler may not generate
> exceptions, except for page faults.

That's also incorrect. e.g. it can generate GPFs
(e.g. when trying to load a segment register supplied
by the user and it is not correct)
and a few other exceptions in extreme cases. Usually
these exceptions are handled without sleeping though.

-Andi

