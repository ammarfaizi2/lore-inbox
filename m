Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWEAINg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWEAINg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 04:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWEAINg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 04:13:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3858 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751332AbWEAINf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 04:13:35 -0400
Date: Mon, 1 May 2006 10:13:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-ID: <20060501081335.GS3570@stusta.de>
References: <20060501071134.GH3570@stusta.de> <20060501001803.48ac34df.akpm@osdl.org> <20060501073514.GQ3570@stusta.de> <20060501003833.340ced5b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501003833.340ced5b.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 12:38:33AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
>...
> > > >  - remove the following unused EXPORT_SYMBOL:
> > > >    - in_egroup_p
> > > >  - remove the following unused EXPORT_SYMBOL_GPL's:
> > > >    - kernel_restart
> > > >    - kernel_halt
> > > 
> > > which I will not.
> > > 
> > > We have a process for the latter.  And even if we ignore that process, the
> > > patch ends up sitting in -mm for ages because of the API change, along with
> > > the cleanups, which could be merged up promptly.
> > 
> > The problem is that we have a lack of a process at the other end:
> > 
> > There is no process to review added exports.
> 
> Yes there is - I and many others frequently query them.  Sure, sometimes
> stuff slips through.  But it's a very very minor problem.

Linus merges dozens of git trees, and we have exactly zero process for 
noticing issues like [1]. Sure, you can say "Adrian will complain", but 
others can complain equally when I unexport a symbol where I either 
missed the in-kernel users or an in-kernel user is just about to be 
submitted.

And where is a non-minor problem with unexports?

If it accidentially breaks in-kernel stuff people notice immediately, 
and if it breaks external modules there is still the point that we do 
not have a stable API for external modules.

And breaking external modules frequently is a _good_ thing since it 
gives people them a reason for submitting their code for inclusion into 
the kernel. LSM/AppArmor is an example for the benefits of threating 
with immediate removal (no matter whether the result will be merging 
AppArmor or a more secure implementation of AppArmor, or whatever else).

cu
Adrian

[1] http://lkml.org/lkml/2006/3/18/127

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

