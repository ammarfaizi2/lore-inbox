Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSAGWNC>; Mon, 7 Jan 2002 17:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSAGWMx>; Mon, 7 Jan 2002 17:12:53 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6931 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287284AbSAGWMo>; Mon, 7 Jan 2002 17:12:44 -0500
Date: Mon, 7 Jan 2002 14:17:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matthias Hanisch <mjh@vr-web.de>
cc: Mikael Pettersson <mikpe@csd.uu.se>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <Pine.LNX.4.10.10201072236430.238-100000@pingu.franken.de>
Message-ID: <Pine.LNX.4.40.0201071415260.1612-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Matthias Hanisch wrote:

> On Mon, 7 Jan 2002, Davide Libenzi wrote:
>
> > In sched.c::init_idle() :
> >
> > current->dyn_prio = -100;
> >
> > Let me know.
>
> Aehm. I already added the same line at the beginning of cpu_idle() in
> arch/i386/process.c, which brought back the old performance. Your patch
> should be analogous, but cleaner.
>
> So: Bingo!!!!
>
> I just wonder, why only two people with slow machines saw this behavior...
>
> Now 2.5.2 can come :)

The problem is that slow machines shows different dyn_prio distribution.
What happened was that if a process with dyn_prio == was wake up while the
idle was running, preemption_goodness() failed to kick out the idle ( with
dyn_prio == 0 ) because of the strict > 0




- Davide


