Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSDOVl0>; Mon, 15 Apr 2002 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313302AbSDOVlZ>; Mon, 15 Apr 2002 17:41:25 -0400
Received: from h52544c185a20.ne.client2.attbi.com ([24.147.41.41]:34571 "EHLO
	luna.pizzashack.org") by vger.kernel.org with ESMTP
	id <S313300AbSDOVlZ>; Mon, 15 Apr 2002 17:41:25 -0400
Date: Mon, 15 Apr 2002 17:41:23 -0400
From: xystrus <xystrus@haxm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: link() security
Message-ID: <20020415174123.C16804@pizzashack.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020411192122.F5777@pizzashack.org> <s5gpu11rpgx.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 10:44:30AM -0400, Patrick J. LoPresti wrote:
> A better design is to use a separate spool directory for each user
> (/var/spool/mail/user/ or ~user/mail/ or somesuch), and only allow
> that user to access it at all.  This solves *all* of the security
> problems you mention:

I'll agree with the above, however consider that there are other
reasons to have drwxrwxrwt directories besides a mail spool.  My point
was not that link() should be modified because it makes mail spools
that use this feature less secure; my point was that (IMO) link should
be modified because it does not make sense to allow users to create
hard links to files they have no access to, in general.  The mail
spool example was simply one common example.

IMO, if I have created a file, and I own the file, then there are only
two users who should get to decide whether that file gets deleted or
not: me, and root.  Regular users should not be able to create hard
links to my files, potentially without me knowing about it.  Allowing
them to do so means that you allow users who do not own a resource,
and have no access to that resource, to potentially manage control of
that resource to some extent.  I don't see how this policy makes any
sense.  It allows that a file I created may be hanging around despite
the fact that I think it's been deleted.  And that just seems like a
very bad idea to me.

> The solution to a fundamentally broken spool design is to fix that
> design, not to patch the kernel in nonstandard ways to plug just one
> of its multiple flaws.

Rephrased, your argument is basically that it is unwise to continue a
behavior which is fundamentally flawed just because it is a standard
behavior.  That is precisely my argument WRT the current behavior of
link().

> All just My Opinion, of course.

Ditto. :)

Xy

