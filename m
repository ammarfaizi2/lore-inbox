Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUAHSCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUAHSCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:02:41 -0500
Received: from [193.138.115.2] ([193.138.115.2]:28173 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265683AbUAHSCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:02:35 -0500
Date: Thu, 8 Jan 2004 18:59:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
cc: Jens Axboe <axboe@suse.de>, Hans Reiser <reiser@namesys.com>,
       Joe Perches <joe@perches.com>, Oleg Drokin <green@linuxhacker.ru>,
       Mike Fedyk <mfedyk@matchmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Tim Cambrant <tim@cambrant.com>, Paul Jackson <pj@sgi.com>,
       markhe@nextd.demon.co.uk, manfred@colorfullife.com,
       Matthew Wilcox <matthew@wil.cx>
Subject: Cleanup patches - comparison is always [true|false] + unsigned/signed
 compare, and similar issues.   (consolidating existing threads)
Message-ID: <Pine.LNX.4.56.0401081847190.10083@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since I see people commenting, on what is essentially the same issue, in
3 or four different threads, I thought I'd try to consolidate the
discussion in a completely new thread - since it's moved beyond concrete discussion
of the actual patches I posted and into a discussion about that sort of
patches in general.
I'm CC'ing the people who have been commenting on the previous threads -
those threads being those I started with the topics :

"Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested"
"[PATCH] mm/slab.c remove impossible <0 check - size_t is not signed - patch is against 2.6.1-rc1-mm2"
"[PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl - arg is unsigned."
"[PATCH][RFC] variable size and signedness issues in ldt.c - potential problem?"

As I see it the, issue is patches that clean up 'comparisons that are
always true or false', 'signed vs unsigned comparisons' and similar
"minor" issues.


First let me try to state clearly what my purpose(s) in creating those
patches, and the patches I had originally intended to follow them, were.
And also what I did /not/ intend to do with those patches.


A) I wanted to remove code that could potentially be hiding a real bug.
Examples would be code that by using an unsigned value might be casting
away a needed 'signedness' of a variable. Code that by mixing signed and
unsigned comparisons might be buggy in the case where the signed value
overflows and all other nasties that can potentially happen when signed
and unsigned values are mixed.

B) I wanted to remove dead code that was never being executed under any
circumstances. This includes both tiny fragments and larger sections of
code. I wanted to do this for 2 main reasons; first of all to attempt to
cut down the amount of unnessesary code for people to read through when
trying to understand the workings of a certain bit of code.
Secondly to try find cases where changes to code had left some bits
obsolete but those bits had been left in by mistake.

C) Remove as many warning messages as possible. One reason is to get less
cluttered output in general and also when compiling with -W. Another
reason being that some warnings actually indicate real bugs - I'm aware
that some warnings are completely pointless and the code being warned
about is exactely as it should be, and such warnings should be ignored.


What I did not intend to do with those patches was to decrease the
readabillity of the code or trouble maintainers with pointless
patch-reading.


People have been commenting both in favour of the patches and against
them, and my main reason for starting this new thread is to try and find
out if I should continue with this work or not.
I don't want to bother anyone with pointless patches, and I see no need to
spend my time doing stuff that people don't appreciate either, but if some
sort of agreement can be reached on what (sub)set of this type of patches
are wanted, then I'll be happy to do the work to track the code locations
down and provide such patches.


Thank you for reading this far.


-- Jesper Juhl

