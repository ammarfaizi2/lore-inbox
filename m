Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTIITZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTIITYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:24:05 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:55472 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S264389AbTIITW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:22:59 -0400
Subject: Re: Panic when finishing raidreconf on 2.4.0-test4 with preempt
From: Chris Meadors <clubneon@hereintown.net>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030909181131.GB9079@unthought.net>
References: <1062883950.1341.26.camel@clubneon.clubneon.com>
	 <20030909181131.GB9079@unthought.net>
Content-Type: text/plain
Message-Id: <1063135290.1119.32.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 09 Sep 2003 15:21:31 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19wo4o-0001TE-P3*y5UwhWHfA1A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-09 at 14:11, Jakob Oestergaard wrote:

> raidreconf does no "funny business" with the kernel, so I think this
> points to either:
> *) a bug which mkraid can trigger as well
> *) an API change combined with missing error handling, which raidreconf
>    now triggers (by calling the old API)
> *) a more general kernel bug - there is a *massive* VM load when
>    raidreconf does its magic, perhaps calling mkraid after beating
>    the VM half way to death can trigger the same error?
> 
> raidreconf, upon complete reconfiguration, will set up the new
> superblock for you array, mark it as "unclean", and add the disks one by
> one.  Once all disks are added, the kernel should start calculating
> parity information (because raidreconf does not do this during the
> conversion, and hence marks the newly set up array as unclean in order
> to have the kernel do this dirty work).
> 
> There should be nothing special about this, compared to normal mkraid
> and raidhotadd usage - except raidreconf is probably a lot more likely
> to trigger races.
> 
> Ah, fingerpointing  ;)
> 
> (/me sits back, confident that his code is perfect and the kernel alone
>  is to blame)

I'll mess around this evening a bit if I get a chance.  I really wasn't
in the mood to see this error again (losing five years worth of data can
do that to a person, but I've come to terms (with my own arrogance and
stupidity, along with the data loss (just old e-mails and pictures, but
stuff that is nice to hold onto anyway)) and pre-ordered Plextor's new
DVD burner). But that does leave me with a few blank drives that I can
beat on all anyone needs.

I'll be putting -test5 on first.  I had planned on disabling the
preempt, but since that was reported in the oops, I'll leave it on.

I initially ran my mkraid under 2.4.20, but I'll see how it does with
2.6.0-test5.  I'll mkraid on a 4 drive RAID5 setup, and see if it
completes.  Then raidreconf it to 5 drives.  I'll scribble down the oops
this time too, if I see it again.

Anything else anyone wants me to try?  Or other data to fill in blanks?

-- 
Chris

