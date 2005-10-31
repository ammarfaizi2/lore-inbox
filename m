Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVJaCfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVJaCfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVJaCfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:35:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23503
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751278AbVJaCfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:35:45 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sun, 30 Oct 2005 20:35:26 -0600
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20051029182228.GA14495@havoc.gtf.org> <200510301731.47825.rob@landley.net> <Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302035.26523.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 18:58, Linus Torvalds wrote:

> Using "git bisect" to generate successive bisections (and then building up
> a linearization patch from that) would work, but it would result in some
> _really_ strange things:

Which is fine for a debugging tool.

It sounds like any git user could make one of these patches now, and put them 
up each time you cut a release.  (Hmmm, is this likely to be scriptable, or 
does it require poking at the git source?  Coming up to speed on git is a 
to-do item for me.  It has its own _vocabulary_, not exactly a trivial time 
expenditure to understand what's going on for those of us who never got 
around to using bitkeeper...)

> it would basically have one patch do one thing, 
> then the next patch might _undo_ that, and do another, and then the third
> patch would re-do it and do them both together.
>
> And that's really sometimes the best linearization you can do. But that's
> just too strange and confusing, I think. And the patches would be horribly
> inefficient.

"Horribly inefficient" seems pretty standard for a debugging tool.  Dwarf2 
bloats executables by a factor of 10 or more.  If it's a big issue, perhaps 
kernel.org could offer both "rc1-rc2.patch" (the "simple diff between trees" 
version) and "rc1-rc2-bisect.patch" (the "ugly granular debugging" version).

Also, the patch description in the bisect version could easily include a URL 
to an online git diff viewer (can http://www.kernel.org/git do this?) in case 
people want to see what it did, since the patch for artificially linearized 
changes can easily be unintelligible, ala:

The human readable version of this patch is at:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3e6716e748609a3a899e8d670e42832921bd45bc

> At that point I'd rather teach people to use "git bisect" natively. It
> wouldn't be any less confusing than the patches ;)

The problem with teaching people to use "git bisect" is you have people who 
aren't kernel developers who have a bug, and want to help track down the bug, 
and you're telling them "Ok, to debug this you need to install git, use it to 
check out the linux-kernel repository, then..."

I suspect even the best-intentioned dilettantes seldom make it to "then".  
Telling them to binary search through a downloadable text file on the marker 
"===newpatch===" or some such sounds like a much easier sell.  It doesn't 
even need a shell script:

grep -n MARKER bisect.patch | less
(pick a line number)
head -n linenumber bisect.patch > test.patch

If that's not it, revert test.patch and then try again.  Tell us the first 
line number that failed, which is the end of the patch we want...

Hmmm...  The logical place to put the URL to gitweb is at the _end_ of the 
patch, attached to the marker.  So that's what they see in the grep, and the 
last thing they test when they cut at that line with head -n...

>   Linus

Rob
