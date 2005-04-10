Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVDJJsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVDJJsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVDJJsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:48:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43220 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261454AbVDJJsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:48:15 -0400
Date: Sun, 10 Apr 2005 11:48:13 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <junkio@cox.net>
Cc: Christopher Li <lkml@chrisli.org>, Linus Torvalds <torvalds@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050410094813.GB26537@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <20050410055340.GB13853@64m.dyndns.org> <7v7jjbc755.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v7jjbc755.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 11:28:54AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "CL" == Christopher Li <lkml@chrisli.org> writes:
> 
> CL> On Sun, Apr 10, 2005 at 12:51:59AM -0700, Junio C Hamano wrote:
> >> 
> >> But I am wondering what your plans are to handle renames---or
> >> does git already represent them?
> >> 
> 
> CL> Rename should just work.  It will create a new tree object and you
> CL> will notice that in the entry that changed, the hash for the blob
> CL> object is the same.
> 
> Sorry, I was unclear.  But doesn't that imply that a SCM built
> on top of git storage needs to read all the commit and tree
> records up to the common ancestor to show tree diffs between two
> forked tree?

No. See diff-tree output and
http://pasky.or.cz/~pasky/dev/git/gitdiff-do for how it's done.
Basically, you just take the two trees and compare them linearily (do a
normal diff on them, essentialy). Then the differences you spot this way
are everything what needs to appear in the patch.

> I suspect that another problem is that noticing the move of the
> same SHA1 hash from one pathname to another and recognizing that
> as a rename would not always work in the real world, because
> sometimes people move files *and* make small changes at the same
> time.  If git is meant to be an intermediate format to suck
> existing kernel history out of BK so that the history can be
> converted for the next SCM chosen for the kernel work, I would
> imagine that there needs to be a way to represent such a case.
> Maybe convert a file rename as two git trees (one tree for pure
> move which immediately followed by another tree for edit) if it
> is not a pure move?

Actually, this could be possible too I think. We will have to make
diff-tree two-pass, but it is already so blinding fast that I guess that
doesn't hurt too much. I might try to get my hands on that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
