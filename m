Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSFCVHt>; Mon, 3 Jun 2002 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSFCVHt>; Mon, 3 Jun 2002 17:07:49 -0400
Received: from [195.223.140.120] ([195.223.140.120]:4456 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315539AbSFCVHs>; Mon, 3 Jun 2002 17:07:48 -0400
Date: Mon, 3 Jun 2002 23:07:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Andi Kleen <ak@muc.de>,
        linux-kernel@vger.kernel.org, icollinson@imerge.co.uk
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Message-ID: <20020603210718.GN1172@dualathlon.random>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04> <20020531112847.B1529@w-mikek2.des.beaverton.ibm.com> <m37kljkjys.fsf@averell.firstfloor.org> <20020603090328.A1581@w-mikek2.des.beaverton.ibm.com> <3CFBCCB1.A8F7D16B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 01:08:17PM -0700, Andrew Morton wrote:
> Mike Kravetz wrote:
> > 
> > ...
> > Seems that this tells people to leave a high priority real-
> > time shell running on the console.  However, if one can not
> > get to the console, then there is no point in leaving a high
> > priority shell running there.  Part of the problem may be
> > in the definition of 'console'.  Different console implementations
> > behave differently.
> > 
> > Is this something we should 'fix'?  I would envision a 'solution'
> > for each console implementation.  OR we could remove the above
> > from the man page. :)
> > 
> 
> keventd is a "process context bottom half handler".  It's designed
> for use by interrupt handlers for handing off awkward, occasional
> things which need process context.  For example, device hotplugging,
> which was the original reason for its introduction.
> 
> So it makes sense to give keventd SCHED_RR policy and maximum
> priority.  Which should fix this problem as well, yes?
> 
> keventd is also being (ab)used for performing disk I/O.
> You know who you are ;)  But even given that, I don't expect
> that elevating its policy&priority will cause any problems.

that's correct, infact that's almost required, kupdate also doesn't have
RT prio and inodes are flushed either by kupdate or keventd.

Andrea
