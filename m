Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUJGVn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUJGVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUJGVmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:42:03 -0400
Received: from zero.aec.at ([193.170.194.10]:33551 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268080AbUJGVlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:41:04 -0400
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: strange AMD x Intel Behaviour in 2.4.26
References: <2MLlk-5MH-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 07 Oct 2004 23:40:57 +0200
In-Reply-To: <2MLlk-5MH-5@gated-at.bofh.it> (Fabiano Ramos's message of
 "Thu, 07 Oct 2004 20:40:06 +0200")
Message-ID: <m31xga2oly.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabiano Ramos <ramos_fabiano@yahoo.com.br> writes:

>   The code is producing correct results (same as ptrace, I mean)
> but is RUNNING FASTER on a 500Mhz AMD K6-2 than on a 2.6Ghz HT
> Pentium 4 !!!!  The monitored code runs faster on P4 if not being

The Pentium 4 is slow for anything that involves changing of the 
ring or an exception. Well known problem, you can see it in other
benchmarks too. Normally the penalty is not that drastic, probably
it doesn't like single stepping very much.

However a cheaper way to do this would be to use performance counters
and save/restore them on each context switch. There is normally a
perfctr for "retired instructions on ring 3", which is what you
want. Mikael P's perfctr patchkit can do that per process.

-Andi

