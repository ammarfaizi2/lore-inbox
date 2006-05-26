Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbWEZHZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbWEZHZi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbWEZHZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:25:38 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:62397 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1030511AbWEZHZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:25:37 -0400
Message-ID: <348628334.03674@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 15:25:38 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Iozone <capps@iozone.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptive read-ahead
Message-ID: <20060526072538.GF5135@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Iozone <capps@iozone.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <6fZJ5-3Q6-25@gated-at.bofh.it> <07f101c67f3f$00808e10$fd00000a@americas.hpqcorp.net> <348524370.23988@ustc.edu.cn> <0e7301c67faf$1e09c940$fd00000a@americas.hpqcorp.net> <348554141.03521@ustc.edu.cn> <0ee101c68002$8ee06b80$fd00000a@americas.hpqcorp.net> <348604194.10648@ustc.edu.cn> <104a01c6806f$4be100c0$fd00000a@americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104a01c6806f$4be100c0$fd00000a@americas.hpqcorp.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Capps,

On Thu, May 25, 2006 at 09:51:32PM -0500, Iozone wrote:
> >On Thu, May 25, 2006 at 08:53:09AM -0500, Iozone wrote:
> >>Wu Fengguang,
> >>
> >>   I noticed someone asking for real-world examples
> >>   where a novel read-ahead would be helpful.
> >>
> >>   Ok... 
> >>
> >>   Examples:
> >>
> >>       Structural analysis codes:
> >>           Writes large files, forward sequential.
> >>           then reads them backwards.
> >>
> >>       Weather codes:
> >>           Input from vertical scanning radar is written
> >>           to a file, then the file is processed by strata.
> >>           (Written in column order, read in row order..
> >>             thus a strided reader)
> >
> >Precious data! Thanks very much.
> 
>        The next time you get in your car, or on an airplane,
>        remember that the structural design was done using
>        the structures codes. Without these codes, people
>        , to put it simply, would die.  Also these codes permit 
>        molecular modeling that increases material strength of 
>        the design while reducing weight and cost.  GM, Ford, 
>        AirBus, Boing, and many others run these codes every hour
>        of every day. Yes, they are important, really :-)
> 
>        Without the weather codes, folks would not have
>        received early notification of the tornados, again
>        it's pretty important to those programs :-)
>    
>        Humorus note: Golf club manufacturers are also using
>        structure codes to design better clubs that help bad
>        golfers hit the ball further... Not exactly a noble goal,
>        but yet another example of the critical competitive 
>        nature of the business world and their depencency
>        on structural analysis codes :-)
 
Wow...

> >>       It was the study of these codes that lead to the inclusion
> >>       of Iozone's backwards reader, and strided reader
> >>       test cases :-)
> >>
> >>       If your system does not have a novel read-ahead 
> >>       algorithm then these types of applications will blind
> >>       side the traditional read-ahead algorithm and the 
> >>       performance will be unacceptable.
> >
> >Till now I have not implemented the strided readahead feature.
> >Maybe we should tamp the existing features first :)
> 
>        Or, you could implement the strided feature, as it's
>        pretty easy to detect.  Just need to trigger on two
>        equa-distance accesses: A -> B and B -> C  where
>        C-B = B-A then  the prediction D is C + distance between 
>        A->B or B->C.
>        The math turns out to be  easy to optimize:
>            D= C+(B-A) 
>        for both forward and backward strided readers. 
> 
>        Example:
>        A = 1, B = 3  C=5
> 
>        Forward strided reader reading 1, 3, 5 -> predict 7
>        3-1=2  and 5-3 = 2 and therefore  predict 5+2 = 7
>        or going backwards,  reading 7,5, 3 -> predict 1
>        5-7 = -2 and 3-5 = -2 and  3 + (-2) = 1 ... Cool huh :-)

Maybe it's useful for HPC applications, too. I'll consider it on
time of convenient.  Though it can still be tricky for implementing.
So I'd concentrate on the top-priority thing first: to stabilize the
existing features, so that the majority can enjoy them earlier.

>        Hmmm, I still remember what I wrote 8 years ago... Now that's 
>        amazing.  I can't remember what I had for breakfast today,
>        but this stuff seems fresh in memory banks :-)  (weird)

It's a lucky thing for you to do it 8 years ago ;-)

Thanks,
Wu
