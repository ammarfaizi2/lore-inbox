Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279940AbRJ3MOY>; Tue, 30 Oct 2001 07:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279938AbRJ3MOO>; Tue, 30 Oct 2001 07:14:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56841 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279936AbRJ3MOG>; Tue, 30 Oct 2001 07:14:06 -0500
Date: Tue, 30 Oct 2001 13:14:31 +0100
From: Jan Kara <jack@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops: Quota race in 2.4.12?
Message-ID: <20011030131431.B6302@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011028215818.A7887@netnation.com> <15325.60309.91155.683380@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15325.60309.91155.683380@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Sunday October 28, sim@netnation.com wrote:
> > Some of our dual CPU web servers with 2.4.12 are Oopsing while running
> > quotacheck.  They don't seem to die immediately, but oops many times and
> > eventually break.  The old tools didn't warn about quotachecking on a
> > live file system, so some of our servers were set up to run quotacheck
> > nightly.  The new tools still allow you to do it, but warn that it may
> > not be consistent.  We didn't have any problems with 2.2 kernels.
> 
> quotacheck cannot be reliable on a live system as it scans through the
> filesystem counting the usage for each user and then updates the
> quotas file.  If usage changes between scanning a file and updating
> the quota record, you get an error.   This is particularly a problem
> if quotacheck takes a long time, and on one of my servers (heavily
> loaded NFS server) quotacheck takes a *long* time if the server is
> live (it isn't exactly quick if it isn't live either).
> 
> I wrote a little program which uses libext2fs to scan the block device
> for inodes and add up usage that way (as opposed to walking the
> filetree as I believe quotacheck does).  It runs *much* faster
> (minutes instead of hours).
  Note that quotacheck(8) uses e2fslib too if compiled properly...

								Honza

> 
