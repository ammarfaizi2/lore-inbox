Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279951AbRJ3Mcy>; Tue, 30 Oct 2001 07:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279950AbRJ3Mcr>; Tue, 30 Oct 2001 07:32:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45071 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279947AbRJ3Mck>; Tue, 30 Oct 2001 07:32:40 -0500
Date: Tue, 30 Oct 2001 13:33:09 +0100
From: Jan Kara <jack@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011030133309.F6302@atrey.karlin.mff.cuni.cz>
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au> <20011024171658.B10075@atrey.karlin.mff.cuni.cz> <15319.12709.29314.342313@notabene.cse.unsw.edu.au> <20011025174815.C4644@atrey.karlin.mff.cuni.cz> <15320.59456.565780.111066@notabene.cse.unsw.edu.au> <20011029150602.G11994@atrey.karlin.mff.cuni.cz> <15325.58603.350619.609850@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15325.58603.350619.609850@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday October 29, jack@suse.cz wrote:
> > > 
> > > I accept that it does look like a bit of a hack.
> > > But I think it is simple, understandable, and predictable.
> > > And I think that (for me) the value of tree quotas is more than enough
> > > to offset that cost.
> >   I just don't like the idea that when you do lookup you can suddenly get
> > Disk quota exceeded... I'd concern this behaviour a bit nonintuitive. I agree
> > that if root makes lookup of every file after moving directories then this
> > doesn't happen but still I don't like the design :).
> > 
> 
> You cannot get "Disk quota exceeded" on a lookup. If treequota_check
> finds a discrepancy it fixes it with "notify_change" with
> ia_valid set to ATTR_FORCE | ATTR_TID.
> I changed quota_transfer to take ATTR_FORCE to mean "just do it, even
> if it exceeds quota, and don't give an error".   Given that ATTR_FORCE
> is not actually used at all in the current kernel, I felt fairly free
> to interpret it how I wanted.
  Hmm.. I should have read your patch more carefuly.. Sorry. 

> So the only non-intuitive thing that can happen is that you find your
> usage mysteriously changes.  However this can only happen after
> administrator intervention, and with uid quotas administrator
> intervention (e.g. chown -R) can equally cause mysterious changes of
> usage.
> 
> However I'm not particularly trying to convince anyone to use or
> approve of tree-quotas.  I was after comments to make sure that I
> hadn't missed something in thinking through the issues.  I thank you
> and others for your comments.  The fact that I am comfortable with my
> answers (though you may not be) encourages me that I haven't missed
> anything.
> 
> I will be using treequotas locally next year and will keep the
> patches on my web-page up-to-date.  I have heard from at least one
> person who thinks they might be useful, so there are probably a few
> dozen who might find it useful.
  :) I also think tree quotas are useful I'd just like to think of some
nicer solution...:)

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
