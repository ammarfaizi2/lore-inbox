Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290047AbSA3RiQ>; Wed, 30 Jan 2002 12:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289987AbSA3Rgz>; Wed, 30 Jan 2002 12:36:55 -0500
Received: from bitmover.com ([192.132.92.2]:37798 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290255AbSA3RfA>;
	Wed, 30 Jan 2002 12:35:00 -0500
Date: Wed, 30 Jan 2002 09:34:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        lm@bitmover.com
Subject: Re: real BK usage (was: A modest proposal -- We need a patch penguin)
Message-ID: <20020130093459.P23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net> <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there> <20020130034746.K32317@havoc.gtf.org> <a38ekv$1is$1@penguin.transmeta.com> <20020130050708.D11267@havoc.gtf.org> <20020130102458.B763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130102458.B763@lynx.adilger.int>; from adilger@turbolabs.com on Wed, Jan 30, 2002 at 10:24:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:24:59AM -0700, Andreas Dilger wrote:
> Well, the one benefit of using SCCS directories (which are only 1/3
> louder than CVS directories) is that tools like patch, make, ctags, emacs
> (I believe), etc. already understand what they are and how to extract
> the latest version of a file from there.  

Yup, I like 'em for that reason as well.  And you can do a

	bk clean # removes all non-modified working files
	ls	 # should see nothing but SCCS/

to clean up all that extra cruft that invariably winds up in your tree.

> I would have to agree.  Ted uses BK for e2fsprogs, and there have been
> several times when I try to send him a CSET, but he is unable to apply
> it because it is missing dependencies, even though I know those prior
> CSETs are actually independent changes that just happen to touch the
> same files.

Please see the response to Ingo and see if you could do what I suggested
there.  I believe that would work fine, if not, let me know.

> Also, (BK feature request time) there are times when I've done a 'bk citool'
> and committed a bunch of changes into a CSET, and later on done some more
> testing which revealed a bug or found that I'd forgotten to change the
> man page to track the changes I made.  I'd much rather be able to merge
> some more changes into the same CSET instead of creating a second CSET and
> now have two CSETs to ship around for what is logically a single change.**

In the next release, there is a "bk fix -c" that does what you want.  It
reedits the entire changeset, and preserves all your checkin comments. 
You don't want to use this if the changeset has propogated out of your
tree, but I use it all the time for exactly the situation you describe
above.  It will be in bk-2.1.4.

> I think it would quickly become a nightmare if you had to submit (and
> have accepted!) all of your changes to Linus IN ORDER.  As it stands now,
> there are lots of discrete changes I have in my ext2 tree, and whenever
> I get around to it or when people hit the same bug as me I generate a
> patch, edit out the irrelevant parts, and send it out.***

Yeah, we know.  Read the other mails and tell me if you think that the 
false dependency remove largely fixes this, somewhat fixes it, or doesn't
help.

> Granted, it is hard to keep distributed BK repositories consistent if you
> apply patches out of order, but at the same time, this is how development
> works in real life.  Two solutions I can see to this:
> 
> 1) Allow out-of-order CSET application (maybe with some sort of warning
>    that Linus can turn off, because _every_ CSET he would get would be
>    missing dependencies from somebody's tree).

This one is unlikely to happen, it is a much harder problem technically than
it appears on the surface.

> 2) Allow "proxy" CSETs to be included which say "the changes from adilger
>    adilger@lynx.adilger.int|ChangeSet|20011226061040|56205 changed lines
>    X-Y, Z of file fs/ext2/super.c" but doesn't actually contain those
>    changes, so that the CSET dependency graph is still kept intact.  

In other words, "proxy" == "place holder".  This is doable but it makes
synchronizing repositories quite a bit more complex.  I.e., if I pull
from you and I have place holders and you have the real thing, should
I get 'em or not?  If the answer is always "or not", then this is a 
doable thing.  We'd need to modify the "bk takepatch" code path to do
the right thing when given the real patch but that's doable as well.
Interesting idea, we could do this and it would be relatively fast to
do, like a week or two.

> It would also lose the BK CSET identification, which would tell the
> original submitter (and his local repository) that the patch was applied,

We wouldn't lose it, we'd have to add some extra state to say it is in there
but only as a placeholder, so keep bugging Linus.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
