Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSDAVqQ>; Mon, 1 Apr 2002 16:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312634AbSDAVqG>; Mon, 1 Apr 2002 16:46:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:7954 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312619AbSDAVp4>;
	Mon, 1 Apr 2002 16:45:56 -0500
Subject: Re: 2.4.18-xfs and the preemptive patch
From: Robert Love <rml@tech9.net>
To: niklas <niklas@bumby.net>
Cc: linux-kernel@vger.kernel.org, sandeen@sgi.com
In-Reply-To: <20020401014743.42630286.niklas@bumby.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 01 Apr 2002 16:45:48 -0500
Message-Id: <1017697549.2940.462.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-31 at 18:47, niklas wrote:
> I just installed the preemptive ( http://www.tech9.net/rml/linux/ ----
> preempt-kernel-rml-2.4.18-4 )  patch on my 2.4.18-xfs tree and when i
> run this kernel, every process ends with "exited with preempt_count 1
> " ( for example "rc.2[35] exited with preempt_count 1" )
> The number varies from 1 to 41 so far.
> Is this a known issue that there is a fix to, or is it just a
> misconfigurd syslog?

That message is caused by tasks exiting with a nonzero preempt_count. 
The preempt_count is basically a count of the number of spinlocks held,
so it should always be zero when a task exits.  Since it is positive,
you don't have anything to worry about wrt "stability" but the system
may not be preempting at all, which would make the preempt-kernel patch
worthless.

I talked to Steve Lord and Eric Sandeen at SGI and they believe they
know the cause of the problem.  Basically, XFS destroys some data
structures and doesn't unlock the associated lock, but just forgets
about it.  This is not good for kernel preemption.

They think the newest XFS in CVS does not do this anymore, but it still
may in some places.  Can you give it a try and let me know if you still
see the messages?  Especially with the same regularity and value.

	http://oss.sgi.com/projects/xfs/cvs_download.html

Thanks,

	Robert Love

