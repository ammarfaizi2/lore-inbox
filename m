Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVBXReD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVBXReD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVBXReD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:34:03 -0500
Received: from calma.pair.com ([209.68.1.95]:46601 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S262427AbVBXRd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:33:56 -0500
Date: Thu, 24 Feb 2005 12:33:56 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224173356.GA11593@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com> <20050223183634.31869fa6.akpm@osdl.org> <20050224052630.GA99960@calma.pair.com> <421DD5CC.5060106@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421DD5CC.5060106@aitel.hist.no>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why would anyone write a thread than uses exactly 100% of one cpu?
> It seems wrong to me.  It is unsafe if they really need that much
> processing power, what if an interrupt happens? Then they get slightly less.
> If they got a 10% faster cpu, would this thread suddenly drop to 90%
> usage (and no problems with kernel threads)? 
> If it stays at 100% then that suggests they are using some
> sort of busy waiting which is bad programming.  Get a better hw
> device that will provide an interrupt at the right time, and write a 
> driver for
> that.  Or find some spot in the code where a small delay in acceptable,
> and set a short timer and sleep on it. It doesn't take much to get this
> kernel thread going.

I would make the following assertion for any kernel:

No single userspace thread of execution running on an SMP system should be 
able to hose a box by going CPU-bound, bug in the software or no bug.  Any
kernel should be able to handle this case and shift general work over to
other processors.

While I can't speak for all commercial Unixes, I know that HP-UX handles this
case just fine.  I'd be extremely surprised if Solaris and AIX didn't handle
it fine too.  What I can't understand is why you want to cop-out and say
"Oh well this is just a bug in the application... the programmer shouldn't
shoot himself in the foot."  If that were the attitude that kernel programmers
had, why have the kernel send SIGSEGV when applications reference invalid 
memory?  Why not just let them corrupt the memory of other apps and possibly
bring the whole system down?

It is the kernel's job to protect itself and userspace applications from 
runaway applications whenever possible.  While this might not be possible for 
this case on a UP box, it certainly is for an SMP box.

Chad
