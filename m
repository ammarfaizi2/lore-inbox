Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWIGBB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWIGBB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 21:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWIGBB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 21:01:29 -0400
Received: from web36603.mail.mud.yahoo.com ([209.191.85.20]:48535 "HELO
	web36603.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161054AbWIGBB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 21:01:28 -0400
Message-ID: <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Wed, 6 Sep 2006 18:01:27 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20060907003210.GA5503@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- David Madore <david.madore@ens.fr> wrote:


> I understand your point.  But if we want these
> under-privileges to
> follow the same inheritance rules as the
> over-privileges provided by
> capabilities (were it only to make things simpler to
> comprehend),
> doesn't it make sense to implement them in the same
> framework?

I'm certainly not convinced that you'd
want that. Think of all the programs that
would have to be marked with CAP_FORK.

> Rather
> than trying to reproduce the same rules in a
> different part of the
> kernel, causing code reduplication which would
> eventually, inevitably,
> fall out of sync...  I think it's easier for
> everyone if under- and
> over-privileges are treated in a uniform fashion.

This again assumes that you want to require
that in general processes run with some
capabilities.

> Perhaps that's not
> what POSIX intended, but I don't think "not what was
> intended" is a
> sufficient reason for backing away from something
> that might be
> useful.  Do you have a specific problem in mind?

You betcha. (That's Minnisotan for "Yes indeed")

In our TCSEC B1 (Old person speak for LSPP)
evaluation we had to put way too much effort
into explaining why certain operations that
had nothing to do with the system security
policy (e.g. compute resource limitations)
required privilege. These operations had
no security implications at all, but since
they required privilege they were assumed to
have dire consequences should they be abused.

If you introduce an "underprivileged" process,
you immediately relegate what are currently
unprivileged processes to the realm of
privileged processes. All of a sudden any
process that does fork() requires additional
scrutiny because it uses privilege. You
won't convince any evaluator that there is a
difference between "having a capability" and
"not having lack of capability".

On the other hand if you have "additional
restrictions" available (as in an LSM) that
are not part of the policy enforcement
mechanism there should be no problems.

> However, the suggestion makes sense: if I can't
> convince the Powers
> That Be that implementing under-privileges with
> capabilities is a Good
> Thing (and I can see that it will be a serious
> problem), I'll try the
> LSM approach.

Further, you can assign any semantic that
makes sense to you. Heaven knows, the POSIX
calculation (from any of the DRAFTS) has
proven to be contentious. Especially in the
inheritence rules on exec.


Casey Schaufler
casey@schaufler-ca.com
