Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbTI3AvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbTI3AvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:51:14 -0400
Received: from dyn-ctb-210-9-243-176.webone.com.au ([210.9.243.176]:27140 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263090AbTI3AvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:51:12 -0400
Message-ID: <3F78D371.7050603@cyberone.com.au>
Date: Tue, 30 Sep 2003 10:50:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
References: <20030929125629.GA1746@averell> <bla6lf$3ul$1@gatekeeper.tmr.com>
In-Reply-To: <bla6lf$3ul$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <20030929125629.GA1746@averell>, Andi Kleen  <ak@muc.de> wrote:
>
>| It removes the previous dumb in kernel workaround for this and shrinks the 
>| kernel by >10k.
>| 
>| Small behaviour change is that a SIGBUS fault for a *_user access will
>| cause an EFAULT now, no SIGBUS.
>| 
>| This version addresses all criticism that I got for previous versions.
>| 
>| - Only checks on AMD K7+ CPUs. 
>| - Computes linear address for VM86 mode or code segments
>| with non zero base.
>| - Some cleanup
>| - No pointer comparisons
>| - More comments
>
>I have to try this on a P4 and K7, but WRT "Only checks on AMD K7+ CPUs"
>I hope you meant "only generates code if AMD CPU is target" and not that
>the code size penalty is still there for CPUs which don't need it.
>
>Will check Wednesday, life is very busy right now.
>

No, the code is not conditionally compiled. That is a different issue to
this patch though. The target CPU selection scheme doesn't work at all
like you would expect and its impossible to compile this sort of code
out (when on x86 arch). See Adrian's code to rationalise cpu selection.

