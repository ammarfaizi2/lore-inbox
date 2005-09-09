Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVIIS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVIIS1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVIIS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:27:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750973AbVIIS1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:27:52 -0400
Date: Fri, 9 Sep 2005 11:27:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
Message-Id: <20050909112721.316f2dbb.akpm@osdl.org>
In-Reply-To: <43219FDF0200007800024975@emea1-mh.id2.novell.com>
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
	<20050908151624.GA11067@infradead.org>
	<432073610200007800024489@emea1-mh.id2.novell.com>
	<20050908184659.6aa5a136.akpm@osdl.org>
	<43219FDF0200007800024975@emea1-mh.id2.novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> First, I rarely saw any kind of positive review feedback from lkml
>  besides the notification that you added something to your -mm tree
>  (negative things of course always arrive), yet no feedback at all is far
>  from meaning that a given patch is ever going to be accepted (as a
>  really good example take the tiny patch to fix the broken range check in
>  i386's low level NMI handler).

I cherrypicked five of your patches yesterday as ones which look like they
should be in 2.6.14.

	fix i386 cmpxchg
	adjust .version updating
	free initrd mem adjustment
	constify font data
	minor fbcon_scroll adjustment

But none of those are NMI-related.  Specifically which patch are you
referring to?

>  Second, since patches depend on one another in many cases it seemed
>  most natural to me to first break out things that aren't directly
>  related to nlkd or, if directly related, could still be viewed as
>  independent pieces of work.

Yup, thanks for that.

> Hence I wouldn't consider it reasonable to
>  break up the debugger patch entirely and submit all the pieces at once,
>  because that could easily mean that if one intermediate piece doesn't
>  get accepted all the dependent pieces have been separated out
>  pointlessly.

Well.  That's what I mean by "Each patch should do a single logical thing".
 If that single logical thing is "add a debugger" then OK.  We regularly
add things like new filesystems in a single patch.

That begin said, people sometimes also choose to break a lage patch into
multiple patches even if they're all interdependent.  We don't mind that,
but it's not terribly useful.  One advantage of this approach is that it
splits the patch up into chunks which the vger mail server will accept -
I'm not sure what the email size limit is but it seems to be around 80-100
kbytes.

>  I'd be curious to know how you, considering yourself in my position,
>  would have approached breaking up and submitting that size a patch.

a) Patches which affect the main kernel but which aren't really
   debugger-related

b) Patches which affect the main kernel and which are debugger-related
   (adding hooks, generalising interfaces, refactoring functions, etc).

c) Finally, one monster patch to add the debugger functionality.  Maybe
   split into in vger-sized chunks.
