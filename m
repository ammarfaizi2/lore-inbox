Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbRGQWcZ>; Tue, 17 Jul 2001 18:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbRGQWcP>; Tue, 17 Jul 2001 18:32:15 -0400
Received: from joat.prv.ri.meganet.net ([209.213.80.2]:1743 "EHLO
	joat.prv.ri.meganet.net") by vger.kernel.org with ESMTP
	id <S267518AbRGQWcM>; Tue, 17 Jul 2001 18:32:12 -0400
Message-ID: <3B54BD3C.A8E1E47F@ueidaq.com>
Date: Tue, 17 Jul 2001 18:33:32 -0400
From: Alex Ivchenko <aivchenko@ueidaq.com>
Organization: UEI, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 possible problem
In-Reply-To: <Pine.LNX.3.95.1010717153319.6035A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick,

"Richard B. Johnson" wrote:
> 
> On Tue, 17 Jul 2001, Linus Torvalds wrote:
> 
> > In article <Pine.LNX.3.95.1010717103652.1430A-100000@chaos.analogic.com>,
> > Richard B. Johnson <root@chaos.analogic.com> wrote:
> > >
> > >    ticks = 1 * HZ;        /* For 1 second */
> > >    while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
> > >                  ;
> >
> > Don't do this.
> >
> > Imagine what happens if a signal comes in and wakes you up? The signal
> > will continue to be pending, which will make your "sleep loop" be a busy
> > loop as you can never go to sleep interruptibly with a pending signal.

Sleep like this is useless in real code. You either want your ioctl to unblock
when event (or time-out) happens or use sleep function to make driver wait certain 
amount of time (if you need to access poorly-designed hardware).

Off-topic:

>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
Well, give 'em at least some credit for copycating :-)
As a system architect I would say a *good* copycating.

For example:

Win32 events (CreateEvent(), WaitForxxxObject()) are very useful things.
The whole reason I was asking my questions is because I want to emulate Win32-like
event mechanism it Linux driver. I wouldn't mind to have this mechanism built into
Linux kernel. 

Say, one of the user process threads calls:
ret = WaitForSingleObject(hObject, dwTimeoutms);
or
ret = WaitForMultipleObjects(nNumber, hObjects[], FALSE, dwTimeoutms);

and waits until time-out or one (or more) objects are set.

>From the driver side you call:
KeSetEvent(hNotifyEvent, (KPRIORITY)1, FALSE);
when you want to release object.

It's very useful.
For example, with our hardware I can have up to 16*4 = 64 totally separated 
subsystems. Each subsystem can fire event asynchronously. It's much easier to
control each subsystem in separate thread and Win32 events are very handy.

-- 
Regards,
Alex

--
Alex Ivchenko, Ph.D.
United Electronic Industries, Inc.
"The High-Performance Alternative (tm)"
--
10 Dexter Avenue
Watertown, Massachusetts 02472
Tel: (617) 924-1155 x 222 Fax: (617) 924-1441
http://www.ueidaq.com
