Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSHCMKX>; Sat, 3 Aug 2002 08:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSHCMKX>; Sat, 3 Aug 2002 08:10:23 -0400
Received: from [157.181.151.9] ([157.181.151.9]:37823 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317537AbSHCMKW>;
	Sat, 3 Aug 2002 08:10:22 -0400
Date: Sat, 3 Aug 2002 13:38:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Zidlicky <rz@linux-m68k.org>, Jeff Dike <jdike@karaya.com>,
       Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: context switch vs. signal delivery [was: Re: Accelerating user mode
 linux]
In-Reply-To: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Aug 2002, Alan Cox wrote:

> The numbers look very different on a real processor. Signal delivery is
> indeed not stunningly fast but relative to a context switch its very low
> indeed.

actually the opposite is true, on a 2.2 GHz P4:

  $ ./lat_sig catch
  Signal handler overhead: 3.091 microseconds

  $ ./lat_ctx -s 0 2
  2 0.90

ie. *process to process* context switches are 3.4 times faster than signal
delivery. Ie. we can switch to a helper thread and back, and still be
faster than a *single* signal.

signals are in essence 'lightweight' threads created and destroyed for the
purpose of a single asynchronous event, it's IMO a very inefficient and
baroque concept for almost anything (but debugging and a number of very
special uses). I'd guess that with a sane threading library a helper
thread is faster for almost everything.

	Ingo

