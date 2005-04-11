Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVDKSk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVDKSk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVDKSk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:40:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62597 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261881AbVDKSki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:40:38 -0400
Date: Mon, 11 Apr 2005 20:40:34 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Jackson <pj@engr.sgi.com>, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: Re: [rfc] git: combo-blobs
Message-ID: <20050411184034.GD22322@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu> <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org> <20050411153905.GA7284@elte.hu> <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org> <20050411181319.GA11302@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411181319.GA11302@taniwha.stupidest.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 08:13:19PM CEST, I got a letter
where Chris Wedgwood <cw@f00f.org> told me that...
> On Mon, Apr 11, 2005 at 09:01:51AM -0700, Linus Torvalds wrote:
> 
> > I disagree. Yes, the thing is designed to be replicated, so most of
> > the time the easiest thing to do is to just rsync with another copy.
> 
> It's not clear how any of this is going to give me something like
> 
>      bk changes -R
> 
> or
>      bk changes -L
> 
> functionality.  I'm guessing I will have to sync locally and check
> between two trees in those cases?  Or at least sync enough metadata as
> to make this possible...  but not the entire tree right?

Checking "what will be transferred when I push" doesn't sound hard - the
push itself is not too trivial, but solvable. Perhaps even by pure
rsync, if you won't support updating tracked trees (does not sound
overwhelmingly useful anyway).

Checking "what will be transferred if I pull" is much worse. Perhaps you
could make a parallel objects repository, fetch all the newer commit and
tree metadata there, and then do diff-tree. I think you need something
smarter than rsync for that, though.

[git-pasky] As long as you are not pulling from a tracked branch, the
worst what can happen is that the enemy will trick you to pulling some
terabytes of data. Or overwrite existing objects with garbage, but
--ignore-existing would solve that trivially.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
