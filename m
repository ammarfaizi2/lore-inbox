Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264813AbUEUWfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbUEUWfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEUWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:35:32 -0400
Received: from zero.aec.at ([193.170.194.10]:65284 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266086AbUEUWdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:49 -0400
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
References: <1Y1yE-4Lz-7@gated-at.bofh.it> <1Y1yF-4Lz-9@gated-at.bofh.it>
	<1Y1yF-4Lz-11@gated-at.bofh.it> <1Y1yF-4Lz-13@gated-at.bofh.it>
	<1Y1yF-4Lz-15@gated-at.bofh.it> <1Y1yE-4Lz-5@gated-at.bofh.it>
	<1Y1yJ-4Lz-37@gated-at.bofh.it> <1Y2l5-5rr-5@gated-at.bofh.it>
	<1Y3Ki-6x6-35@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 21 May 2004 11:01:15 +0200
In-Reply-To: <1Y3Ki-6x6-35@gated-at.bofh.it> (Andrew Morton's message of
 "Fri, 21 May 2004 00:00:18 +0200")
Message-ID: <m3fz9uxig4.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> An alternative might be to remove all the ifdefs, build with
> -ffunction-sections and let the linker drop any unreferenced code...

I am not sure if it will handle EXPORT_SYMBOL correctly. Sometimes
we have the situation that a function is only referenced from EXPORT_SYMBOL,
but we do not want the linker to drop it because modules may use it.
(this regularly causes problems in lib-y files) 

If it did it would be great to use though. I am sure there are other
dead functions around too. Or maybe someday we could even use the 
IPA functionality in gcc 3.4 ... 

-Andi

