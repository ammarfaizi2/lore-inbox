Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSEWVhd>; Thu, 23 May 2002 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSEWVhc>; Thu, 23 May 2002 17:37:32 -0400
Received: from [195.39.17.254] ([195.39.17.254]:21915 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317017AbSEWVh3>;
	Thu, 23 May 2002 17:37:29 -0400
Date: Wed, 22 May 2002 19:22:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: Pavel Machek <pavel@suse.cz>,
        "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
        "Gross, Mark" <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:    PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020522192202.D229@toy.ucw.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <200205220748.g4M7mc2157646@northrelay01.pok.ibm.com> <20020522141747.G37@toy.ucw.cz> <200205222043.g4MKhsw06808@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Nice. This also closes another issue pointed out: freezing
> > > a process while it is holding the mmap_sem, which may be needed later
> > > while collecting thread registers on IA64.
> > >
> > > Now that Linus has accepted Pavel's swsusp, do you have any thoughts
> > > on using Pavel's scheme to freeze processes?
> >
> > I attempt half of signal delivery to the threads, but that should not be
> > a problem. Currently freezing stuff is there only for CONFIG_SWSUSP case,
> > but it is probably small enough to be there unconditionaly.
> > 								Pavel
> 
> I think that although my tcore_suspend_threads and Pavel's freeze_processes 
> have similar results, I don't think using Pavel's approach for the core dump 
> is a good idea.
> 
> 1) SMP is a stability problem.  I want TCore to work for 2.4x kernels  
> soon. 
> 2) To avoid the issues with I/O bound threads waking up, Pavel's design waits 
> for the signal to get them running and then drops them in the "refrigerator". 
>  
> My design is explicitly going for the most accurate core dump it can.  
> If I need to wait for processes to wake up and get frozen on a large SMB box 
> then we can loose a lot of accuracy.

Okay.

> I do however; think Pavels work could benefit from using some of my approach. 
>  It might simplify all those places where his patch tests p->state | 
> PK_FREEZE and then calls  refrigerator.   It perhaps make it work better for 
> SMP if software suspend is considered a usefull feature on a SMP systems.

swsusp definitely is usable on SMP system. Take server with not-hotpluggable
pci andpci card you want to add. How do you add it with minimum impact on
users?

suspend/add card/resume
									Pavel
PS: I did not yet test swsusp on SMP, through. But I'd like it to work.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

