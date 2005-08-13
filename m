Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVHMOAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVHMOAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 10:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVHMOAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 10:00:39 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:23971 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750838AbVHMOAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 10:00:39 -0400
Subject: Re: [PATCH] Convert sigaction to act like other unices
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       gerg@uclinux.org, jdike@karaya.com, sammy@sammy.net,
       lethal@linux-sh.org, wli@holomorphy.com, davem@davemloft.net,
       matthew@wil.cx, geert@linux-m68k.org, paulus@samba.org,
       davej@codemonkey.org.uk, tony.luck@intel.com, dev-etrax@axis.com,
       rpurdie@rpsys.net, spyro@f2s.com, Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050813123956.GN22901@wotan.suse.de>
References: <1123900802.5296.88.camel@localhost.localdomain>
	 <20050813123956.GN22901@wotan.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 13 Aug 2005 10:00:14 -0400
Message-Id: <1123941614.5296.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 14:39 +0200, Andi Kleen wrote:
> On Fri, Aug 12, 2005 at 10:40:02PM -0400, Steven Rostedt wroqte:
> > Here's a patch that converts all architectures to behave like other unix
> > boxes signal handling.  It's funny that I didn't need to change the m68k
> > architecture, since it was the only one that already behaves this way!
> > (the m68knommu does not!)
> 
> <rest snipped which also wasn't better>
> 
> This is not a description of what you changed. A patch entry has to 
> start with a rationale and then a description of the change.

Sorry, I forgot that not all were in on the thread.  (duh, I added a
bunch of others, I guess I wasn't thinking clearly).

http://lkml.org/lkml/2005/8/9/190 "Singal handling possibly wrong".

Here's a summary:

Bodo Stroesser noticed a conflict between the man pages and what the
kernel was doing in regard to SA_NODEFER.  The man pages stated that
SA_NODEFER would only not defer the signal that is being processed,
where as the the kernel would not defer all signals (including those in
sa_mask).

The POSIX description of this was very confusing, where Linus thought it
explained what the kernel currently does, and I (and others) thought it
did what the man pages described.  Someone found an updated version that
supports my theory. In fact it seems that even the signal would be
defered if SA_NODEFER was set but the signal was in the sa_mask.

Finally, it was ask, what do other unix boxes do?  I wrote a simple
program that tested the behavior of this and posted it.  I had a couple
of responses that tested the following unices:

AIX, DU4, IRIX6, Solaris and OSF1, and all of these do it the way the
man pages described.  Since Linux happens to be the odd ball out, I
submitted the patch to make Linux act like other unix boxes with regard
to signals and SA_NODEFER.

Hope this explains things better.

-- Steve


