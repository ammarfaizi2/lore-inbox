Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317866AbSGVWlh>; Mon, 22 Jul 2002 18:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317867AbSGVWlh>; Mon, 22 Jul 2002 18:41:37 -0400
Received: from bitmover.com ([192.132.92.2]:16047 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S317866AbSGVWlh>;
	Mon, 22 Jul 2002 18:41:37 -0400
Date: Mon, 22 Jul 2002 15:44:43 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020722154443.E19057@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roger Gammans <roger@computer-surgery.co.uk>,
	linux-kernel@vger.kernel.org
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk> <20020722102930.A14802@lst.de> <20020722102705.GB21907@lukas> <20020722152031.GB692@opus.bloom.county> <20020722232941.A10083@computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020722232941.A10083@computer-surgery.co.uk>; from roger@computer-surgery.co.uk on Mon, Jul 22, 2002 at 11:29:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 11:29:41PM +0100, Roger Gammans wrote:
> On Mon, Jul 22, 2002 at 08:20:31AM -0700, Tom Rini wrote:
> > Possibly, once bitkeeper allowes ChangeSets to only depend on what they
> > actually need, not every previous ChangeSet in the repository.  IIRC,
> > this was one of the things Linus asked for, so hopefully it will happen.
> 
> While that would be great.
> 
> With all due respect to Larry and the bk team, I think you'll
> find determining 'needed changesets' in this case is a _hard_ problem.

Thanks, we agree completely.  It's actually an impossible problem
for a program since it requires semantic knowledge of the content
under revision control.  And even then the program can get it wrong
(think about a change which shortens the depth of the stack followed by
a change that won't work with the old stack depth, now you export that
to the other tree and it breaks yet it worked in the first tree).

> Now , bk could make this a little easier by allowing changesets to
> be exported without any dependencies (ala GNU-patch export - but
> with metadata for commit messages).

That's trivial to do, we already have a 'bk export -tpatch -r<rev>' which
does the patch part.  Combine that with 'bk changes -vr<rev>' and you have
what you are talking about on the sending side.  On the receiving side
we have 'bk import -tpatch' and 'bk comments' which do the other half.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
