Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSEOUee>; Wed, 15 May 2002 16:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316482AbSEOUed>; Wed, 15 May 2002 16:34:33 -0400
Received: from bitmover.com ([192.132.92.2]:718 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316446AbSEOUec>;
	Wed, 15 May 2002 16:34:32 -0400
Date: Wed, 15 May 2002 13:34:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org
Message-ID: <20020515133432.D13795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020515130831.C13795@work.bitmover.com> <20020515122003.A13795@work.bitmover.com> <30386.1021456050@redhat.com> <Pine.LNX.4.44.0205150931500.25038-100000@home.transmeta.com> <20020515122003.A13795@work.bitmover.com> <18732.1021493020@redhat.com> <20020515130831.C13795@work.bitmover.com> <19065.1021493737@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 09:15:37PM +0100, David Woodhouse wrote:
> lm@bitmover.com said:
> > It's probably best if you simply view this as a BK limitation which
> > isn't going away any time soon and don't put junk changesets in the
> > middle of your stream of changes.  It's easy enough to export the
> > change you want as a patch, export the comments in the form that bk
> > comments wants, undo the junk changeset, import the patch, and set the
> > comments.  Yeah, it's awkward; consider that a feedback loop which
> > encourages you to think a bit more about what you put in the tree.
> 
> What it actually encourages is for people to have multiple throwaway trees. 
> (Which isn't quite so much of a BK turnoff once you discover compilercache.)

Yup, we use that here, works great.

> If the tree's going to be thrown away anyway, it doesn't matter if it gets 
> confused -- how about making it a little easier to backport changesets -- 
> surely it should be possible to make BK import a changeset iff all the 
> affected files are identical in both trees before the changeset? 

We've already built all the interfaces you need to do this, so would
you be interested in writing the shell script that does it?  The 
interfaces you will want:

	bk export -tpatch
	bk import -tpatch
	bk comments
	bk changes -v

You'll want this, I believe that you can take the output of this command
and feed it into bk comments and have that be a noop.  If that works, this
is what you need to save as the comments part of the patch, and now it's
pretty trivial to move the patch backwards.

bk changes -r+ -vd'### Comments for :GFILE:|+\n$each(:C:){(:C:)\n}'

If you do write this, let me know if you want it included as a "bk backport"
command.  

Also note that there is a `bk bin`/bk.script which is a set of shell script
functions.  Many BK commands start out their life as 

# bk backport - cherry pick a change out of tree A and put it in tree B
# usage: bk backport -r<rev> from to
_backport() {
}

If you start the command with a underscore, then BK will autotranslate that
into a command that you can use like

	bk backport ....

If you prefer a standalone command (for licensing reasons, perhaps), then
make it a standalone shell script, put it in `bk bin`, and bk will find it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
