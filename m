Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSDDSla>; Thu, 4 Apr 2002 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSDDSkg>; Thu, 4 Apr 2002 13:40:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:10247 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292957AbSDDSk1>;
	Thu, 4 Apr 2002 13:40:27 -0500
Subject: Re: [patch] kjournald locking fix
From: Robert Love <rml@tech9.net>
To: "Ishan O. Jayawardena" <ioshadij@hotmail.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0204041539260.572-200000@shalmirane.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 13:40:22 -0500
Message-Id: <1017945626.22299.475.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 17:02, Ishan O. Jayawardena wrote:
> 
> Greetings,
> 
> 	kjournald seems to be missing an unlock_kernel() for a matching
> lock_kernel(). A posting by  Dennis Vadura to l-k mentions (among other
> things) a kernel message that says kjournald exited with preempt_count ==
> 1. The attached patch (text/plain) adds the necessary
> unlock_kernel(). [But I haven't been able to reproduce the hang that
> Dennis experiences...]
> 	Tested only on UP. Patch is for 2.4.19-pre5 + prempt-kernel, _no_
> lock-break. I hope the positioning of unlock_kernel() is correct... please
> correct me if I'm wrong.

The unlock_kernel is correct, thanks.

In this case, the messae about the nonzero preempt_count is not a
problem - kjournald just exits without dropping the BKL because it knows
schedule will do it for you.  It is cleaner, however, to explicitly
relinquish the lock, and it removes the preempt_count debug whining.

So the patch is good - thanks,

	Robert Love

