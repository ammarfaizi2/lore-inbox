Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbVJ1Sz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbVJ1Sz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbVJ1Sz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:55:27 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:32337 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751651AbVJ1Sz0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:55:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVH7be+WO4GLLXUYAJWoVE97vcm1F+PQAa32v4jSKH3QB9peI4cOjE8J/PlZTzwLxxYTtNccwExn6/KxATvg+o7Li3dt2y28XSkEzU1kJXqzZ8Bg8bXtYom/VET9hDPxwm2mvZUolgEpwll+tB79Qjb3CF28Rb+nuginL9QWwTo=
Message-ID: <5bdc1c8b0510281155w2b86be0bp9f85de02b806d664@mail.gmail.com>
Date: Fri, 28 Oct 2005 11:55:26 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Overruns are killing my recordings.
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1130525006.4363.44.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com>
	 <200510271528.28919.diablod3@gmail.com>
	 <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
	 <1130447216.19492.87.camel@mindpipe>
	 <3aa654a40510271700l49fb06cfv37d8b6030df5ac49@mail.gmail.com>
	 <1130470852.4363.26.camel@mindpipe>
	 <5bdc1c8b0510280752y5b7a665cpfdd512d15f896482@mail.gmail.com>
	 <1130525006.4363.44.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-10-28 at 07:52 -0700, Mark Knecht wrote:
> > On 10/27/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > > On Thu, 2005-10-27 at 17:00 -0700, Avuton Olrich wrote:
> > > > aggh. Sorry for all the noise,
> > > >
> > > > I have all my drives on a linear raid and I had hdparm set to put my
> > > > IDE drives to sleep after a while, I didn't put it together because it
> > > > was happening in the middle of recording.
> > >
> > > Hey, I think it's a testament to the progress that has been made in the
> > > past year and a half that people now consider audio dropouts in a "known
> > > good" app like ecasound to be a kernel bug.  For the longest time the
> > > answer was "linux isn't an RTOS, deal with it".
> > >
> > > Lee
> >
> > Lee, et. all,
> >    Could this possibly be part of what is causing my xrun problems? I
> > had a huge rash of xruns yesterday. I seem to run into issues after
> > longer times of inactivity. I hadn't considered this possibility
> > before.
>
> I really doubt it.  It's more likely that the xruns are caused by a bug
> in the new ktimers system.  I am seeing "xruns" here too with -rt1, but
> the latency tracer does not report anything over ~120 usecs.  Previous
> to all the ktimers/HRT stuff going in, I was xrun free for months.
>
> The reason I think it's a ktimers bug is because sometimes JACK reports
> an xrun of negative length which I'd NEVER seen before.
>
> I suspect this might all be fixed in the latest -rt patch but I have not
> had time to build it.
>
> Lee

OK then I'll just hang tinght. I've not seen any response on the email
I sent about 2.6.14-rc5-rt7. I cannot build it. It fails like this:

CC      arch/x86_64/kernel/sys_x86_64.o
 CC      arch/x86_64/kernel/x8664_ksyms.o
 CC      arch/x86_64/kernel/i387.o
 CC      arch/x86_64/kernel/syscall.o
 CC      arch/x86_64/kernel/vsyscall.o
arch/x86_64/kernel/vsyscall.c:57: error: `SEQLOCK_UNLOCKED' undeclared
here (not in a function)
make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
lightning linux #

This is a new failure here since -rc5-rt3.
