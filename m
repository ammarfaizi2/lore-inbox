Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUIPScG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUIPScG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUIPS3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:29:55 -0400
Received: from mail.joq.us ([67.65.12.105]:23963 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S268230AbUIPS1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:27:21 -0400
To: Jody McIntyre <realtime-lsm@modernduck.com>
Cc: James Morris <jmorris@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <20040916023118.GE2945@conscoop.ottawa.on.ca>
	<87d60mrf8i.fsf@sulphur.joq.us>
	<20040916155127.GG2945@conscoop.ottawa.on.ca>
From: "Jack O'Quin" <joq@io.com>
Date: 16 Sep 2004 13:27:02 -0500
In-Reply-To: <20040916155127.GG2945@conscoop.ottawa.on.ca>
Message-ID: <87zn3qoyrt.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre <realtime-lsm@modernduck.com> writes:

> On Wed, Sep 15, 2004 at 11:48:29PM -0500, Jack O'Quin wrote:
> 
> > What are the serialization issues with variable updates via /proc?  I
> > presume they can change at any time, even while the LSM is running on
> > some other processor.  If so, I'll need to be careful to fetch each
> > variable only once and use that value for the entire capability
> > computation, right?  That should be straightforward.
> 
> It doesn't matter.  There's no added security risk if gid changes
> halfway through the permission check, and the other variables are used
> only once.  It's probably cleaner to check the gid in a separate
> function though.

Agreed.  

One could probably get a false negative, but it's hard to imagine a
sensible usage example.  I just like to be tidy any time concurrency
issues arise.

> However, I just noticed something interesting:
> 
> If "any" and "gid" is set, any is ignored and only the gid check is
> effective.  This is counter to the documentation, so I assume it is a
> bug.

Quite right, good eye.  :-)

I must not have tested that combination.  :-(

> I also added the sysctl interface to the documentation.

Good.  I thought about that, too.

> > But, perhaps we should consider removing this option entirely.  It is
> > the only one with a potentially serious security exposure.  The others
> > at worst allow Denial of Service attacks.
> 
> I hate allcaps too.  Maybe you should just use a shell script wrapper
> like (untested):
> 
> ----
> if echo uname -r |grep '^2\.4\.' ; then
> 	jackstart $@
> else
> 	jackd $@
> fi
> ----

I am willing to do that if the kernel developers think it better.  

It recently occurred to me that jackstart might be able to detect this
situation and exec jackd, anyway.  (AFAICT, the only reasonably
POSIX-compliant method for detecting that a process has the
"appropriate permission" to do something is trying it to see whether
it returns EPERM.)

Thanks for helping...
-- 
  joq
