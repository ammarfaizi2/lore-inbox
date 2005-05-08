Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVEHPPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVEHPPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVEHPPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 11:15:46 -0400
Received: from one.firstfloor.org ([213.235.205.2]:25065 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262880AbVEHPPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 11:15:40 -0400
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	<1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra>
	<1115483506.12131.33.camel@cobra> <m1ekchvmb0.fsf@muc.de>
	<1115570102.10373.23.camel@cobra>
From: Andi Kleen <ak@muc.de>
Date: Sun, 08 May 2005 17:15:36 +0200
In-Reply-To: <1115570102.10373.23.camel@cobra> (Antoine Martin's message of
 "Sun, 08 May 2005 17:35:02 +0100")
Message-ID: <m1acn5vjdz.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antoine Martin <antoine@nagafix.co.uk> writes:

>> (..)
>> That is a wrmsr to 0x00000000c0000102 (KERNEL_GS_BASE), the code 
>> is trying to write 0x0000c8e816000002 into it. That is a non canonical
>> address, which causes the GPF.
>> 
>> The strange thing is that the kernel should have rejected it in
>> the first place. The code to allow user space to set kernel gs 
>> checks for the address being > TASK_SIZE and TASK_SIZE is 0x800000000000.
>> It should have rejected it in the first place.
>> 
>> Are you sure you did not apply any strange UML related patches
>> to the host kernel? Maybe those are buggy.
> The only extra patch applied on top of what is on the web page (as per
> Jeff's instructions) is the mconsole-exec patch, and AFAIK it wouldn't
> affect the code above.
>
> Alexander Nyberg is also experiencing crashes, aren't you?


Ok, the bug is found now. It is a kernel bug that it allows to set
non canonical addresses in 64bit segment registers through ptrace.

But even if I fixed that then it will not help you run UML, because
UML needs to set correct addresses of course, not illegal ones.

I will submit a patch later for the crash problem.

-Andi
