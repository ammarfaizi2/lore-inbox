Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVECWdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVECWdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVECWdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:33:15 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:48024 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261874AbVECWaq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:30:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J/rugzu+V1rTnHTikq59WACn3QhdE9zdbe+LZA6u2UdCaEq5+94gq4FUfEeJBf6wa0EYf3xdy3n1w/Sqg4YLRePTl73hVZf43xWSzvM+VsYWKvBDlZMFZWJhYwUEu6RGEeS7pJRKGHpcbt/e3cH1uYZpT6i1KsL7bc7a6rmBKxg=
Message-ID: <d6e6e6dd050503153056df6afe@mail.gmail.com>
Date: Tue, 3 May 2005 18:30:46 -0400
From: Haoqiang Zheng <haoqiang@gmail.com>
Reply-To: Haoqiang Zheng <haoqiang@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: question about contest benchmark
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505040758.58752.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6e6e6dd05050311115d256213@mail.gmail.com>
	 <200505040758.58752.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

Thanks so much for your response. The confusion was caused by what you
said at http://members.optusnet.com.au/ckolivas/contest/:
"The lower the time (and ratio) the better, and the higher the cpu
percentage the better. ".

>From http://kerneltrap.org/node/465, I also found: "
Time needs to be as low as possible (and therefore ratio as close to 1)
CPU% needs to be as high as possible
Loads needs to be as high as possible
LCPU% needs to be as high as possible.
". 

However, from what you described in the email, this doesn't sound to
be true anymore. I think it will be hard to interpret the results if
it's the "balance" that matters. For example, if CPU% is 40 in case A
and 60 in case B.  If lower is better, then A is better.  If it's
balance that matters, I would say A is about the same as B since in
both case MAX/MIN = 1.5.  (Suppose the total usage is 100%).  So which
answer is correct?

BTW, I like your clarification about interactivity vs. responsiveness.
 But considering the work you have done on improving Linux
interactivity, there's no wonder that people think CONTEST is also an
interactivity benchmark.  :-)

Haoqiang
On 5/3/05, Con Kolivas <kernel@kolivas.org> wrote:
> On Wed, 4 May 2005 04:11, Haoqiang Zheng wrote:
> > I am wondering how we should interpret the CONTEST benchmark results.
> > I tried CONTEST with process_load on 2.6.12-rc3 (single CPU, P4 2.8G,
> > 1G RAM). The CPU usage of kernel compiling is 28.9%, the load consumes
> > 70.1% and the ratio is 3.98.  Based on what Con says, the result is
> > bad since the ratio is high. I did some tracing and found the
> > background load (contest) runs at a dynamic priority of 115-120, which
> > is often higher than the dynamic priority of the kernel compiling
> > processes. This explains why the process_load consumes so much CPU.
> >
> >  My question is why is the result bad at all? One could certainly
> > argue that contest processes shouldn't consume so much CPU time since
> > they are considered to be background jobs. But why is kernel compiling
> > considered foreground jobs? Why making kernel compiling faster is
> > better? Actually, I am wondering if CONTEST is an appropriate
> > benchmark to report system responsiveness at all?
> 
> I don't think in my readme do I say anywhere what is the ideal balance.
> Process_load is a uniquely different load to the other loads which are
> various combinations of cpu and i/o. It spawns processes that wake up, hand
> their data off to another process and go to sleep. Thus the processes behave
> like interactive one with their frequent waiting, but share their effective
> group cpu usage amongst all the process_child processes running so none of
> them is actually seen as cpu bound. Furthermore there are massive numbers of
> context switches between them meaning there is a large in-kernel "system"
> load that is done on behalf of the process_child ren. The purpose of the
> process_load in contest is to ensure that an interactive design is not
> DoS'able by processes behaving like this. Process_load spawns 4 times as many
> processes as the timed 'make' in contest so theoretically ideal cpu balance
> between them should show process_load having 4x as much cpu as the make.
> Because their cpu binding is so intermittent it's hard to balance them
> perfectly. Anyway the balance in your output seems pretty good. When the
> interactive design goes horribly wrong process_load consumes 100 times as
> much cpu as the 'make'.
> 
> >
> >  Any comments?
> >
> >  BTW, what benchmark do you guys use to test system responsiveness?
> 
> Note that interactivity is not responsiveness which some people try to measure
> with contest, and there is still no interactivity benchmark. Responsiveness
> is the ability of the system to continue performing tasks at a reasonable
> pace under various system loads. Interactivity is having low scheduling
> latency and jitter in those tasks where human interaction would notice the
> latency and jitter - and what constitutes and interactive tasks has not been
> quantified although we all know what they are when using the pc.
> 
> Cheers,
> Con
> 
> 
>
