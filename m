Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278375AbRJWXai>; Tue, 23 Oct 2001 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRJWXa3>; Tue, 23 Oct 2001 19:30:29 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:65292 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278375AbRJWXaO>; Tue, 23 Oct 2001 19:30:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: davidsen@tmr.com (bill davidsen), linux-kernel@vger.kernel.org
Subject: Re: time tells all about kernel VM's
Date: Tue, 23 Oct 2001 19:30:48 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3BD51F02.92B9B7F3@idb.hist.no> <uzjB7.3848$MX4.655317120@newssvr17.news.prodigy.com> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011023233024Z278375-17409+3293@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, now that i think about it.  The reason that the OOM didn't activate 
was because the process wasn't what was going out of control.   ps showed my 
process correctly using the amount of memory i told it to use 128MB.  The 
kernel, itself, created 600MB of buffer that caused it's own death.  The OOM 
cant kill the kernel.  So this problem has nothing to do with tuning the OOM 
to handle locking situations.  It sounds a bit deeper into the VM world than 
that.  


On Tuesday 23 October 2001 19:22, safemode wrote:
> On Tuesday 23 October 2001 15:30, bill davidsen wrote:
> > In article <3BD51F02.92B9B7F3@idb.hist.no>,
> >
> > Helge Hafting <helgehaf@idb.hist.no> wrote:
> > | Any VM with paging _can_ be forced into a trashing situation where
> > | a keypress takes hours to process.  A better VM will take more pressure
> > | before it gets there and performance will degrade more gradually.
> > | But any VM can get into this situation.
> >
> > So far I agree, and that implies that the VM needs to identify and
> > correct the situation.
>
> The real reason i brought this up is because so much trouble was taken to
> implement an OOM handler yet this obviously known and simple situation
> totally bypasses it.  What situation does the OOM handler even work at?  I
> would think that if anything actually tried mapping all of free memory,
> anything else would error out and you'd just move to one of the terminals
> open and kill the process.
> The only situation i can think of that the OOM would come into use is
> leaking memory but isn't that the same situation that I discribed occuring?
>   What's different?   And how is it that the kernel creating 600MB of
> buffer was normal instead of keeping some so my other programs could stay
> alive?  Or would it have not even mattered since there is a problem rooted
> in the vm io subsystem that allows situations like this?
> Also, is the idea of preemption in the VM being thought of for 2.5?  Seems
> like something like that would make this kind of problem mute.
>
> I'm tempted to test out Andrea's vm to see if it locks just as easily.
>
> > | Swapping out whole processes can help this, but it will merely
> > | move the point where you get stuck.  A load control system that
> > | kills processes when response is too slow is possible, but
> > | the problem here is that you can't get people to agree
> > | on how bad is too bad.  It is sometimes ok to leave the machine
> > | alone crunching a big problem over the weekend.  And sometimes
> > | you _need_ response much faster.
> > |
> > | And what app to kill in such a situation?
> > | You had a single memory pig, but it aint necessarily so.
> >
> > I think the problem is not killing the wrong thing, but not killing
> > anything... We can argue any old factors for selection, but I would
> > first argue that the real problem is that nothing was killed because the
> > problem was not noticed.
> >
> > One possible way to recognize the problem is to identify the ratio of
> > page faults to time slice used and assume there is trouble in River City
> > if that gets high and stays high. I leave it to the VM gurus to define
> > "high," but processes which continually block for page fault as opposed
> > to i/o of some kind are an indication of problems, and likely to be a
> > factor in deciding what to kill.
> >
> > I think it gives a fair indication of getting things done or not, and I
> > have said before I like per-process page fault rates as a datam to be
> > included in VM decisions.
