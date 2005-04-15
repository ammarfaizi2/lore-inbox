Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVDOFCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVDOFCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 01:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDOFCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 01:02:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26007 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261686AbVDOFCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 01:02:47 -0400
Date: Fri, 15 Apr 2005 06:02:46 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Franco Sensei <senseiwa@tin.it>
Cc: David Lang <david.lang@digitalinsight.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
Message-ID: <20050415050246.GA8859@parcelfarce.linux.theplanet.co.uk>
References: <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz> <425E9FE2.6090102@tin.it> <Pine.LNX.4.62.0504141050460.19663@qynat.qvtvafvgr.pbz> <425EC778.4070009@tin.it> <20050414232958.GY8859@parcelfarce.linux.theplanet.co.uk> <425F33C2.8020301@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425F33C2.8020301@tin.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 10:23:46PM -0500, Franco Sensei wrote:
> Al Viro wrote:
> >Elegant.  Very elegant.  Admirable exercise in misdirection - the word
> >"third-party" used to conflate all things non-kernel with 3rd party
> >kernel modifications.  Followed by appeals to civic obligations, no less.
> 
> Don't you think you're a little bit... disappointing?

No, just allergic to that kind of rethorics.

> >Of course, that doesn't change the simple fact: "outside world" is not
> >a single entity.  There are API warranties for userland.  There's no
> >API warranties for 3rd-party kernel modifications.
> 
> My question is, why?

See below.
 
> Technical reasons? Unaffordable efforts? I bet on the last.

The simple fact that authors of 3rd-party modules do not *want* a sane
API.  Current set of objects available to them is huge and most of that
pile had been exported only because
	1) somebody couldn't be bothered by thinking and just exported
whatever random kernel functions they happened to use.  Many of these
exports could be avoided by using an already exported function instead
of reimplementing it and exporting low-level functions used in that
reimplementation.  Many had been result of copying an already existing
stuff and doing local modifications in a copy, instead of figuring out
the sane way to do it in generic code.  And almost always these guys
did not say "we want to do this and that for this and that; let's see
how to do it sanely".  It was "here's a patch adding exports we need
for our module".
	2) such patches had met very low resistance for quite a while.

So what we have right now is a random slice of kernel objects that had
been exported for hell knows what reasons.  It's not an interface in any
sane meaning of thw word and preserving that set is both hopeless and
crippling.  And 3rd-party module writers will *not* be happy with managable
set of exports, if the past experience is anything to judge by.

> >Moreover, unless you manage to get the list of functions and data
> >types exported to modules somewhere within an order of magnitude
> >from the corresponding userland list (i.e. syscalls and types involved),
> >you are asking everybody to increase the size of API being preserved
> >at least tenfold.  As it is, that would be "by factor of 200-300".
> 
> I'm probably talking about the design of api.

And I am talking about the existing modules depending on something that
is not and never had been an API.  We can design whatever API we want,
but keeping it stable won't help you at all - modules are using the mess
they are using.  And any attempt to rip that crap out doesn't make them
happy or willing to cooperate, even when saner replacements are already
there and had been around for longer than the exports that get removed.
 
> >If you manage to convince module authors to live with the export list
> >cut down by that much - come back and we'll have something to talk
> >about.
> 
> An elegant way of saying ``shut your mouth''?

No.  "You are talking to wrong people; we can't help you until you pull off
a miracle and convince module authors to sanitize their codebase wrt set
of objects being used by it".

