Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264615AbSJRJto>; Fri, 18 Oct 2002 05:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264616AbSJRJto>; Fri, 18 Oct 2002 05:49:44 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:64521 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S264615AbSJRJtm>;
	Fri, 18 Oct 2002 05:49:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] remove sys_security
Date: Fri, 18 Oct 2002 11:55:31 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20021017201030.GA384@kroah.com.suse.lists.linux.kernel> <3DAFC6E7.9000302@wirex.com.suse.lists.linux.kernel> <p73wuognlox.fsf@oldwotan.suse.de>
In-Reply-To: <p73wuognlox.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210181155.31274.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 11:25, Andi Kleen wrote:
> Crispin Cowan <crispin@wirex.com> writes:
> > Could you elaborate on why this is a sign of trouble, design wise?
>
> David refers to the 32bit emulation issues. Some ports have a 64bit
> kernel, but support 64bit and 32bit userland (e.g. ia64 or x86-64).

For such ports would we need to have security system calls operating in both 
64bit and 32bit versions?  For SE Linux half the programs that use the SE 
system calls are specific to SE Linux (loading policy, showing or toggling 
"enforcing mode", etc), the other half are modified versions of ls, ps, cron, 
login, and a few other important system programs.

I can't imagine why you would want to use a 32bit policy loading program on a 
64bit SE kernel.

As for cron etc, is it going to be difficult to get those programs compiled 
for 64bit operation?

> Some ports even only have 32bit userland but 64bit kernel (like sparc64 or
> mips64)

So for those ports we could have a straight 32bit interface and again have no 
problems.

> The 32bit and the 64bit worlds have different data types. Structure
> layout are different. To handle this the kernel has an emulation
> layer that converts the arguments of ioctls and system calls between
> 32bit and 64bit.

Which is terribly ugly.

I agree with the point about not wanting to be converting between 32bit and 
64bit for the LSM calls.  However I am not certain that we need to support 
both 32bit and 64bit interfaces to LSM on the same platform.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

