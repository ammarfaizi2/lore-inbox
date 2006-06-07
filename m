Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWFGH3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWFGH3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWFGH33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:29:29 -0400
Received: from unthought.net ([212.97.129.88]:47630 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751101AbWFGH33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:29:29 -0400
Date: Wed, 7 Jun 2006 09:29:28 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc6
Message-ID: <20060607072928.GR15032@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Bill Davidsen <davidsen@tmr.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org> <20060606120701.GP5132@hjernemadsen.org> <1149607627.30804.5.camel@localhost> <4485AED0.9030004@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4485AED0.9030004@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 12:35:28PM -0400, Bill Davidsen wrote:
> Trond Myklebust wrote:
> >On Tue, 2006-06-06 at 14:07 +0200, Klaus S. Madsen wrote:
> >>Hi,
> >>
> >>We still experience the NFS client slow down reported by Jakob
> >>Østergaard in http://lkml.org/lkml/2006/3/31/82, even with 2.6.17-rc6.
> >>
> >>Trond Myklebust have created a patch which we have verified solves this
> >>problem for 2.6.16, 2.6.17-rc4 and 2.6.17-rc6. The patch is available
> >>from http://lkml.org/lkml/2006/4/24/320, and as an attachment to
> >>bugzilla bug 6557.
> >
> >The patch is already queued up for inclusion in 2.6.18. I'm not planning
> >on submitting it for 2.6.17 since it is not a critical bug.
> 
> I guess that depends on how much it slows down and how much you depend 
> on the speed of NFS. I have all of my machines sharing some local 
> binaries and docs, but the files are typically small and the network is 
> gigE, so I doubt it will hurt me. 

It hurts writing, not reading.  And only certain cases of writing.

But when it hurts it hurts quite a bit; slowdown is 10-20 times and gigE
most likely won't matter.

> On the other hand I do know people 
> running workstations with virtually everything NFS mounted, working with 
> large image files.
> 
> The initial bug report makes it look as if it's about two orders of 
> magnitude slower, but doesn't quantify the effect on more common 
> sequential access operations.

Sequential read and write seems to be fine. At least from my testing.

This was what made this so weird; normal testing with dd or bonnie etc.
showed all was fine. But link jobs over NFS were unreasonably slow.
Turned out you needed a somewhat special read/write pattern (similar to
ld) to trigger the slowdown.

So I guess it's probably mostly people who do development over NFS who
are hurt - and then only those who produce rather large executables.

> If this becomes an issue in 2.6.17, I hope it will show up in -stable 
> before 2.6.18, the current development cycle is a bit, um, protracted... 
> lately.

Me too :)

-- 

 / jakob

