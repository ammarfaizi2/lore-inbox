Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279612AbRJ2XTA>; Mon, 29 Oct 2001 18:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279610AbRJ2XSv>; Mon, 29 Oct 2001 18:18:51 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63665 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S279609AbRJ2XSk>; Mon, 29 Oct 2001 18:18:40 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jan Kara <jack@suse.cz>
Date: Tue, 30 Oct 2001 10:23:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15325.58603.350619.609850@notabene.cse.unsw.edu.au>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: message from Jan Kara on Monday October 29
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au>
	<20011024171658.B10075@atrey.karlin.mff.cuni.cz>
	<15319.12709.29314.342313@notabene.cse.unsw.edu.au>
	<20011025174815.C4644@atrey.karlin.mff.cuni.cz>
	<15320.59456.565780.111066@notabene.cse.unsw.edu.au>
	<20011029150602.G11994@atrey.karlin.mff.cuni.cz>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 29, jack@suse.cz wrote:
> > 
> > I accept that it does look like a bit of a hack.
> > But I think it is simple, understandable, and predictable.
> > And I think that (for me) the value of tree quotas is more than enough
> > to offset that cost.
>   I just don't like the idea that when you do lookup you can suddenly get
> Disk quota exceeded... I'd concern this behaviour a bit nonintuitive. I agree
> that if root makes lookup of every file after moving directories then this
> doesn't happen but still I don't like the design :).
> 

You cannot get "Disk quota exceeded" on a lookup. If treequota_check
finds a discrepancy it fixes it with "notify_change" with
ia_valid set to ATTR_FORCE | ATTR_TID.
I changed quota_transfer to take ATTR_FORCE to mean "just do it, even
if it exceeds quota, and don't give an error".   Given that ATTR_FORCE
is not actually used at all in the current kernel, I felt fairly free
to interpret it how I wanted.

So the only non-intuitive thing that can happen is that you find your
usage mysteriously changes.  However this can only happen after
administrator intervention, and with uid quotas administrator
intervention (e.g. chown -R) can equally cause mysterious changes of
usage.


However I'm not particularly trying to convince anyone to use or
approve of tree-quotas.  I was after comments to make sure that I
hadn't missed something in thinking through the issues.  I thank you
and others for your comments.  The fact that I am comfortable with my
answers (though you may not be) encourages me that I haven't missed
anything.

I will be using treequotas locally next year and will keep the
patches on my web-page up-to-date.  I have heard from at least one
person who thinks they might be useful, so there are probably a few
dozen who might find it useful.
In 6-12 months, if my experience is all positive, I might try
suggesting that they get included in a "standard" kernel (assuming
that 2.5 has openned by then:-).

Thanks again,
NeilBrown
