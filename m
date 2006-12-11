Return-Path: <linux-kernel-owner+w=401wt.eu-S1761865AbWLKBpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761865AbWLKBpe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 20:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761780AbWLKBpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 20:45:34 -0500
Received: from gw.goop.org ([64.81.55.164]:58576 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761866AbWLKBpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 20:45:33 -0500
Message-ID: <457CB83C.5060107@goop.org>
Date: Sun, 10 Dec 2006 17:45:32 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: walt <w41ter@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.19-rc6-mm2 hangs when gdb is run on a multithread program
References: <20061211000724.GA2578@ai.larroy.com> <457CAA37.9040407@goop.org> <457CB4A6.5090807@gmail.com>
In-Reply-To: <457CB4A6.5090807@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Jeremy Fitzhardinge wrote:
>   
>> Pedro Larroy Tovar wrote:
>>     
>>> Hi
>>>
>>> I can reproduce a crash with 2.6.19-rc6-mm2 triggered when debugging a
>>> program with gdb that uses pthreads. No oops or anything strange seems
>>> to be printed by the kernel, but the box appears to stop doing disk IO.
>>>       
>
>   
>> Hm, I wonder if this is related walt's problem running things under gdb?
>>     
>
> Jeremy, I redid my git-bisect from scratch and came up with a different
> commit for the gdb breakage:
>
> commit f95d47caae5302a63d92be9a0292abc90e2a14e1
> Author: Jeremy Fitzhardinge <jeremy@goop.org>
> Date:   Thu Dec 7 02:14:02 2006 +0100
> [PATCH] i386: Use %gs as the PDA base-segment in the kernel
>
> This commit is the one which causes gdb to halt with this error
> no matter what executable I try to run:
> Warning:
> Cannot insert breakpoint -2.
> Error accessing memory address 0xd74b: Input/output error.
>
> I tried to git-revert just this one commit, but I get merge conflicts
> I don't how to resolve.
>
> BTW, I just discovered tons of kernel debugging config options which
> were turned off -- I just turned several of them on.  Maybe I can give
> you better info now.
>   

OK, this is the changeset I'd expect to cause problems.  I'll try to
repo it here.

    J

