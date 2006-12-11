Return-Path: <linux-kernel-owner+w=401wt.eu-S1758878AbWLKB3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758878AbWLKB3K (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 20:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759747AbWLKB3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 20:29:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:46738 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758878AbWLKB3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 20:29:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=J9lC2KU/w/aKrAetlgtMnReUCsVH6lGPwogX0vPLesI8L842EN5Cg5HMlbJgAhb2QW21P3qaRqyVfX3oqfkfV0WbiPkceHXBXADI7RwZqyp747biCqBTCd9im+xdsGGx3CISSt6In6RNFxtA3YN17unUuvbe7Q+dwWk+jDeNzCU=
Message-ID: <457CB4A6.5090807@gmail.com>
Date: Sun, 10 Dec 2006 17:30:14 -0800
From: walt <w41ter@gmail.com>
Organization: none
User-Agent: Thunderbird 3.0a1 (X11/20061210)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.19-rc6-mm2 hangs when gdb is run on a multithread program
References: <20061211000724.GA2578@ai.larroy.com> <457CAA37.9040407@goop.org>
In-Reply-To: <457CAA37.9040407@goop.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Pedro Larroy Tovar wrote:
>> Hi
>>
>> I can reproduce a crash with 2.6.19-rc6-mm2 triggered when debugging a
>> program with gdb that uses pthreads. No oops or anything strange seems
>> to be printed by the kernel, but the box appears to stop doing disk IO.

> Hm, I wonder if this is related walt's problem running things under gdb?

Jeremy, I redid my git-bisect from scratch and came up with a different
commit for the gdb breakage:

commit f95d47caae5302a63d92be9a0292abc90e2a14e1
Author: Jeremy Fitzhardinge <jeremy@goop.org>
Date:   Thu Dec 7 02:14:02 2006 +0100
[PATCH] i386: Use %gs as the PDA base-segment in the kernel

This commit is the one which causes gdb to halt with this error
no matter what executable I try to run:
Warning:
Cannot insert breakpoint -2.
Error accessing memory address 0xd74b: Input/output error.

I tried to git-revert just this one commit, but I get merge conflicts
I don't how to resolve.

BTW, I just discovered tons of kernel debugging config options which
were turned off -- I just turned several of them on.  Maybe I can give
you better info now.
