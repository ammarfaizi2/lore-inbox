Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVAFS2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVAFS2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVAFSZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:25:51 -0500
Received: from orb.pobox.com ([207.8.226.5]:25511 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262951AbVAFSXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:23:42 -0500
Date: Thu, 6 Jan 2005 10:23:36 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Dave Jones <davej@redhat.com>, William Lee Irwin III <wli@holomorphy.com>,
       Bill Davidsen <davidsen@tmr.com>, "L. A. Walsh" <law@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] zap the ACPI shutdown bug (was Re: Reviving the concept of a stable series)
Message-ID: <20050106182336.GB2390@ip68-4-98-123.oc.oc.cox.net>
References: <41D91707.6040102@tlinx.org> <41D9C53A.3030503@tmr.com> <20050104130846.GD2708@holomorphy.com> <20050104182017.GE19167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104182017.GE19167@redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The humor in this e-mail may be caustic, but it's **really** not
intended to start a flamewar. Feel free to mentally insert one or two
smileys at the end of each paragraph. If the jokes don't make sense,
maybe they'll make more sense after you finish reading the entire
message.

Maybe these jokes are cruel, but honestly, the irony here just
absolutely *kills* me and I can't help myself right now.)

On Tue, Jan 04, 2005 at 01:20:17PM -0500, Dave Jones wrote:
> Post release, the myriad of users filled RH bugzilla diligently
> with their many reports of interesting failures.  Upstream had
> now started charging ahead with what was to be 2.6.10.
> 
> The delta between 2.6.9 -> 2.6.10 was around 4000 changesets.
> Cherry picking csets to backport to 2.6.9 at this rate of
> change is nigh on impossible. You /will/ miss stuff.

Food for thought: If upstream doesn't charge ahead, somebody else will.
And that will also cause regressions, albeit ones that are even harder
to see. People will think they're looking in the right direction, but
will be unable to see anything, and that will just confuse everyone
more.

(If that doesn't make sense now, read this message all the way
through, then start reading it from the beginning again.)

[snip]
> So now we're at our 2.6.9-ac+a few dozen 2.6.10 csets
> and all is happy with the world. Except for the regressions.
> As an example, folks upgrading from Fedora core 2, with its
> 2.6.8 kernel found that ACPI no longer switched off their
> machines for example. Much investigation went into
> trying to pin this down. Kudos to Len Brown and team for
> spending many an hour staring into bug reports on this
> issue, but ultimately the cause was never found.

Until now. (Keep reading.)

> It was noted by several of our users seeing this problem
> that 2.6.10 no longer exhibits this flaw.  Yet our
> 2.6.9-ac+backports+every-2.6.10-acpi-cset also was broken.

I will not make vendor feature patches an issue in this thread. I'm not
going to exploit for argumentative purposes your odd definition of the
word "backport".

> It's likely Fedora will get a 2.6.10 based update before
> the fault is ever really found for a 2.6.9 backport.

"Backport"? There you go again!

> This is just one example of a regression that crept in

Crept in, yes... but into where? 

> unnoticed, and got fixed almost by accident. (If it

It wasn't fixed *almost* by accident. It *was* fixed by accident --
yours.

> was intentionally fixed, we'd know which patches
> we needed to backport 8-)

Or which patches to avoid "backporting", as the case may be.

[snip]
> So, of those 182 patches we dropped in our 2.6.10 rebase..
> Some of them were upstream backports, but some of them were
> patches we pushed upstream that we now get to drop on a rebase.

And one of them (that I noticed, anyway) was a "backport" that you
(whether accidentally or intentionally) stopped "backporting" when you
rebased to 2.6.10.

If the "backport" jokes don't make sense yet, consider this dilemma: If
a backported patch has not been committed upstream yet, then is it
really a backport?


The following patch removes the ACPI shutdown bug from 2.6.9-1.724_FC3,
at least in my testing on my affected system. The diff almost succeeds
in speaking for itself, but to fully understand what it's saying, you
will also need to grep a 2.6.10 Fedora kernel-2.6.spec file for "kexec".

-Barry K. Nathan <barryn@pobox.com>

--- kernel-2.6.spec.ACPI-shutdown-bug	2005-01-06 08:40:15.264970728 -0800
+++ kernel-2.6.spec.no-ACPI-shutdown-bug	2005-01-06 08:40:08.629979400 -0800
@@ -863,7 +863,7 @@
 %patch1081 -p1
 
 # Kexec in preparation for kexec-based dump
-%patch1090 -p1
+#patch1090 -p1
 
 #
 # Sata update
