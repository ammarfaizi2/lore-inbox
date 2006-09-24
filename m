Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWIXNWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWIXNWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 09:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIXNWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 09:22:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57066 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750748AbWIXNWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 09:22:15 -0400
Date: Sun, 24 Sep 2006 15:22:13 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1
Message-ID: <20060924132213.GE11916@pasky.or.cz>
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <20060924124647.GB25666@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924124647.GB25666@flint.arm.linux.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Sep 24, 2006 at 02:46:47PM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> said that...
> On Sun, Sep 24, 2006 at 04:02:15AM -0700, Andrew Morton wrote:
> >  git-arm.patch
> 
> It's worth pointing out that something has gone horribly wrong in the
> devel branch of this tree, resulting in a load of files being deleted
> which shouldn't have been.
> 
> Absolutely no idea how that happened, but it's a commit buried behind
> lots of other commits and has taken some 4 days to be spotted.  At a
> guess, a perl bug where a new associative array somehow manages to pick
> up on old values and forget values from previous assignments.
> 
> Oddly, running the script in debug mode (where the only things which
> don't happen is the git commands get called) appears to give correct
> behaviour.
> 
> So I'm in the situation where I need to rebuild 4 days work in the ARM
> devel tree. ;(

If I understand correctly, you just need to get rid of that bad commit?

Can you copy the missing files (in the suitable tree structure) to
/tmp/missing/ and try this?

	cg-admin-rewritehist -r EVILCOMMIT \
		--tree-filter 'cp -r /tmp/missing/* .' \
		--commit-filter \
			'if [ "$GIT_COMMIT" = "EVILCOMMIT" ]; then
				shift;
				while [ -n "$1" ]; do
					shift; echo "$1"; shift;
				done;
			else
				git-commit-tree "$@";
			fi' \
		fixedbranch

(s/EVILCOMMIT/thesha1id/)

Now check if fixedbranch looks ok.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
