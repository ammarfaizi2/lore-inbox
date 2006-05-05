Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWEEOfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWEEOfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWEEOfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:35:01 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:13250 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750821AbWEEOfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:35:00 -0400
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <3439.1146837829@warthog.cambridge.redhat.com>
References: <1146834740.10109.9.camel@kleikamp.austin.ibm.com>
	 <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com>
	 <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033829.GE28613@hellewell.homeip.net>
	 <23457.1146778849@warthog.cambridge.redhat.com>
	 <3439.1146837829@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 05 May 2006 09:34:50 -0500
Message-Id: <1146839690.10108.21.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-05 at 15:03 +0100, David Howells wrote:
> Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> 
> > > But it may use more stack, which is a much more limited resource, so what
> > > you suggest is not necessarily the best thing to do.
> > 
> > I think either way it's coded, the compiler will probably store the
> > result in a register.
> 
> There's an apparent function call between the two usages of the value.  So
> even if the value is placed in a register, that register must either be saved
> on the stack around the function call (if it's callee-clobbered), or the
> register must be saved on the stack before the value is placed in it (if it's
> callee-saved).

Probably true unless it can reuse a callee-saved register.

> Either way, it will use more stack; the mere fact that whilst it's using the
> value, the compiler may stash it in a register is irrelevant.

Is the stack usage very close to exceeding 4 KB?  Could saving one more
pointer on the stack cause a problem?  Anyway, it's not that big of a
deal.  The code may look a little cleaner with a local variable, but
it's not that bad as it is.

> > I would recommend the most readable approach (which I believe would be using
> > a local variable) and leave the optimization to the compiler.
> 
> Whilst it may be more readable, it doesn't mean it's more optimal.  You're
> just trading stack usage for code size.  The function call in the middle
> limits the optimisation the compiler can do.
> 
> Of course, if the thing in the middle is not actually a function call, or if
> it can be inlined, then this _might_ not apply.  It may even be possible that
> the compiler will discard the variable and fetch it again from memory if it
> considers the value in memory to be unchanging for the duration.

It looks like a real function call.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

