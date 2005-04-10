Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVDJCmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVDJCmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDJCmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:42:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45776 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261280AbVDJCl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:41:58 -0400
Date: Sun, 10 Apr 2005 04:41:57 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050410024157.GE3451@pasky.ji.cz>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Ross Vandegrift <ross@jose.lug.udel.edu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 01:31:10AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sat, 9 Apr 2005, Linus Torvalds wrote:
> > 
> > Actually, I guess I wouldn't have to change the format. I could just 
> > extend the existing "tree" object to be able to point to other trees, and 
> > that's it.
> 
> Done, and pushed out. The current git.git repository seems to do all of 
> this correctly.
..snip..

Ok, so now I can dare announce it, I hope. I hacked my branch of git
somewhat, kept in sync with Linus, and now I have something to show.
Please see it at

	http://pasky.or.cz/~pasky/dev/git/

It is basically a set of (still rather crude) shell scripts upon Linus'
git, which make it sanely usable by mere humans for actual version
tracking. Its usage _is_ going to change, so don't get too used to it
(that'd be hard anyway, I suspect), but it should be working nicely.

I have described most of the interesting parts and some basic usage in
the README at that page. It wraps commits, supports log retrieval and
comfortable diffing between any two trees. And on top of that, it can do
some basic remote repositories - it will pull (rsync) from them and it
can make the local copy track them - on pull, it will be updated
accordingly (and your local commits on the tracked branch will get
orphaned).

I didn't attach a patch against Linus since I think it's pretty much
useless now. It's available as against-linus.patch on the web, and
you can apply it to the latest git tree (NOT 0.03). But it's probably
better idea to wget my tree. You can then watch us making progress by

	gitpull.sh linus
	gitpull.sh pasky

and see where we differ by:

	gitdiff.sh linus pasky

(This is how the against-linus.patch was generated. I'd easily generate
even 0.03 patch this way, but I forgot to merge the fsck at that time,
so it would suck.)

(Note that the tree you wget is set up to track my branch. If you want
to stop tracking it (basically necessary now if you want to do local
commits), do:

	cp .dircache/HEAD .dircache/HEAD.local
	gittrack.sh

The cp says that something like "I want to pick up where the tracked
branch left off". Otherwise, untracking would return you to your "local"
branch, which is just some ancient predecessor of the pasky branch here
anyway.)

Note that I didn't really test it on anything but git itself yet, so I'm
not sure how will it cope especially with directories - I tried to make
it aware of them though. I will do some more practical testing tomorrow.

Otherwise, I will probably try to consolidate the usage and
documentation now, and beautify the scripts. I might start pondering
some merging too. Oh, and gitpatch.sh. :-)

Have fun and please share your opinions,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
