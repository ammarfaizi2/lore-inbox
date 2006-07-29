Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWG2Fag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWG2Fag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 01:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161457AbWG2Fag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 01:30:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:32915 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161427AbWG2Faf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 01:30:35 -0400
From: Neil Brown <neilb@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Date: Sat, 29 Jul 2006 15:29:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17610.62013.790217.817455@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] knfsd: Fix stale file handle problem with subtree_checking.
In-Reply-To: message from J. Bruce Fields on Friday July 28
References: <20060728194103.7245.patches@notabene>
	<1060728094255.7278@suse.de>
	<20060728205156.GB12183@fieldses.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 28, bfields@fieldses.org wrote:
> 
> It'd be great if we could deprecate subtree checking some day in the
> distant future....

The first step would be to stop it from being the default (as Trond
has suggested a number of times :-)

How about this.
 I release a 1.0.10 shortly which addresses some 'portlist' related
 breakage and prints a nasty warning if you have neither subtree_check
 or no_subtree_check, but still defaults to subtree_check.

 Then the next release will be 1.1.0 which prints the same warning,
 but defaults the other way - and probably removed the warning if you
 include neither sync not async.

That should at least get subtree_check to be used less.

> 
> Would it be feasible to add filesystem support for some sort of
> subvolume-like thing that acted like a mountpoint (in the sense that it
> restricted hardlinks and renames) but that didn't require setting aside
> a separate partition?  I imagine that'd probably do what most people
> exporting subtrees want without forcing us to do dubious tricks with
> filehandles.

I think it is a great idea for a 'filesystem' to support multiple
independent file-trees within the one storage set, which is roughly
what you are saying I think (though probably not quite).

However I suspect that most people don't actually want subtrees.  They
just get it as the default.  It isn't something that I would have
implemented if I hadn't inherited the requirement, and no other OS
that I know of provides that particular semantic.

Maybe we should make it non-default, and then in one year, subtly
break it (maybe reintroduce this bug) and see if anyone notices :-) 
(No, that's unethical, I wouldn't do that - really ....)

NeilBrown
