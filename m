Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbRAaAIn>; Tue, 30 Jan 2001 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbRAaAId>; Tue, 30 Jan 2001 19:08:33 -0500
Received: from hermes.mixx.net ([212.84.196.2]:17419 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130092AbRAaAIS>;
	Tue, 30 Jan 2001 19:08:18 -0500
Message-ID: <3A7756F0.8B589FC7@innominate.de>
Date: Wed, 31 Jan 2001 01:06:08 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com>  	<Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> <Mdiqd.A.qe.yEvd6@dinero.interactivesi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:
> 
> ** Reply to message from David Woodhouse
> 
> > Note that this is _precisely_ the reason I'm advocating the removal of
> > sleep_on(). When I was young and stupid (ok, "younger and stupider") I used
> > sleep_on() in my code. I pondered briefly the fact that I really couldn't
> > convince myself that it was safe, but because it was used in so many other
> > places, I decided I had to be missing something, and used it anyway.
> >
> > I was wrong. I was copying broken code. And now I want to remove all those
> > bad examples - for the benefit of those who are looking at them now and are
> > tempted to copy them.
> 
> What is wrong with sleep_on()?

If you have a task that looks like:

    loop:
        <do something important>
        sleep_on(q)

And you do wakeup(q) hoping to get something important done, then if the
task isn't sleeping at the time of the wakeup it will ignore the wakeup
and go to sleep, which imay not be what you wanted.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
