Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277551AbRJETMU>; Fri, 5 Oct 2001 15:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277552AbRJETMK>; Fri, 5 Oct 2001 15:12:10 -0400
Received: from ns.suse.de ([213.95.15.193]:15889 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277551AbRJETMI>;
	Fri, 5 Oct 2001 15:12:08 -0400
Date: Fri, 5 Oct 2001 21:12:35 +0200
From: Andi Kleen <ak@suse.de>
To: Padraig Brady <padraig@antefacto.com>
Cc: Andi Kleen <ak@suse.de>, Alex Larsson <alexl@redhat.com>,
        Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
Message-ID: <20011005211235.A16163@gruyere.muc.suse.de>
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de> <3BBDAB24.7000909@antefacto.com> <20011005150144.A11810@gruyere.muc.suse.de> <3BBDB26D.2050705@antefacto.com> <20011005163807.A13524@gruyere.muc.suse.de> <3BBDCAF8.6070705@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBDCAF8.6070705@antefacto.com>; from padraig@antefacto.com on Fri, Oct 05, 2001 at 04:00:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 04:00:08PM +0100, Padraig Brady wrote:
> Andi Kleen wrote:
> 
> >>>Another advantage of using the real time instead of a counter is that 
> >>>you can easily merge the both values into a single 64bit value and do
> >>>arithmetic on it in user space. With a generation counter you would need 
> >>>to work with number pairs, which is much more complex. 
> >>>
> >>??
> >>if (file->mtime != mtime || file->gen_count != gen_count)
> >>     file_changed=1;
> >>
> >
> >And how would you implement "newer than" and "older than" with a generation
> >count that doesn't reset in a always fixed time interval (=requiring
> >additional timestamps in kernel)?  
> >
> >-Andi
> >
> Well IMHO "newer than", "older than" applications have until now
> done with second resolution, and that's all that's required?

No they haven't. GNU make supports nsec mtime on Solaris and apparently
some other OS too, because the second granuality mtime can be a big 
problem with make -j<bignumber> on a big SMP box. make has to distingush
"is older" from "is newer"; "not equal" alone doesn't cut it.

[If you think it is modify your make to replace the "is older" check
for dependencies with "is not equal" and see what happens]



-Andi
