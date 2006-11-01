Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946105AbWKAFd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbWKAFd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946097AbWKAFd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:33:57 -0500
Received: from 1wt.eu ([62.212.114.60]:59140 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1946105AbWKAFd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:33:57 -0500
Date: Wed, 1 Nov 2006 07:33:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: Valdis.Kletnieks@vt.edu
Cc: ray-gmail@madrabbit.org, "Martin J. Bligh" <mbligh@google.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061101063340.GA543@1wt.eu>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com> <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 03:53:00PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 31 Oct 2006 08:34:23 PST, Ray Lee said:
> > On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
> > > > At some point we should get rid of all the "politeness" warnings, just
> > > > because they can end up hiding the _real_ ones.
> > >
> > > Yay! Couldn't agree more. Does this mean you'll take patches for all the
> > > uninitialized variable crap from gcc 4.x ?
> > 
> > What would be useful in the short term is a tool that shows only the
> > new warnings that didn't exist in the last point release.
> 
> Harder to do than you might think - it has to deal with the fact that
> 2.6.N might have a warning about 'used unintialized on line 430', and
> in 2.6.N+1 you get two warnings, one on line 420 and one on 440.  Which
> one is new and which one just moved 10 lines up or down?  Or did a patch
> fix the one on 430 and add 2 new ones?

Not necessarily harder. On a related topic, I maintain an own tree with
about 60-100 patches, added to about as much for the glue to resolve
conflicts. When I apply them in sequence, I get lots of rejects and
fuzzy matches. Initially, it was very hard to know which ones were
expected (and solved) and which ones were new. So I archived the stderr
of the "patch" command in a file named "apply.log". It just show the
patch name and its output if any. Now, when I make a new version, I don't
worry about the warnings or errors, I just diff the new result with the
previous one and quickly detect the patches which conflicts, or even
subtle changes such as fuzzy matches, or "2 hunks failed" instead of
"1 hunk failed".

Since diff's algorithm is very efficient at resynchronizing, you most
often detect only a few changes. From experience, the fact that some
warnings change from line 420 to 440 is very easy to process because
at a glance because you quickly detect that the line is not far away
from the old one, and the warning is exactly the same. So you don't
worry. When you have a doubt, you simply check the code.

The only situation I can imagine which would cause large amounts of
warnings is the ones caused by includes which will propagate to
all files.

I've not tried Al's remapper, but considering how he hates useless
warnings and hidden bugs, I can imagine he has attacked the problem
on the right side ;-)

Regards,
Willy

