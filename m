Return-Path: <linux-kernel-owner+w=401wt.eu-S1030377AbXAHWdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbXAHWdx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbXAHWdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:33:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3579 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965038AbXAHWdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:33:52 -0500
Date: Mon, 8 Jan 2007 23:33:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
Message-ID: <20070108223355.GI6167@stusta.de>
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com> <86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com> <20070108005556.GA2542@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0701071708240.3661@woody.osdl.org> <m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com> <m1hcv1ikfj.fsf_-_@ebiederm.dsl.xmission.com> <m1d55pikbc.fsf_-_@ebiederm.dsl.xmission.com> <m18xgdijmb.fsf_-_@ebiederm.dsl.xmission.com> <20070108202105.GB6167@stusta.de> <m1k5zxgplv.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k5zxgplv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 02:45:00PM -0700, Eric W. Biederman wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > On Mon, Jan 08, 2007 at 09:11:24AM -0700, Eric W. Biederman wrote:
> >> 
> >> To a large extent this reverts b026872601976f666bae77b609dc490d1834bf77
> >> while still keeping to the spirits of it's goal, the ability to
> >> make smart guesses about how the timer irq is routed when the BIOS
> >> gets it wrong.
> >>...
> >
> > That's code where every changed line has a great potential of causing a 
> > different kind of breakage on someone else's computer.
> 
> Why does this piece of code give every one the screaming hebie jebies?
> I read it I understand it, it is code.
> 
> This code is not a terribly sensitive delicate heuristic, and Andi has
> already broken it as much as it can possibly be broken.  It's not like
> the code is on a SMP fastpath full of carefully orchestrated races
> that are safe because within certain limits even stale values are ok.
> 
> This is code is straight forward logic, you tell the computer what to
> do and it does it.  Of those things we can do only very few of
> them are correct, and we are seeking to enhance our ability to find
> correct solutions by adding intelligent guesses.  As long as the first
> guess is trust the BIOS the rest of this code is largely a don't
> care.  As Andi proved by breaking all the rest of this.  Or why
> don't I have more testers just crawling out of the wood work,
> screaming for this code to be fixed?
> 
> Plus this code can only cause one type of breakage.   A failure to
> work around a broken BIOS and make the IRQs work.

We just got a completely different bug reported that was confirmed to be 
caused by Andi's patch:
   AMD64/ATI : timer is running twice as fast as it should [1]

> > Your comment therefore translates to "rexvert commit 
> > b026872601976f666bae77b609dc490d1834bf77 for 2.6.20 and try to find a 
> > better solution for 2.6.21".
> 
> If that is the practical translation I am fine with it.
>...
> I really don't care how we do it, or in what timeframe.  But what I have
> posted is the only way I can see of making it better, than what we had
> in 2.6.19.
>...

My whole point is that for 2.6.20, we can live with simply reverting 
Andi's commit.

What to do for 2.6.21 is a completely different story.

> Eric

cu
Adrian

[1] http://bugzilla.kernel.org/show_bug.cgi?id=7789

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

