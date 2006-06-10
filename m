Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWFJUCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWFJUCk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 16:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWFJUCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 16:02:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbWFJUCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 16:02:39 -0400
Date: Sat, 10 Jun 2006 13:02:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Jeff Garzik <jeff@garzik.org>, Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
 <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org>
 <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com> <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Jun 2006, Linus Torvalds wrote:
> 
> ext2 is half the size of ext3, and that's ignoring JBD entirely.

Btw, let me say again that I'm fairly neutral on any particular individual 
feature (ie the 48-bit thing doesn't actually move me all that much in 
itself), but that from a maintenance standpoint, I think splitting off 
filesystems and drivers has been a _huge_ success.

Starting from scratch - even if you literally start from the same 
code-base - and allowing the old functionality to remain undisturbed is 
just a very nice model. Yeah, yeah, it has some diskspace cost (although 
at least from a git perspective, even that isn't really true), but we've 
seen both in drivers and in filesystems how splitting things up has been a 
great thing to do.

Sometimes it's a great thing just because five years later, it turns out 
that nobody even uses the legacy thing, and you decide to at that point 
just remove the driver (or filesystem, but so far it's never been the 
case for filesystems even if smbfs is a potential victim of this in the 
not _too_ distant future), because the new version simply does everything 
better.

And that's _not_ a failure of the model. It's a success too. But so is the 
above commentary on ext2, when the "old driver/filesystem is still used 
and maintained by odd people". It's just two different possible outcomes 
of the decision to do development separately from an older user base.

And again, I'd like to stress the _user_base_ over the _code_base_. In 
many ways, that's the much more important split. I suspect Jeff has seen 
this in drivers, where a lot of users simply do not want to have a new 
driver, because it does some huge fundamental improvement for new users 
but doesn't work for old ethernet cards, for example, because it missed 
some old use case depended on a legacy feature that just doesn't fit well 
into the new (and obviously improved) world-view.

So we've often seen a driver that _could_ have handled different versions 
of the same card/chip split into an "old" and a "new" driver, and on the 
whole it has always been positive - even if eventually the old driver just 
becomes irrelevant for one reason or another.

Duplication isn't actually bad. It's what often allows experimentation, 
and streamlining. In drivers, for example, duplication is _often_ done as 
part of simply dropping support for old cards in the new version, but also 
by dropping and simplifying the old driver that now has a much clearer 
"raison d'etre", aka "user base".

Which gets me back to the whole "'user base' matters more than 'code 
base'" argument, because it's literally the user base that determines 
development (or lack of it - non-development is often the big reason for a 
user base, as anybody who works for a distribution maintainer should know 
intimately).

			Linus
