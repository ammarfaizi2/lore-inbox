Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSDVH5y>; Mon, 22 Apr 2002 03:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSDVH5x>; Mon, 22 Apr 2002 03:57:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32143 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314077AbSDVH5w>; Mon, 22 Apr 2002 03:57:52 -0400
Date: Mon, 22 Apr 2002 13:24:03 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
Message-ID: <20020422132403.A1764@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <3CC3B2AA.80217EA0@in.ibm.com> <200204220706.g3M76lm32442@fenrus.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 08:06:47AM +0100, arjan@fenrus.demon.nl wrote:
> In article <3CC3B2AA.80217EA0@in.ibm.com> you wrote:
> 
> > or maybe have a way pass back an error to retry with smaller size.
> > Maybe 2 limits (one that indicates that anything bigger than this is
> > sure to
> > get split, so always break it up, and another that says that anything
> > smaller
> > than this is sure not to be split, so use this size when you can't
> > afford a
> > split).
> 
> Unfortionatly it's not always size that's the issue. For example in my
> code I need to split when a request crosses a certain boundary, and without 
> going into too much detail, that boundary is 62 Kb aligned, not 64
> (for technical reasons ;(). 

Yes, I know .. Size alone isn't the only constraint - this was what 
the earlier grow_bio discussion (about max BIO sizes) was all 
about. Actually, not only that, in cases where the queue already has 
requests which we can merge, even the size the decision gets more complex ...
That's why allowing for the exception cases when we do need to split
seemed like an option to take.

> 
> Size won't catch this and while a 64Kb Kb block will always be split, that
> you can be sure of, even a 4Kb request, if unlucky, can have the need to
> split up.
> 

This would as you observe be caught in alignment checks. The limit
doesn't have to be a fixed size (e.g function of block) or even size 
only thing. Conceptually the question is if it can be generalized into 
a compound worst case constraint through layers of lvm et al (at bind 
time). It could be expressed as multiple checks.

Regards
Suparna
