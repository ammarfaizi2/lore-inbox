Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVCIJ5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVCIJ5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 04:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVCIJ5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 04:57:32 -0500
Received: from one.firstfloor.org ([213.235.205.2]:59302 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262218AbVCIJ4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 04:56:40 -0500
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
References: <20050309072833.GA18878@kroah.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 09 Mar 2005 10:56:33 +0100
In-Reply-To: <20050309072833.GA18878@kroah.com> (Greg KH's message of "Tue,
 8 Mar 2005 23:28:33 -0800")
Message-ID: <m1sm35w3am.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
>
> Rules on what kind of patches are accepted, and what ones are not, into
> the "-stable" tree:
>  - It must be obviously correct and tested.
>  - It can not bigger than 100 lines, with context.

This rule seems silly. What happens when a security fix needs 150 lines? 

Better maybe a rule like "The patch should be the minimal and safest 
change to fix an issue". But see below for an exception.

>  - It must fix only one thing.
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing.)
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>    security issue, or some "oh, that's not good" issue.  In short,
>    something critical.
>  - No "theoretical race condition" issues, unless an explanation of how
>    the race can be exploited.
>  - It can not contain any "trivial" fixes in it (spelling changes,
>    whitespace cleanups, etc.)
>  - It must be accepted by the relevant subsystem maintainer.



>  - It must follow Documentation/SubmittingPatches rules.

One rule I'm missing:

- It must be accepted to mainline. 

That is what big enterprise distributions often require and I think
it's a good rule. Otherwise you risk code and feature set drift
and we don't want to repeat the 2.4 mistakes again where some 
subsystems had more fixes in 2.4 than 2.6.

Also your rules encourage to do different patches for -stable
(e.g. with less comment changes etc.) than for mainline. I don't
think that's a very good thing. Sometimes it is unavoidable
and sometimes the mainline patches are just too big and intrusive,
but in general it's imho best to apply the same patches
to mainline and backport trees.  This has also the advantage
that the patch is best tested as possible; slimmed down patches
usually have a risk of malfunction.

If a mainline patch violates too many of your other rules
("Fixes one thing; doesn't do cosmetic changes etc.") perhaps
the mainline patch just needs to be improved.

So in general there should be a preference to apply the same
patch as mainline, unless it is very big.

>  - Security patches will be accepted into the -stable tree directly from
>    the security kernel team, and not go through the normal review cycle.
>    Contact the kernel security team for more details on this procedure.

This also sounds like a bad rule. How come the security team has more
competence to review patches than the subsystem maintainers?  I can
see the point of overruling maintainers on security issues when they
are not responsive, but if they are I think the should be still the
main point of contact.

-Andi
