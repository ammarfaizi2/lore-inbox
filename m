Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266146AbUGEQRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUGEQRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUGEQRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 12:17:33 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:31210 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266146AbUGEQRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 12:17:31 -0400
Message-ID: <40E97F14.2060706@nortelnetworks.com>
Date: Mon, 05 Jul 2004 12:17:24 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Benjamin Collar <benjamin.collar@siemens.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: using _syscall4 to call sys_futex with -fPIC won't compile
References: <je1xjqigxr.fsf@sykes.suse.de>
In-Reply-To: <je1xjqigxr.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Benjamin Collar <benjamin.collar@siemens.com> writes:
> 
>  > Greetings
>  >
>  > [1.]
>  > If I use _syscall4 in order to call sys_futex and compile with -fPIC, I
>  > receive this compiler error:
>  > "can't find a register in class `BREG' while reloading `asm'"
> 
> Don't do that then.
> 
>  > [2.]
>  > I'm using futexes in a project and I have to build a shared library;
>  > thus I need to use -fPIC when compiling. When doing so, I get the error
>  > mentioned in [1.].
> 
> Don't use kernel headers in user space.  Use syscall(3) instead.

The "_syscallx" macros are in the userspace versions of the kernel headers, and 
as such should be fair game.  Also, you need to get a list of syscall numbers 
somehow, and those numbers are generally defined in the same file that contains 
the "_syscallx" macros.

syscall() doesn't work for all system calls.  The man page explicitly warns that 
it doesn't work for pipe(2).  Interestingly, the glibc manual doesn't have that 
warning.  Wonder which is correct...

Chris
